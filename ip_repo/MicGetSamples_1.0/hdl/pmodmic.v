`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// This is really a SPI master interface, without the 
// master-output/slave-input signal. 
//////////////////////////////////////////////////////////////////////////////////

module pmodmic #
    (
        // CLK TRIG is a constant that determines the frequency of the SPI clock.
        // SPI freq = clock freq / ( 2*CLK TRIG )
        parameter integer CLK_TRIG=0,
        // SAMPLE WIDTH is the width of the input data.
        parameter integer SAMPLE_WIDTH=16
    )
    (
        input wire clock,
        // SPI interface.
        output reg spi_clock=1,
        output spi_chipselect,
        input wire spi_data,
        // AXIS Master interface.
        input wire axis_master_ready,
        output reg axis_master_valid=0,
        output reg [ SAMPLE_WIDTH-1:0 ] axis_master_data=0
    );
    
    // function called clogb2 that returns an integer which has the                      
    // value of the ceiling of the log base 2.                                           
    function integer clogb2 (input integer bit_depth);                                   
        begin                                                                              
            for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                                      
                bit_depth = bit_depth >> 1;                                                    
        end                                                                                
    endfunction   
    
    localparam integer SPI_CNT_WIDTH = clogb2( CLK_TRIG+1 );
    localparam integer SPI_EACHBIT_WIDTH = clogb2( SAMPLE_WIDTH+1 );
            
    reg spi_en=0;
    reg [ SPI_CNT_WIDTH-1:0 ] spi_cnt=0;
    reg [ SPI_EACHBIT_WIDTH-1:0 ] spi_eachbit=0;
    
    assign spi_chipselect = !spi_en;

    // Drive AXI Master Stream Interface
    always @( posedge clock ) 
        begin
            if ( axis_master_valid==1 )
                begin
                   axis_master_valid <= 0;
                end
            else if ( ( spi_eachbit==SAMPLE_WIDTH ) && ( spi_clock==1 ) )
                begin
                    spi_en <= 0;
                    axis_master_valid <= 1;
                end
            else if ( axis_master_ready==1 )
                begin
                    spi_en <= 1;
                end
           
        end
        
    // Drive SPI Clock.
    always @( posedge clock )
        if ( spi_en==1 )
            begin
                if ( spi_cnt==CLK_TRIG )
                    begin
                        spi_clock <= !spi_clock;
                        spi_cnt <= 0;
                    end
                else
                    begin
                        spi_cnt <= spi_cnt+1;
                    end
            end
        else
            begin
                spi_clock <= 1;
                spi_cnt <= 0;
            end
                
    // Acquire samples from SPI.
    always @( posedge spi_clock or negedge spi_en )
        if ( spi_en==0 )
            begin
                spi_eachbit <= 0;
            end
        else
            begin
                axis_master_data[ 0 ] <= spi_data;
                axis_master_data[ SAMPLE_WIDTH-1 : 1 ] <= axis_master_data[ SAMPLE_WIDTH-2 : 0 ];
                spi_eachbit <= spi_eachbit+1;
            end
        
            
    
endmodule
