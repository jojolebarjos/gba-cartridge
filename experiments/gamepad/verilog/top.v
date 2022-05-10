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
    inout [15:0] AD, // Cartridge bus

    // SPI
    output MISO, // Master In Slave Out
    input MOSI, // Master Out Slave In
    input SCK, // Serial Clock
    input SS // Slave Select
);

    // Drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    // Instanciating PLL to reach higher frequency
    wire PLL_CLK;
    wire LOCK;
    SB_PLL40_CORE #(
        .FEEDBACK_PATH("SIMPLE"),
        .PLLOUT_SELECT("GENCLK"),
        .DIVR(4'b0000),
        .DIVF(7'b0000100),
        .DIVQ(3'b000),
        .FILTER_RANGE(3'b001)
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
    reg [2:0] WR_history;

    // Update shift registers at each rising edge
    always @(posedge PLL_CLK)
    begin
        CS_history <= {CS_history[1:0], CS};
        RD_history <= {RD_history[1:0], RD};
        WR_history <= {WR_history[1:0], WR};
    end

    // Non-trivial I/O buffer handled using primitive
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

    // Internal register for key input
    reg [15:0] register;

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

            // On WR falling-edge, cartridge stores (if desired) the data on the bus
            if (WR_history[2:1] == 2'b10) begin
                if (address == 16'b0000010000000000)
                    register <= A;
            end

            // On RD&WR rising-edge, latched address is incremented
            if ((RD_history[2:1] == 2'b01) | (WR_history[2:1] == 2'b01)) begin
                address <= address + 1;
            end
        end
    end

    // Turn on the LED if there is any button pressed
    //assign LED = ~register[9:0] != 0;
    assign LED = register[0];

    // Instanciate SPI module
    // Note: incoming data is ignored, we just reply the register state
    wire [15:0] RX;
    wire RDY;
    spi port (PLL_CLK, SCK, MOSI, MISO, SS, register, RX, RDY);

endmodule
