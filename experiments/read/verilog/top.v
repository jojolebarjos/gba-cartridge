// Look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (

    // TinyFPGA BX
    input CLK, // 16MHz clock
    output USBPU, // USB pull-up resistor
    output LED, // User/boot LED next to power LED

    // GBA
    input CS,
    input RD,
    input WR, // Ignored in this example
    inout [15:0] AD // Cartridge bus
);

    // Drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    // Turn off the LED
    assign LED = 0;

    // The main challenge is that we cannot use GBA control signals as-is to
    // drive our flip-flops (i.e. cannot synthesize on improper clock signals).
    // Therefore, we will use the internal clock at a faster rate, and check for
    // changes in these signals.

    // Instanciating PLL to reach higher frequency. For a simple one, the frequency
    // is computed as follow:
    //   F_PLL = F_CLK * (DIVF + 1) / (2 ** DIVQ * (DIVR + 1))
    // The GBA is running at 16.78MHz, so we need at least four times that:
    //   DIVF = 4
    //   DIVQ = 0
    //   DIVR = 0
    // -> F_PLL = 80MHz
    wire PLL_CLK;
    wire LOCK; // unused
    SB_PLL40_CORE #(
        .FEEDBACK_PATH("SIMPLE"),
        .PLLOUT_SELECT("GENCLK"),
        .DIVR(4'b0000),
        .DIVF(7'b0000100),
        .DIVQ(3'b000),
        .FILTER_RANGE(3'b001),
    ) uut (
        .REFERENCECLK(CLK),
        .PLLOUTCORE(PLL_CLK),
        .LOCK(LOCK),
        .RESETB(1'b1),
        .BYPASS(1'b0)
    );

    // Internal 2KB ROM (actual file may be a bit smaller)
    reg [15:0] ROM [0:1023];

    // Load data from hexadecimal file
    initial begin
        $readmemh("../rom/rom.hex", ROM);
    end

    // Three-stages shift register, used to get synchronous notification of an
    // asynchronous edge
    reg [2:0] CS_history;
    reg [2:0] RD_history;

    // Update shift registers at each rising edge
    always @(posedge PLL_CLK)
    begin
        CS_history <= {CS_history[1:0], CS};
        RD_history <= {RD_history[1:0], RD};
    end

    // Non-trivial I/O buffer handled using primitive
    // Note: cartridge writes only when read is requested
    wire [15:0] A;
    reg [15:0] D;
    SB_IO #(
        .PIN_TYPE(6'b1010_01),
        .PULLUP(1'b0)
    ) AD_io [15:0] (
        .PACKAGE_PIN(AD),
        .OUTPUT_ENABLE(~RD),
        .D_OUT_0(D),
        .D_IN_0(A)
    );

    // Buffered address
    reg [15:0] address;

    // Cartridge logic
    always @(posedge PLL_CLK) begin

        // On CS falling-edge, latch address
        if (CS_history[2:1] == 2'b10) begin
            address <= A;
        end

        // When CS is low, communication is happening with ROM
        else begin if (~CS_history[1])

            // On RD falling-edge, cartridge fetches the data and outputs to the bus
            if (RD_history[2:1] == 2'b10) begin
                D <= ROM[address[9:0]];
            end

            // On RD rising-edge, latched address is incremented
            if (RD_history[2:1] == 2'b01) begin
                address <= address + 1;
            end
        end
    end

endmodule
