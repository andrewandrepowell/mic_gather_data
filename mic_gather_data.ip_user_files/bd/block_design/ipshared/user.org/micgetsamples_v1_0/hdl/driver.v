`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Grabs samples from the PmodMIC module at a regular rate and
// then inputs those samples into the fifo.
//////////////////////////////////////////////////////////////////////////////////


module driver #
    (
        // GRAB TRIG determines the sample rate. 
        // sample rate = clock rate / GRAB_TRIG
        parameter integer GRAB_TRIG=3,
        parameter integer SAMPLE_WIDTH=16
    )
    (
        input wire clock,
        output reg axis_slave_ready=0,
        input wire axis_slave_valid,
        input wire [ SAMPLE_WIDTH-1:0 ] axis_slave_data,
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
    
    localparam integer COUNTER_WIDTH = clogb2( GRAB_TRIG );
    
    reg [ COUNTER_WIDTH-1:0 ] counter = 0;
        
    // Drive AXI Slave Stream Interface.
    always @ ( posedge clock )
        begin
            if ( counter==(GRAB_TRIG-1) )
                begin
                    axis_slave_ready <= 1;
                    counter <= 0;
                end
            else
                begin
                    counter <= counter+1;
                end
            if ( axis_slave_valid==1 )
                axis_slave_ready <= 0;
        end
        
    // Drive AXI Master Stream Interface
    always @( posedge clock )
        begin
            if ( axis_slave_ready==1 && axis_slave_valid==1 )
                begin
                    axis_master_data <= axis_slave_data;
                    axis_master_valid <= 1;
                end
            if ( axis_master_valid==1 )
                axis_master_valid <= 0;
        end
        
endmodule
