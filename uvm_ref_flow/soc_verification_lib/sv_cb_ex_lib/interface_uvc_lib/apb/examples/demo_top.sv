/*-----------------------------------------------------------------
File name     : demo_top.sv
Developers    : Kathleen Meade
Created       : Tue May  4 15:13:46 2010
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2010 (c) Cadence Design Systems
-----------------------------------------------------------------*/

`define APB_ADDR_WIDTH 32

`include "dut_dummy.v"
`include "apb_if.sv"
`include "apb_master_if.sv"
`include "apb_slave_if.sv"
`include "apb_pkg.sv"

module demo_top;

  // Import the UVM Package
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Import the APB OVC Package
  import apb_pkg::*;

  // Import the test library
  `include "test_lib.sv"

  bit clock;
  bit reset;

  //Generate Clock
  initial begin
     clock = 0;
     forever begin
        #5;
        clock = ~clock;
     end
  end

  initial begin
    reset = 1'b0;
    #51;
    reset = 1'b1;
  end

  apb_if apb_if_0(clock, reset);
  
  dut_dummy dut( .apb_clock(clock),
                 .apb_reset(reset),
                 .apb_if(apb_if_0)
               );

  initial begin
    uvm_config_db#(virtual apb_if)::set(null, "*.demo_tb0.apb0*", "vif", apb_if_0);
    // The specific setting to a sub component will override the setting
    // to its container. In this case, they are all the all the same, so
    // the settings to the sub components are shown but not necessary
    uvm_config_db#(virtual apb_if)::set(null, "*.demo_tb0.apb0.master*", "vif", apb_if_0);
    uvm_config_db#(virtual apb_if)::set(null, "*.demo_tb0.apb0.slave*", "vif", apb_if_0);
    uvm_config_db#(virtual apb_if)::set(null, "*.demo_tb0.apb0.bus_collector", "vif", apb_if_0);
    run_test();
  end

  initial begin
    $vcdpluson;
  end

endmodule
