module clock_divider(reset, clk, vga_clk);
  input reset, clk;
  output reg vga_clk = 0;
  
  integer counter = 0;

  always@ (posedge reset or posedge clk)
  begin
    if (reset) 
      begin
        counter = 0;
      end
    else if(counter == 1) //divvalue = 100MHz/(2*desired Freq) - 1 = 1
      begin
			counter = 0; //reset value
			vga_clk <= ~vga_clk;
      end
    else
      begin
			counter = counter + 1;
      end
  end
endmodule


/*`timescale 1ns / 1ps
module testbench;
reg clk = 0;
reg reset = 0;
wire vga_clk;

clock_divider UUT( 
.reset(reset), 
.clk(clk), 
.vga_clk(vga_clk)
);
always #5 clk = ~clk;
endmodule */


//(25*10^6/2*1)-1=12499999