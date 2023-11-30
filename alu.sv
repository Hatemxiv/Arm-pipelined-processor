/*module alu (Number1, Number2, AluControl, Result, AluFlags);

    input logic [31:0] Number1, Number2;
    input logic [2:0] AluControl;

    output logic [31:0] Result;
    output logic [3:0] AluFlags;

    logic Negative, Zero, Carry, OverFlow;
    logic [32:0] Sum;
    logic [31:0] condintionalInversionNumber2;

    assign condintionalInversionNumber2 = AluControl[0] ? ~Number2 : Number2;
    assign Sum = AluControl[0] + Number1 + condintionalInversionNumber2;
    // result logic
    always_comb 
    begin
        casex (AluControl[2:0])
           3'b?0? : Result = Sum;
           3'b?10 : Result = Number1 & Number2;
           3'b?11 : Result = Number1 | Number1;
           3'b0?? : Result = Number1 ^ Number2;
           3'b1?? : Result = Number1 & ~(Number2);
            
        endcase
    end

    // AluFlags logic
    assign Negative = Result[31];
    assign Zero = (Result == 32'b0);
    assign Carry = (AluControl[1] == 1'b0) & Sum[32];
    assign OverFlow = (AluControl[1] == 1'b0) & ~(Number1[31] ^ Number2[31] ^ AluControl[0])
    & (Number1[31] ^ Sum[31]);

    assign AluFlags ={Negative, Zero, Carry, OverFlow};

endmodule*/

module alu #(parameter N = 32)( Number1, Number2, AluControl, Result, AluFlags);
    input logic [N-1:0] Number1, Number2;
    input logic [2:0] AluControl;

    output logic [N-1:0] Result;
    output logic [3:0] AluFlags;

    logic Negative, Zero, Carry, OverFlow;
    logic [N:0] Sum;
    logic [N-1:0] condintionalInversionNumber2;
    assign condintionalInversionNumber2 = AluControl[0] ? ~Number2 : Number2;
    assign Sum = Number1 + condintionalInversionNumber2 + AluControl[0];
//to add or sub introduce the carry bit (FULL ADDER)
    // result logic
    always_comb 
    begin
        case (AluControl[2:0])  //case allows x,z,'?' to be treated as do not cares
// ex: a case item 2?b1? (or 2?b1Z) in a casex statement can match case expression of 2?b10, 2?b11, 2?b1X, 2?b1Z.
           3'b000 : Result = Sum;                     //ADD and SUB
	   3'b001 : Result = Sum; 
           3'b010 : Result = Number1 & Number2;       //AND
           3'b011 : Result = Number1 | Number2;       //ORR
           3'b110 : Result = Number1 ^ Number2;       //EOR
           3'b100 : Result = Number1 & ~Number2;      //BIC
        endcase
    end

    // AluFlags logic
    assign Negative = Result[N-1];
    assign Zero = (Result == 0);
    assign Carry = (~ AluControl[1] ) &  Sum[N];
    assign OverFlow = (~ AluControl[1]) & ~(Number1[N-1] ^ Number2[N-1] ^ AluControl[0]) 
    & (Number1[N-1] ^ Sum[N-1]);

    assign AluFlags ={Negative, Zero, Carry, OverFlow};

endmodule