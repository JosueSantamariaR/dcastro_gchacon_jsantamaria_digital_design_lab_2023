//Testbench para el módulo de conversión de binario a BCD
module Problema1_tb();
		logic a,b,c,d,e,f,g,h,i;
		Problema1 modulo (a,b,c,d,hex0, hex1, hex2, hex3, hex4, hex5, hex6,hex00);
		initial begin
		//Se realizan las pruebas para todos los numeros que se pueden representar con 4 bits
		a = 0;
		b = 0;
		c = 0;
		d = 0;
		#100;

		a = 0;
		b = 0;
		c = 0;
		d = 1;
		#100;

		a = 0;
		b = 0;
		c = 1;
		d = 0;
		#100;

		a = 0;
		b = 0;
		c = 1;
		d = 1;
		#100;

		a = 0;
		b = 1;
		c = 0;
		d = 0;
		#100;

		a = 0;
		b = 1;
		c = 0;
		d = 1;
		#100;

		a = 0;
		b = 1;
		c = 1;
		d = 0;
		#100;

		a = 0;
		b = 1;
		c = 1;
		d = 1;
		#100;

		a = 1;
		b = 0;
		c = 0;
		d = 0;
		#100;

		a = 1;
		b = 0;
		c = 0;
		d = 1;
		#100;

		a = 1;
		b = 0;
		c = 1;
		d = 0;
		#100;

		a = 1;
		b = 0;
		c = 1;
		d = 1;
		#100;

		a = 1;
		b = 1;
		c = 0;
		d = 0;
		#100;

		a = 1;
		b = 1;
		c = 0;
		d = 1;
		#100;

		a = 1;
		b = 1;
		c = 1;
		d = 0;
		#100;

		a = 1;
		b = 1;
		c = 1;
		d = 1;				
		
		end
endmodule
		