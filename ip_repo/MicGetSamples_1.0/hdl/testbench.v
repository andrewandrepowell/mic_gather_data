`timescale 1ns / 1ps

module testbench;

    localparam integer CLOCK_PERIOD=10;
    localparam integer CLK_TRIG=2;
    localparam integer GRAB_TRIG=128;
    localparam integer RAM_ADDR_WIDTH=2;
    localparam integer SAMPLE_WIDTH=16;

    reg clock=0;
    reg nreset=0;
    wire dut2bench_valid;
    wire [ SAMPLE_WIDTH-1:0 ] dut2bench_data;
    wire [(SAMPLE_WIDTH/8)-1 : 0] dut2bench_tstrb;
    reg dut2bench_ready=0;
    wire spi_clock;
    wire spi_chipselect;
    reg spi_data=0;
    
    task wait_until_posedge( input signal, input amount );
        integer each_edge;
        begin
            for ( each_edge=0; each_edge<amount; each_edge=each_edge+1 )
                @ ( posedge signal );
        end
    endtask
    
    task automatic drive_spi( input [ SAMPLE_WIDTH-1:0 ] sample );
        automatic integer each_bit;
        begin
            @( negedge spi_chipselect );
            for ( each_bit=0; each_bit<SAMPLE_WIDTH; each_bit=each_bit+1 )
                begin
                    @( negedge spi_clock );
                    spi_data <= sample[ SAMPLE_WIDTH-1-each_bit ];
                end
        end
    endtask
    
    task drive_axis;
        begin
            @ ( posedge clock );
            dut2bench_ready <= 1;
            @ ( posedge clock );
            while ( dut2bench_valid==0 )
                @ ( posedge clock );
            dut2bench_ready <= 0;
        end
    endtask
    
    // DUT 
    MicGetSamples_v1_0 #(
        .CLK_TRIG( CLK_TRIG ),
        .GRAB_TRIG( GRAB_TRIG ),
        .RAM_ADDR_WIDTH( RAM_ADDR_WIDTH ),
        .C_M00_AXIS_TDATA_WIDTH( SAMPLE_WIDTH )
    ) MicGetSamples_inst (
        .m00_axis_aclk( clock ),
        .m00_axis_aresetn( nreset ),
        .m00_axis_tvalid( dut2bench_valid ),
        .m00_axis_tdata( dut2bench_data ),
        .m00_axis_tstrb( dut2bench_tstrb ),
        .m00_axis_tready( dut2bench_ready ),
        .spi_clock( spi_clock ),
        .spi_chipselect( spi_chipselect ),
        .spi_data( spi_data ) );
        
    // Drive clock
    always 
        begin
            clock = !clock;
            #(CLOCK_PERIOD/2);
        end
    
    initial
        begin: testbench_main
            integer each_word;
            $display( "Starting Testbench application..." );
            wait_until_posedge( clock, 10 );
            nreset <= 1;
            for ( each_word=2; each_word<12; each_word=each_word+1 )
                begin
                    drive_spi( each_word );
                    drive_axis;
                    $display( "data sent: %d, data received: %d", each_word, dut2bench_data );
                    if ( each_word != dut2bench_data )
                        begin
                            $display( "Simulation failed! ");
                            $finish;
                        end
                end
            $display( "Finihed Testbench application..." );
            $finish;
        end
    
    
endmodule
