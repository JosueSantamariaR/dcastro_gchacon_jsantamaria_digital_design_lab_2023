module Problema1(input logic a,b,c,d,
							output logic hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex00, hex01);

logic e,f,g,h,i,j;

//Conversión de binario a BCD (digitos del 0 al 9)
assign e = d;
assign f = (~a & c)||(a & b & ~c);
assign g = (~a || c) & b;
assign h = a & ~b & ~c;

//Conversión de binario a BCD para casos cuando el numero binario es mayor a 9
assign i = (c || b) & a;
assign j = e;


//=rden de bits h   g   f   j
//		          A3  A2  A1  A0
		

//Asignación de las variables encargadas del display de 7 segmentos (Utilizando low logic)
		
assign hex0 = (~f & ~h & ((j & ~g)||(~j & g))); //j xor g

assign hex1 = (g & ((j & ~f)||(~j & f))); // j xor f

assign hex2 = (~j & f & ~g & ~h);

assign hex3 = (~(f & ~g) & ~(j & ~f & g) & ~(~j & ~g) & ~(~j & f));

assign hex4 = (~(~j & ~g) & ~(~j & f));

assign hex5 = (~(~j & ~f) & ~(~f & g) & ~(~j & g) & ~h);

assign hex6 = (((~f & ~g)||(f & g)) & ~(~j & f) & ~h);

assign hex00 = ~i;

assign hex01 = ~i;

endmodule


