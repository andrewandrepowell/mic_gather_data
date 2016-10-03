onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L microblaze_v9_6_1 -L lmb_v10_v3_0_8 -L lmb_bram_if_cntlr_v4_0_9 -L blk_mem_gen_v8_3_3 -L axi_lite_ipif_v3_0_4 -L axi_intc_v4_1_7 -L mdm_v3_2_6 -L generic_baseblocks_v2_1_0 -L axi_infrastructure_v1_1_0 -L axi_register_slice_v2_1_9 -L fifo_generator_v13_1_1 -L axi_data_fifo_v2_1_8 -L axi_crossbar_v2_1_10 -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_9 -L lib_bmg_v1_0_5 -L lib_fifo_v1_0_5 -L axi_ethernetlite_v3_0_7 -L mii_to_rmii_v2_0_11 -L lib_pkg_v1_0_2 -L axi_timer_v2_0_11 -L lib_srl_fifo_v1_0_2 -L axi_uartlite_v2_0_13 -L axi_datamover_v5_1_11 -L axi_sg_v4_1_3 -L axi_dma_v7_1_10 -L axis_infrastructure_v1_1_0 -L axis_register_slice_v1_1_9 -L axis_dwidth_converter_v1_1_8 -L dist_mem_gen_v8_0_10 -L interrupt_control_v3_1_4 -L axi_quad_spi_v3_2_8 -L axi_clock_converter_v2_1_8 -L axi_protocol_converter_v2_1_9 -L axi_dwidth_converter_v2_1_9 -lib xil_defaultlib xil_defaultlib.block_design xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {block_design.udo}

run -all

quit -force
