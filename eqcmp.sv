module eqcmp #(parameter WIDTH = 8)
(input logic [WIDTH-1:0] a, b,
output logic y);

    assign y = (a == b);

endmodule