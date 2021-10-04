module VerticalCnt(vga_clk, reset, VcntEnable, VcntValue);
input vga_clk, reset, VcntEnable;
output reg [8:0] VcntValue=0;

always @(posedge vga_clk or posedge reset) 
begin
	if (reset) 
	begin
	VcntValue <= 0;
	end
	else
		begin
		 if(VcntEnable == 1'b1)
			  begin
				if(VcntValue < 449) //metraw 449
					begin
					 VcntValue <= VcntValue + 1;
					end
				else
					begin
					 VcntValue <= 0;
					end
				end
		end
end
endmodule
