/* 
     _________                                            ________         _________.__                                        
    /   _____/_____   ____   ____   ____  ___________    /  _____/        /   _____/|  |__   ___________  _____ _____    ____  
    \_____  \\____ \_/ __ \ /    \_/ ___\/ __ \_  __ \  /   \  ___        \_____  \ |  |  \_/ __ \_  __ \/     \\__  \  /    \ 
    /        \  |_> >  ___/|   |  \  \__\  ___/|  | \/  \    \_\  \       /        \|   Y  \  ___/|  | \/  Y Y  \/ __ \|   |  \
   /_______  /   __/ \___  >___|  /\___  >___  >__|      \______  / /\   /_______  /|___|  /\___  >__|  |__|_|  (____  /___|  /
           \/|__|        \/     \/     \/    \/                 \/  \/           \/      \/     \/            \/     \/     \/  
	 ____  ____  _  _    __    __      ____  ____  _____   ____  ____  ___  ____       __       ____  ____  ____     ___  ____  __  __    ____  ____  ___  ____  ___  _  _    ____  _  _    _  _  ____  ____  ____  __    _____  ___ 
	( ___)(_  _)( \( )  /__\  (  )    (  _ \(  _ \(  _  ) (_  _)( ___)/ __)(_  _)()   /. |  ___(  _ \(_  _)(_  _)   / __)(  _ \(  )(  )  (  _ \( ___)/ __)(_  _)/ __)( \( )  (_  _)( \( )  ( \/ )( ___)(  _ \(_  _)(  )  (  _  )/ __)
	 )__)  _)(_  )  (  /(__)\  )(__    )___/ )   / )(_)( .-_)(   )__)( (__   )(      (_  _)(___)) _ < _)(_   )(    ( (__  )___/ )(__)(    )(_) ))__) \__ \ _)(_( (_-. )  (    _)(_  )  (    \  /  )__)  )   / _)(_  )(__  )(_)(( (_-.
	(__)  (____)(_)\_)(__)(__)(____)  (__)  (_)\_)(_____)\____) (____)\___) (__) ()    (_)     (____/(____) (__)    \___)(__)  (______)  (____/(____)(___/(____)\___/(_)\_)  (____)(_)\_)    \/  (____)(_)\_)(____)(____)(_____)\___/
*/


/*** $WRITE THE CODE OF 1-BIT ALU HERE ***/
module OneBitALU (a,b,Cin,b_invert,Operation,Result,Co);/* 1- BIT ALU CODE BEGINS HERE */
	input a,b,Cin,b_invert;
	input [1:0] Operation;
	output Result,Co;
	wire w0,w1,w2,w3; 

	xor g0(w0,b_invert,b); 
	and g2(w1,a,w0);
	or g3(w2,a,w0);
	fullAdder FA1 (a,w0,Cin,Co,W3);
	mux4to1 MX1 (Result,w1,w2,w3,0,Operation[0],Operation[1]);
endmodule
/* 1- BIT ALU CODE ENDS HERE */
/* *********************************************************************** */

module halfAdder (S,C,x,y); //halfadder
   input x,y; 
   output S,C; 
//Instantiate primitive gates 
   xor (S,x,y); 
   and (C,x,y); 
endmodule

module fullAdder(x,y,z,C,S); //full adder with cascading halfadders
   input x,y,z; 
   output S,C; 
   wire S1,D1,D2; //Outputs of first XOR and two AND gates 
//Instantiate the halfadders 
    halfAdder HA1 (S1,D1,x,y), 
              HA2 (S,D2,S1,z); 
    or g1(C,D2,D1); 
endmodule

/* *********************************************************************** */

/*** $WRITE THE CODE OF 4x1 MUX HERE (FROM LAB 7 PART 1a. ***/
module mux4to1(Y, I0, I1, I2, I3, S1, S0); /* 4x1 MUX CODE BEGINS HERE */

	output Y;
	input I0, I1, I2, I3, S1, S0;
	wire S1N, S0N, W0, W1, W2, W3;

	not g4(S1N, S1);
	not g5(S0N, S0);
	and g6(W0, I0, S1N, S0N);
	and g7(W1, I1, S1N, S0);
	and g8(W2, I2, S1, S0N);
	and g9(W3, I3, S1, S0);
	or g10(Y, W0, W1, W2, W3);
endmodule
/* 4x1 MUX CODE ENDS HERE */


/* *********************************************************************** */

/*** $WRITE THE CODE OF 4-BIT ALU HERE ***/
module FourBitALU (A,B,Operation,Result,overflow);/* 4- BIT ALU CODE BEGINS HERE */
	input [3:0] A,B;
	input [2:0] Operation;
	output [3:0] Result;
	output overflow;
	wire w0,w1,w2;
	
	OneBitALU OBA1 (A[0],B[0],Operation[2],Operation[2],Operation[1:0],Result[0],w0);
	OneBitALU OBA2 (A[1],B[1],w0,Operation[2],Operation[1:0],Result[1],w1);
	OneBitALU OBA3 (A[2],B[2],w1,Operation[2],Operation[1:0],Result[2],w2);
	OneBitALU OBA4 (A[3],B[3],w2,Operation[2],Operation[1:0],Result[3],overflow);
endmodule
/* 4- BIT ALU CODE ENDS HERE */


/* *********************************************************************** */
/* $WRITE THE BEHAVIORAL CODE OF LI DECODER HERE */
module LIDecoder (Instruction,dectomux);// LI decoder. 0 if 100, 1 otherwise
	input [2:0] Instruction; 
	output dectomux; 

	assign dectomux = (Instruction==4) ? 0: 1;
endmodule
/* LI DECODER CODE ENDS HERE */


/* *********************************************************************** */


/* *********************************************************************** */
/* $WRITE THE BEHAVIORAL CODE OF QUADRUPLE 2x1 MUX HERE */
module Mux2x1 (I0,I1,Sline,Iout);// QUADRUPLE 2x1 MUX CODE STARTS HERE
	input Sline;
	input [3:0] I0, I1;
	output [3:0] Iout;

	assign Iout = Sline ? I1: I0;
endmodule
/* QUADRUPLE 2x1 MUX CODE ENDS HERE */


/* *********************************************************************** */




/* 1-BIT D-FF STARTS HERE: BEHAVIORAL MODELING (NEG EDGE TRIGGER)*/
module DFlipFlop (D,Clk,Q); //D flip-flop
	input Clk,D; 
	output Q;
	reg Q;
	always@(negedge Clk) 
	begin
		Q<=D;
	end 
endmodule
//1- BIT DFF ENDS HERE 


/* *********************************************************************** */



/* 9-bit INSTRUCTION REGISTRER STARTS HERE: USING 1-bit DFF*/
module Bit9Register (In,Clock,Out);// Instruction register. Must be completed. 
	input [8:0] In; 
	input Clock;
	output [8:0] Out;
	
	DFlipFlop DFF0 (In[0], Clock, Out[0]);
	DFlipFlop DFF1 (In[1], Clock, Out[1]);
	DFlipFlop DFF2 (In[2], Clock, Out[2]);
	DFlipFlop DFF3 (In[3], Clock, Out[3]);
	DFlipFlop DFF4 (In[4], Clock, Out[4]);
	DFlipFlop DFF5 (In[5], Clock, Out[5]);
	DFlipFlop DFF6 (In[6], Clock, Out[6]);
	DFlipFlop DFF7 (In[7], Clock, Out[7]);
	DFlipFlop DFF8 (In[8], Clock, Out[8]);
endmodule
/* INSTRUCTION REGISTER ENDS HERE */



/* *********************************************************************** */



/* 4-bit register file implemented in behavioral modeling (don't change it). */
module regfile (ReadReg1,ReadReg2,WriteReg,WriteData,ReadData1,ReadData2,CLK);
  input [1:0] ReadReg1,ReadReg2,WriteReg;
  input [3:0] WriteData;
  input CLK;
  output [3:0] ReadData1,ReadData2;
  reg [3:0] Regs[0:3]; 
  assign ReadData1 = Regs[ReadReg1];
  assign ReadData2 = Regs[ReadReg2];
  initial Regs[0] = 0;
  always @(negedge CLK)
     Regs[WriteReg] <= WriteData;
endmodule


/* *********************************************************************** */



// FINAL CPU MODULE STARTS HERE *//
// FINISH THE CODE //


module cpu (Instruction, WriteData, CLK, overflow, Result, A, B, dectomux, IR);
	input [8:0] Instruction; // 9bits for mips instructions
	input CLK; // clock
	output [3:0] WriteData,Result; // 4bit output of cp
	output overflow;
   
	output [8:0] IR; // Declare more wires as needed
	output [3:0] A,B;
	output dectomux;
	// Declare more wires as needed
   
	/* INSTANTIATE ALL THE MODULES AS PER FIGURE 1. The OP code and other fiels of this register that have to be 
	   passed to other modules must be represented by their respective 
	   indices (see the register file instance below).
	*/
   
// instruction register
	Bit9Register B9R1 (Instruction,CLK,IR);



// Define the module for the quadruple 2x1 mux and instatiate it here.
	Mux2x1 MX1 (IR[5:2],Result,dectomux,WriteData);

   

// Define the module for the LI decoder and instantiate it here.
	LIDecoder LID1 (IR[8:6],dectomux);
   

// register file (the module definition is incuded in this file)
	regfile regs1 (IR[5:4],IR[3:2],IR[1:0],WriteData,A,B,CLK);



// Define a module for the ALU and instantiate it here.
	FourBitALU FBALU1 (A,B,IR[8:6],Result,overflow);
   
   
endmodule

/* *********************************************************************** */


/* *********************************************************************** */

/* THIS IS THE TESTBENCH. DO NOT CHANGE ANYTHING HERE. USE IT TO TEST YOUR CIRCUIT*/


// Test module. Add more instructions as p rovided in the test program.
module test_cpu;
   reg [8:0] Instruction;
   reg CLK;
   wire [8:0] IR;
   wire [3:0] WriteData,Result, A, B;
   wire overflow;
   cpu cpu1 (Instruction, WriteData, CLK, overflow, Result, A, B, dectomux, IR);

   initial
   begin
            // LI  $2, 15  # load decimal 15 in $2; $2=1111, which is -1 in 2's comp
        #0 Instruction = 9'b100111110; 
        #0 CLK=1;
        #1 CLK=0; // negative edge - execute instruction

/* Machine code for the test program instructions are input here.
   Use the format shown above. Pay attention to the register
   order - the destination register is first in the assembly code
   and last (LSB) in the machine code.
   After each instruction a negative edge must be generated.
*/
	  
      //LI  $3, 8        # load decimal 8 (unsigned binary) into $3; $3= 1000, which is -8 in 2's comp
        #1 Instruction = 9'b100100011; 
        #1 CLK=1;
        #1 CLK=0; // negative edge - execute instruction
	  
      //AND $1, $2, $3   # $1 = $2 AND $3 ($1= 1000)
        #1 Instruction = 9'b000101101; 
        #1 CLK=1;
        #1 CLK=0; // negative edge - execute instruction
	  
      //SUB $3, $1, $2   # $3 = $1 - $2 = -8 - (-1) = -7 ($3=1001, which is -7 in 2's complement)
        #1 Instruction = 9'b110011011; 
        #1 CLK=1;
        #1 CLK=0; // negative edge - execute instruction
 
 
      //ADD $1, $2, $3   # $1 = $2 + $3 = -1 + (-7) = -8  ($1=1000, which is -8 in 2's complement)
        #1 Instruction = 9'b010101101; 
        #1 CLK=1;
        #1 CLK=0; // negative edge - execute instruction

      //SUB $2, $3, $1   # $2 = $3 - $1 = -7 - (-8) = 1 ($3= 0001, which is +1 in 2's comp)
        #1 Instruction = 9'b110110110; 
        #1 CLK=1;
        #1 CLK=0; // negative edge - execute instruction
 
      //OR  $3, $1, $2   # $3 = $1 OR $2 = 1001 ($3= 1000 | 0001= 1001)
        #1 Instruction = 9'b001011011; 
        #1 CLK=1;
        #1 CLK=0; // negative edge - execute instruction
   end

endmodule
/* *********************************************************************** */