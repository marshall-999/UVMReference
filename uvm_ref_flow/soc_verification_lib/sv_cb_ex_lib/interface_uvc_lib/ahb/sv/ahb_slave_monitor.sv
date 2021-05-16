// IVB checksum: 223843813
/*-----------------------------------------------------------------
File name     : ahb_slave_monitor.sv
Created       : Wed May 19 15:42:21 2010
Description   : This file implements the slave monitor.
              : The slave monitor monitors the activity of
              : its interface bus.
Notes         :
-----------------------------------------------------------------*/
//   Copyright 1999-2010 Cadence Design Systems, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------


`ifndef AHB_SLAVE_MONITOR_SV
`define AHB_SLAVE_MONITOR_SV

//------------------------------------------------------------------------------
//
// CLASS: ahb_slave_monitor
//
//------------------------------------------------------------------------------

class ahb_slave_monitor extends uvm_monitor;
  
  // The virtual interface needed for this component to drive
  // and view HDL signals.
  virtual interface ahb_if vif;

  // Count transfer responses collected
  int num_col;

  // The following two bits are used to control whether checks and coverage are
  // done in the monitor
  bit checks_enable = 1;
  bit coverage_enable = 1;
  
  // This TLM port is used to connect the monitor to the scoreboard
  uvm_analysis_port#(ahb_transfer) item_collected_port;

  // Current monitored transfer 
  protected ahb_transfer transfer;
 
  // Covergroup for transfer
  covergroup slave_transfer_cg;
    option.per_instance = 1;
    direction: coverpoint transfer.direction;
  endgroup : slave_transfer_cg

  // Provide UVM automation and utility methods
  `uvm_component_utils_begin(ahb_slave_monitor)
    `uvm_field_int(checks_enable, UVM_ALL_ON)
    `uvm_field_int(coverage_enable, UVM_ALL_ON)
  `uvm_component_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new(string name, uvm_component parent);
    super.new(name, parent);
    // Create the covergroup
    slave_transfer_cg = new();
    slave_transfer_cg.set_inst_name("slave_transfer_cg");
    // Create the TLM port
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  // Additional class methods
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual protected task collect_response();
  extern virtual protected function void perform_checks();
  extern virtual protected function void perform_coverage();
  extern virtual function void report();

endclass : ahb_slave_monitor

//UVM connect_phase
function void ahb_slave_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if (!uvm_config_db#(virtual ahb_if)::get(this, "", "vif", vif))
   `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
endfunction : connect_phase

  // UVM run() phase
  task ahb_slave_monitor::run_phase(uvm_phase phase);
    fork
      collect_response();
    join_none
  endtask : run_phase

  /***************************************************************************
   IVB-NOTE : REQUIRED : slave Monitor : Monitors
   -------------------------------------------------------------------------
   Modify the collect_response() method to match your protocol.
   Note that if you change/add signals to the physical interface, you must
   also change this method. 
   ***************************************************************************/
  
  // Collect slave transfer (response)
  task ahb_slave_monitor::collect_response();
    // This monitor re-uses its data item for ALL transfers
    transfer = ahb_transfer::type_id::create("transfer", this);
    forever begin
      @(posedge vif.ahb_clock iff vif.AHB_HREADY === 1);
      // Enable transfer recording
      void'(begin_tr(transfer, "AHB SLAVE Monitor"));
      transfer.data = vif.AHB_HWDATA;
      @(posedge vif.ahb_clock);
      end_tr(transfer);
      `uvm_info(get_type_name(),
        $psprintf("slave transfer collected :\n%s",
        transfer.sprint()), UVM_HIGH)
      if (checks_enable)
        perform_checks();
      if (coverage_enable)
        perform_coverage();
      // Send transfer to scoreboard via TLM write()
      item_collected_port.write(transfer);
      num_col++;
    end
  endtask : collect_response
  
  /***************************************************************************
  IVB-NOTE : OPTIONAL : slave Monitor Protocol Checks : Checks
  -------------------------------------------------------------------------
  Add protocol checks within the perform_checks() method. 
  ***************************************************************************/
  // perform__checks
  function void ahb_slave_monitor::perform_checks();
    // Add checks here
  endfunction : perform_checks
  
 /***************************************************************************
  IVB-NOTE : OPTIONAL : slave Monitor Coverage : Coverage
  -------------------------------------------------------------------------
  Modify the slave_transfer_cg coverage group to match your protocol.
  Add new coverage groups, and edit the perform_coverage() method to sample them
  ***************************************************************************/

  // Triggers coverage events
  function void ahb_slave_monitor::perform_coverage();
    slave_transfer_cg.sample();
  endfunction : perform_coverage

  // UVM report() phase
  function void ahb_slave_monitor::report();
    `uvm_info(get_type_name(), 
      $psprintf("\nReport: AHB slave monitor collected %0d transfer responses",
      num_col), UVM_LOW)
  endfunction : report

`endif // AHB_SLAVE_MONITOR_SV

