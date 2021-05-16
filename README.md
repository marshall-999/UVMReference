# Ethernet-switch-SoC-UVM-Reference
## Introduction

**This is a open source project from UVM Community and it is based on an Ethernet Switch System-on-Chip (SoC).** 

**The SoC has the following key design components：**

1. An Opencores Open RISC Processor

2. Opencores Ethernet Media Access controller (MAC)

3. AMBA AHB network interconnect

4. Address Look up table (ALUT)

5. Support and Control functions. For instance power management and peripherals like UART, SPI, GPO, timer etc

6. On-chip Memories and memory controller



**The UVM Reference Flow also includes the following key verification components：**

1. AMBA AHB UVC 

2. AMBA APB UVC

3. UART UVC

4. GPIO UVC

5. SPI UVC

6. Register Memory Package (uvm_reg) 



## Design Docs

### Ethernet Switch SoC 

  doc/uvm_flow_topics/uvm_ref_flow_design/ethernet_switch.pdf

### Open source IP 

- #### **uart16550**

doc/opencores/uart16550/UART_spec.pdf

- #### **or1200**  

doc/opencores/or1200/doc/openrisc1200_spec.pdf
doc/opencores/or1200/doc/openrisc_arch.pdf

- #### **spi** 

doc/opencores/spi/spi.pdf

- #### **ethmac** 

doc/opencores/ethmac/eth_design_document.pdf
doc/opencores/ethmac/eth_speci.pdf
doc/opencores/ethmac/ethernet_datasheet_OC_head.pdf
doc/opencores/ethmac/ethernet_product_brief_OC_head.pdf



## Verification Docs

 doc/uvm_flow_topics/uvm_sv/uvm_sv_ref_flow_ug.pdf



## Design Catalogue

designs/socv/rtl/rtl_lpw
                    |
                    +-- ahb2apb        : AMBA AHB to AMBA APB bridge
                    |
                    +-- alut           : Address Lookup Table
                    |
                    +-- apb_subsystem  : AMBA APB Subsystem
                    |
                    +-- cdn_busmatrix  : AMBA AHB bus matrix
                    |
                    +-- dma            : Direct Memory access controller
                    |
                    +-- gpio           : General Purpose I/O
                    |
                    +-- opencores
                    |  |-- ethmac      : Ethernet MAC
                    |  |-- or1200      : Open RISC processor
                    |  |-- spi         : Serial Peripheral Interface
                    |  |-- uart16550   : Universal Asynchronous Receiver Transmitter
                    |
                    +-- padframe
                    |
                    +-- power_ctrl     : Power Control module
                    |
                    +-- rom_subsystem  : ROM Controller
                    |
                    +-- smc            : Memory Controller
                    |
                    +-- socv           : SoC Top level
                    |
                    +-- sram_subsystem : SRAM subsystem
                    |
                    +-- ttc            : Triple timer controller
                    |
                    +-- wb_to_ahb      : Wishbone to AHB bridge



## Verification Catalogue

soc_verification_lib/sv_cb_ex_lib/
                    |
                    |
                    +-- interface_uvc_lib
                    |  +-- ahb
                    |  +-- apb
                    |  +-- spi
                    |  +-- gpio
                    |  +-- uart
                    |
                    +-- uart_ctrl
                    |  +-- examples
                    |  +-- sv
                           contains reusable design verif files: monitor, scoreboard, env, virtual sequencer,etc
                    |  +-- tb/
                    |      +-- scripts/  run.sh, Makefiles, tcl commands, etc
                    |      +-- sv/  non-reusable code for this (testbench, top)
                    |      +-- tests/  library of tests for the design
                    |
                    +-- apb_subsystem
                    |  +-- examples
                    |  +-- sv
                           contains reusable design verif files:  monitor, scoreboard, env, virtual sequencer,etc
                    |  +-- tb/
                    |      +-- scripts/  run.sh, Makefiles, tcl commands, etc
                    |      +-- sv/  non-reusable code for this (testbench, top)
                    |      +-- tests/  library of tests for the design



## Note

I have made the following changes from the original UVM-1.1 environment：

- Part of UVM-1.2 compatibility changes
- Reconfiguration and scripting to match the emulation environment we are currently using 
- Fixed bugs in the code

The focus of this actual combat project is to establish UVM environment to verify the APB subsystem, which involves the encapsulation of AHB protocol and APB protocol, and includes the encapsulation and verification of UVM environment of UART GPIO SPI module. The difficulty is moderate and enough to achieve the effect of actual combat practice by using UVM

**For more information about using the UVM Reference Flow ,you can follow my WeChat（程序员Marshall）.**
