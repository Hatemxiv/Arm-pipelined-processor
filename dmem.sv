module dmem(input logic clk, we,
    input logic [31:0] a, wd,
    output logic [31:0] rd);


    logic [31:0] RAM[255:0];
    initial
    $readmemh("memfile.dat",RAM);
    assign rd = RAM[a[22:2]]; // word aligned
    always_ff @(posedge clk)
    if (we) RAM[a[22:2]] <= wd;

    
endmodule