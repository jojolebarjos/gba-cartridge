// Look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (

    // TinyFPGA BX
    input CLK, // 16MHz clock
    output USBPU, // USB pull-up resistor
    output LED, // User/boot LED next to power LED

    // Cartridge
    output CS,
    output RD,
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

    // Non-trivial I/O buffer handled using primitive
    reg AD_write;
    reg [15:0] AD_out;
    wire [15:0] AD_in;
    SB_IO #(
        .PIN_TYPE(6'b1010_01),
        .PULLUP(1'b0)
    ) AD_io [15:0] (
        .PACKAGE_PIN(AD),
        .OUTPUT_ENABLE(AD_write),
        .D_OUT_0(AD_out),
        .D_IN_0(AD_in)
    );

    // Instanciate SPI module
    reg [7:0] TX;
    wire [7:0] RX;
    wire RDY;
    spi port (CLK, SCK, MOSI, MISO, SS, TX, RX, RDY);

    // Internal state
    reg[2:0] state;
    reg[15:0] address;
    reg[7:0] data;

    // We never write anything
    assign WR = 1;
    assign CS = 1;
    assign RD = 1;

    // Always reply data to SPI requests
    assign TX = data;

    // State machine
    always @(posedge CLK) begin

        // When a byte was exchanged with host
        AD_write <= 1'b0;
        AD_out <= 16'b0000000000000000;
        state <= 2'b00;
        if (RDY) begin
            case (state)

            // Ready to handle new command
            2'b00: begin
                case (RX)

                // SEEK
                8'b00000001: begin
                    // ...
                end

                // READ
                8'b00000010: begin
                    // ...
                    data <= data + 1;
                end

                endcase
            end

            // TODO ... state is used for multi-byte address

            endcase
        end
    end

endmodule
