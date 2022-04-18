// An 8-bits SPI slave with mode=0 (CPOL=0, CPHA=0), MSB first
module spi (
    input CLK, // Internal clock
    input SCK, // Serial Clock
    input MOSI, // Master Out Slave In
    output MISO, // Master In Slave Out
    input SS, // Slave Select
    input [7:0] TX, // Transmit (to master)
    output reg [7:0] RX, // Receive (from master)
    output reg RDY // Ready
);

    // Three-stages shift register, used to get synchronous notification of an asynchronous edge.
    reg [2:0] SCK_history;
    reg [1:0] MOSI_history;
    reg [2:0] SS_history;

    // Update shift registers at each rising edge
    always @(posedge CLK)
    begin
        SCK_history <= {SCK_history[1:0], SCK};
        MOSI_history <= {MOSI_history[0], MOSI};
        SS_history <= {SS_history[1:0], SS};
    end

    // Serial Clock edges
    wire SCK_rising_edge = SCK_history[2:1] == 2'b01;
    wire SCK_falling_edge = SCK_history[2:1] == 2'b10;

    // Incoming bit
    wire MOSI_datum = MOSI_history[1];

    // Slave Select is active low
    wire SS_active = ~SS_history[1];
    wire SS_falling_edge = SS_history[2:1] == 2'b10;

    // Internal (circular) buffers
    reg [2:0] count;
    reg [7:0] TX_buffer;

    // State machine
    always @(posedge CLK)
    begin

        // By default, output is not ready
        RDY <= 1'b0;

        // If slave is not active, clear state
        if (~SS_active) begin
            count <= 3'b000;
            TX_buffer <= 8'b00000000;
            RX <= 8'b00000000;
        end

        // Message starts at Slave Select falling edge
        // Note: this also ensures that we do not check SCK too early
        else if (SS_falling_edge) begin
            count <= 3'b000;
            TX_buffer <= TX;
            RX <= 8'b00000000;
        end

        // Otherwise, communication is happening
        else begin

            // Read incoming bit at SCLK rising edge
            if (SCK_rising_edge) begin
                RX <= {RX[6:0], MOSI_datum};
            end

            // Move to next bit at SCLK falling edge
            else if (SCK_falling_edge) begin

                // If this is the 8th bit, then a cycle is complete
                if (count == 3'b111) begin
                    TX_buffer <= TX;
                    RDY <= 1'b1;
                end

                // Otherwise, shift output register
                else begin
                    TX_buffer <= {TX_buffer[6:0], 1'b0};
                end

                // In any case, we wrote a bit
                count <= count + 1'b1;
            end
        end
    end

    // Output current outgoing bit, if connection is active
    assign MISO = SS_active ? TX_buffer[7] : 1'bz;

endmodule
