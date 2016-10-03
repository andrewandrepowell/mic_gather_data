# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set C_M00_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.} ${C_M00_AXIS_TDATA_WIDTH}
  ipgui::add_param $IPINST -name "CLK_TRIG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "GRAB_TRIG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RAM_ADDR_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.CLK_TRIG { PARAM_VALUE.CLK_TRIG } {
	# Procedure called to update CLK_TRIG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLK_TRIG { PARAM_VALUE.CLK_TRIG } {
	# Procedure called to validate CLK_TRIG
	return true
}

proc update_PARAM_VALUE.GRAB_TRIG { PARAM_VALUE.GRAB_TRIG } {
	# Procedure called to update GRAB_TRIG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GRAB_TRIG { PARAM_VALUE.GRAB_TRIG } {
	# Procedure called to validate GRAB_TRIG
	return true
}

proc update_PARAM_VALUE.RAM_ADDR_WIDTH { PARAM_VALUE.RAM_ADDR_WIDTH } {
	# Procedure called to update RAM_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_ADDR_WIDTH { PARAM_VALUE.RAM_ADDR_WIDTH } {
	# Procedure called to validate RAM_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_M00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_M00_AXIS_TDATA_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.CLK_TRIG { MODELPARAM_VALUE.CLK_TRIG PARAM_VALUE.CLK_TRIG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLK_TRIG}] ${MODELPARAM_VALUE.CLK_TRIG}
}

proc update_MODELPARAM_VALUE.GRAB_TRIG { MODELPARAM_VALUE.GRAB_TRIG PARAM_VALUE.GRAB_TRIG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.GRAB_TRIG}] ${MODELPARAM_VALUE.GRAB_TRIG}
}

proc update_MODELPARAM_VALUE.RAM_ADDR_WIDTH { MODELPARAM_VALUE.RAM_ADDR_WIDTH PARAM_VALUE.RAM_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_ADDR_WIDTH}] ${MODELPARAM_VALUE.RAM_ADDR_WIDTH}
}

