	rm  *.log -rf csrc
    vcs -timescale=1ns/1ns \
        -sverilog \
        -kdb \
        -lca \
    	${UVM_HOME}/src/dpi/uvm_dpi.cc \
    	-CFLAGS -DVCS \
        -debug_access+all \
        -f filelist/tb.f \
    	-l com.log 
    
    simv -l sim.log \
         +UVM_TESTNAME=uart_sequence_test \
         +UVM_VERBOSITY=UVM_HIGH \

