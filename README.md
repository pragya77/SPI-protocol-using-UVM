# SPI-protocol-using-UVM

In this project, I implemented the design and verification of SPI master and slave using UVM. The SPI protocol uses MISO, MOSI, CS and CLK lines. In this master at the beginning assert the CS line low, then sends 1 bit RD_WR, 7 bits Address and depending on the RD_WR bit either sends 8 bit data through MOSI line to slave or receives 8 bit data through MISO line from slave.
Master and Slave modules and encapsulated inside a top DUT module and is connected to driver and monitor UVM components using virtual interface. Testbench consists of UVM components - test, environment, agent, driver, monitor, sequencer, scoreboard, sequence and sequence_item. Driver sends random RD_WR, Address and master_out data to master and slave_out data to slave. Testbench sends CLK and start signal to master to start the transmission. Master sends CLK signal to slave and asserts the CS line to low level. Then the transmission starts and the interface is monitored by the monitor at certain time intervals and captured data is sent to scoreboard. In scoreboard, actual RD_WR, Address and data bits are compared with the expected ones.
Simulated the code and observed the accuracy of the functionality on eda playground using Synopsys VCS.
