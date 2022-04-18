// Look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (

    // TinyFPGA BX
    input CLK, // 16MHz clock
    output USBPU, // USB pull-up resistor
    output LED, // User/boot LED next to power LED

    // Cartridge
    output reg CS,
    output reg RD,
    output WR,
    inout [15:0] AD, // Cartridge bus

    // SPI
    output MISO, // Master In Slave Out
    input MOSI, // Master Out Slave In
    input SCK, // Serial Clock
    input SS // Slave Select
);

    // Drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    // Turn off the LED
    assign LED = SCK;

    // We never write anything to the cartridge
    assign WR = 1;

    // Non-trivial I/O buffer handled using primitive
    reg [15:0] A;
    wire [15:0] D;
    SB_IO #(
        .PIN_TYPE(6'b1010_01),
        .PULLUP(1'b0)
    ) AD_io [15:0] (
        .PACKAGE_PIN(AD),
        .OUTPUT_ENABLE(RD),
        .D_OUT_0(A),
        .D_IN_0(D)
    );

    // Instanciate SPI module
    reg [15:0] TX;
    wire [15:0] RX;
    wire RDY;
    spi port (CLK, SCK, MOSI, MISO, SS, TX, RX, RDY);

    // State machine is handled by master, here we just forward instructions
    reg wait_for_address;
    always @(posedge CLK) begin

        // Whenever a byte is received from SPI
        if (RDY) begin
            wait_for_address <= 0;

            // Special case: we are expecting an address from master
            if (wait_for_address) begin
                A <= RX;
                TX <= RX;
            end

            // Otherwise, this is a command
            else begin
                case (RX)

                // Set address
                16'b0000000000000001: begin
                    wait_for_address <= 1;
                    TX <= 0;
                end

                // Latch
                16'b0000000000000010: begin
                    CS <= 0;
                    TX <= 0;
                end

                // Stop
                16'b0000000000000011: begin
                    CS <= 1;
                    TX <= 0;
                end

                // Read
                16'b0000000000000100: begin
                    RD <= 0;
                    TX <= 0;
                end

                // Step
                16'b0000000000000101: begin
                    RD <= 1;
                    TX <= D;
                end

                endcase
            end
        end
    end

endmodule
