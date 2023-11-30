module top(input logic clk, reset,
output logic [31:0] WriteDataM, DataAdrM,
output logic MemWriteM);



    logic [31:0] PCF, InstrF, ReadDataM;

        // instantiate processor and memories
        arm arm(clk, reset, PCF, InstrF, MemWriteM, DataAdrM,
        WriteDataM, ReadDataM);

        imem imem(PCF, InstrF);

        dmem dmem(clk, MemWriteM, DataAdrM, WriteDataM, ReadDataM);
        
endmodule