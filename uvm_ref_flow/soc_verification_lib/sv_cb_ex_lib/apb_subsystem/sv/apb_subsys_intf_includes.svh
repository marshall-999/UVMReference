 `timescale 1ns/10ps


// Environment Constants
`ifndef AHB_DATA_WIDTH
  `define AHB_DATA_WIDTH          32              // AHB bus data width [32/64]
`endif
`ifndef AHB_ADDR_WIDTH
  `define AHB_ADDR_WIDTH          32              // AHB bus address width [32/64]
`endif
`ifndef AHB_DATA_MAX_BIT
  `define AHB_DATA_MAX_BIT        31              // MUST BE: AHB_DATA_WIDTH - 1
`endif
`ifndef AHB_ADDRESS_MAX_BIT
  `define AHB_ADDRESS_MAX_BIT     31              // MUST BE: AHB_ADDR_WIDTH - 1
`endif
`ifndef DEFAULT_HREADY_VALUE
  `define DEFAULT_HREADY_VALUE    1'b1            // Ready Asserted
`endif

`include "ahb_if.sv"
`include "apb_if.sv"
`include "apb_master_if.sv"
`include "apb_slave_if.sv"
`include "uart_if.sv"
`include "spi_if.sv"
`include "gpio_if.sv"
`include "coverage/uart_ctrl_internal_if.sv"


