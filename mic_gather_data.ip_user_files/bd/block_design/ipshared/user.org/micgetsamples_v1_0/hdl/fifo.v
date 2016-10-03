`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// This FIFO was based on the DMA FIFO from Digilent Example Design!
//////////////////////////////////////////////////////////////////////////////////


module fifo #
    (
        parameter integer RAM_ADDR_WIDTH = 3,
        parameter integer FIFO_WIDTH = 16 
    )
    (
        input wire clock,
        input wire nreset,
        input wire reset,
        
        input wire in_stb,
        output wire in_ack,
        input wire [ FIFO_WIDTH-1:0 ] in_data,
        
        output wire out_stb,
        input wire out_ack,
        output wire [ FIFO_WIDTH-1:0 ] out_data
    );
    
    localparam integer FIFO_MAX = (2**RAM_ADDR_WIDTH)-1;
    reg [ FIFO_WIDTH-1:0 ] data_fifo [ 0:FIFO_MAX ];
    reg [ RAM_ADDR_WIDTH-1:0 ] wr_addr;
    reg [ RAM_ADDR_WIDTH-1:0 ] rd_addr;
    reg [ RAM_ADDR_WIDTH: 0 ] free_cnt;
    reg full,empty;
    
    initial 
        begin : init_nets
            integer each_word;
            for ( each_word=0; each_word<=FIFO_MAX; each_word=each_word+1 )
                data_fifo[ each_word ] <= 0;
            wr_addr <= 0;
            rd_addr <= 0;
            full <= 0;
            empty <= 0;
            free_cnt <= FIFO_MAX+1;
        end
    
    assign in_ack = ( full==1 ) ? 0 : 1;
    assign out_stb = ( empty==1 ) ? 0 : 1;
    assign out_data = data_fifo[ rd_addr ];
    
    always @( posedge clock )
        begin: fifo_cntrl
            if ( nreset==0 || reset==1 )
                begin
                    wr_addr <= 0;
                    rd_addr <= 0;
                    free_cnt = FIFO_MAX+1;
                    empty <= 1;
                    full <= 0;
                end
            else
                begin
                    if ( in_stb==1 && full==0 ) 
                    begin
                        data_fifo[ wr_addr ] <= in_data;
                        wr_addr <= wr_addr+1;
                        free_cnt = free_cnt-1;
                    end
                    if ( out_ack==1 && empty==0 )
                    begin
                        rd_addr <= rd_addr+1;
                        free_cnt = free_cnt+1;
                    end
                    full <= ( free_cnt==0 );
                    empty <= ( free_cnt==FIFO_MAX+1 );
                end
        end
    
endmodule
