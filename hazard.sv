module hazard(input logic clk, reset,
input logic Match_1E_M, Match_1E_W, Match_2E_M,
Match_2E_W, Match_12D_E,
input logic RegWriteM, RegWriteW,
input logic BranchTakenE, MemtoRegE,
input logic PCWrPendingF, PCSrcW,
output logic [1:0] ForwardAE, ForwardBE,
output logic StallF, StallD,
output logic FlushD, FlushE);

    logic ldrStallD;
    // forwarding logic
    always_comb 
        begin
            if (Match_1E_M & RegWriteM) ForwardAE = 2'b10;
            else if (Match_1E_W & RegWriteW) ForwardAE = 2'b01;
            else ForwardAE = 2'b00;

            
            if (Match_2E_M & RegWriteM) ForwardBE = 2'b10;
            else if (Match_2E_W & RegWriteW) ForwardBE = 2'b01;
            else ForwardBE = 2'b00;
        end
    // stalls and flushes
    // Load RAW
    // when an instruction reads a register loaded by the previous,
    // stall in the decode stage until it is ready
    // Branch hazard
    // When a branch is taken, flush the incorrectly fetched instrs
    // from decode and execute stages
    // PC Write Hazard
    // When the PC might be written, stall all following instructions
    // by stalling the fetch and flushing the decode stage
    // when a stage stalls, stall all previous and flush next
    assign ldrStallD = Match_12D_E & MemtoRegE;
    assign StallD = ldrStallD;
    assign StallF = ldrStallD | PCWrPendingF;
    assign FlushE = ldrStallD | BranchTakenE;
    assign FlushD = PCWrPendingF | PCSrcW | BranchTakenE;
endmodule