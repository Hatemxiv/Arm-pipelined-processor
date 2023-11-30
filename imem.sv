module imem(input logic [31:0] a, output logic [31:0] rd);

    // logic [31:0] RAM[2097151:0];
    logic [31:0] RAM[4095:0];
    initial
    $readmemh("memfile.dat",RAM);
    assign rd = RAM[a[22:2]]; // word aligned

endmodule





/*
instruction memory module (input Address of the instruction (32 bit), output read data (RD) of the instruction (32 bit))
module imem #(parameter width = 32, parameter depth = 128)(input logic [7:0]PCF , output logic [width-1:0] InstrF ); 
logic [width -1 : 0] ram [0 : depth-1];
always_comb
begin
ram[7'h00] = 32'hE04F000F; //SUB R0, R15, R15    ; R0 = 0
ram[7'h04] = 32'hE2802005; //ADD R2, R0, #5      ; R2 = 5
ram[7'h08] = 32'hE280300C; //ADD R3, R0, #12     ; R3 = 12
ram[7'h0C] = 32'hE2437009; //SUB R7, R3, #9      ; R7 = 3
ram[7'h10] = 32'hE1874002; //ORR R4, R7, R2      ; R4 = 3 OR 5 = 7
ram[7'h14] = 32'hE0035004; //AND R5, R3, R4      ; R5 = 12 AND 7 = 4
ram[7'h18] = 32'hE0855004; //ADD R5, R5, R4      ; R5 = 4 + 7 = 11
ram[7'h1C] = 32'hE0558007; //SUBS R8, R5, R7     ; R8 = 11 - 3 = 8, set Flags
ram[7'h20] = 32'h0A00000C; //BEQ END             ; shouldn't be taken
ram[7'h24] = 32'hE0538004; //SUBS R8, R3, R4     ; R8 = 12 - 7 = 5
ram[7'h28] = 32'hAA000000; //BGE AROUND          ; should be taken
ram[7'h2C] = 32'hE2805000; //ADD R5, R0, #0      ; should be skipped
ram[7'h30] = 32'hE0578002; //SUBS R8, R7, R2     ; R8 = 3 - 5 = -2, set Flags
ram[7'h34] = 32'hB2857001; //ADDLT R7, R5, #1    ; R7 = 11 + 1 = 12
ram[7'h38] = 32'hE0477002; //SUB R7, R7, R2      ; R7 = 12 - 5 = 7
ram[7'h3C] = 32'hE5837054; //STR R7, [R3, #84]   ; mem[12+84] = 7
ram[7'h40] = 32'hE5902060; //LDR R2, [R0, #96]   ; R2 = mem[96] = 7
ram[7'h44] = 32'hE08FF000; //ADD R15, R15, R0    ; PC = PC+8 (skips next)
ram[7'h48] = 32'hE280200E; //ADD R2, R0, #14     ; shouldn't happen
ram[7'h4C] = 32'hEA000001; //B END               ; always taken
ram[7'h50] = 32'hE280200D; //ADD R2, R0, #13     ; shouldn't happen
ram[7'h54] = 32'hE280200A; //ADD R2, R0, #10     ; shouldn't happen
ram[7'h58] = 32'hE5802064; //STR R2, [R0, #100]  ; mem[100] = 7
assign  InstrF = ram[PCF];
end
endmodule

*/