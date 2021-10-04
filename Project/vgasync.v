module vgasync(reset, clk25, HcntValue, VcntValue, hsync, vsync, red, green, blue, scancode, found);
input clk25, found, reset;
input [7:0] scancode;
input [9:0] HcntValue;
input [8:0] VcntValue;

output hsync, vsync;
output [2:0] red, green, blue;
integer counter = 0;
wire [3:0] section;
reg [8:0] r_rgb1, r_rgb2, r_rgb3, r_rgb4, r_rgb5, r_rgb6, r_rgb7, r_rgb8, r_rgb9;
reg [4:0] zone;
reg flag = 1;

/*
h_front_porch = 16
h_sync_pulse = 96
h_back_porch = 48

v_front_porch = 12
v_sync_pulse = 2
v_back_porch = 35
*/

assign hsync = (HcntValue > 15 && HcntValue < 112) ? 0:1; //high apo 16 - 111
assign vsync = (VcntValue > 11 && VcntValue < 14) ? 1:0; //high apo 12 - 13

assign section =	 ((HcntValue > 160 && HcntValue <= 373) && (VcntValue >  48 && VcntValue <= 182)) ? 4'd1 :																	

					 ((HcntValue > 373 && HcntValue <= 586) && (VcntValue >  48 && VcntValue <= 182)) ? 4'd2 : 

					 ((HcntValue > 586 && HcntValue <= 799) && (VcntValue >  48 && VcntValue <= 182)) ? 4'd3 : 

					 ((HcntValue > 160 && HcntValue <= 373) && (VcntValue > 182 && VcntValue <= 315)) ? 4'd4 : 

                	 ((HcntValue > 373 && HcntValue <= 586) && (VcntValue > 182 && VcntValue <= 315)) ? 4'd5 : 

					 ((HcntValue > 586 && HcntValue <= 799) && (VcntValue > 182 && VcntValue <= 315)) ? 4'd6 : 

					 ((HcntValue > 160 && HcntValue <= 373) && (VcntValue > 315 && VcntValue <= 448)) ? 4'd7 : 

					 ((HcntValue > 373 && HcntValue <= 586) && (VcntValue > 315 && VcntValue <= 448)) ? 4'd8 :
					 
					 ((HcntValue > 586 && HcntValue <= 799) && (VcntValue > 315 && VcntValue <= 448)) ? 4'd9 : 4'd0;
					 
always @(posedge clk25 or posedge reset) 
begin
	if(reset)
		begin
			zone<=0;
		end
	else if(found)
	begin
		zone <=	 (scancode == 8'h15) ? 4'd0 : //Q reset
				 (scancode == 8'h16) ? 4'd1 : //1
				 (scancode == 8'h1E) ? 4'd2 : //2
				 (scancode == 8'h26) ? 4'd3 : //3
				 (scancode == 8'h25) ? 4'd4 : //4
				 (scancode == 8'h2E) ? 4'd5 : //5
				 (scancode == 8'h36) ? 4'd6 : //6	
				 (scancode == 8'h3D) ? 4'd7 : //7
				 (scancode == 8'h3E) ? 4'd8 : //8	
				 (scancode == 8'h46) ? 4'd9 : //9
				 (scancode == 8'h35) ? 4'd10 : //Y Greek Flag
				 (scancode == 8'h3C) ? 4'd11 : //U Snace colors
				 (scancode == 8'h4B) ? 4'd12 : zone;//L Loop 
		
		if(zone==1)
			begin
			r_rgb1<= 	(scancode == 8'h2d) ? 9'b111000000 : //red
						(scancode == 8'h34) ? 9'b000111000 : //green
						(scancode == 8'h24) ? 9'b000111111 : //cyan
						(scancode == 8'h1D) ? 9'b111111111 : //white
						(scancode == 8'h32) ? 9'b000000111 : r_rgb1; //blue
			end
		if(zone==2)
			begin
			r_rgb2<= 	(scancode == 8'h2d) ? 9'b111000000 :
						(scancode == 8'h34) ? 9'b000111000 :
						(scancode == 8'h24) ? 9'b000111111 :
						(scancode == 8'h1D) ? 9'b111111111 :
						(scancode == 8'h32) ? 9'b000000111 : r_rgb2;
			end
		if(zone==3) 
			begin
			r_rgb3<= 	(scancode == 8'h2d) ? 9'b111000000 :
						(scancode == 8'h34) ? 9'b000111000 :
						(scancode == 8'h24) ? 9'b000111111 :
						(scancode == 8'h1D) ? 9'b111111111 :
						(scancode == 8'h32) ? 9'b000000111 : r_rgb3;
			end
		if(zone==4) 
			begin
			r_rgb4<= 	(scancode == 8'h2d) ? 9'b111000000 :
						(scancode == 8'h34) ? 9'b000111000 :
						(scancode == 8'h24) ? 9'b000111111 :
						(scancode == 8'h1D) ? 9'b111111111 :
						(scancode == 8'h32) ? 9'b000000111 : r_rgb4;
			end
		if(zone==5) 
			begin
			r_rgb5<= 	(scancode == 8'h2d) ? 9'b111000000 :
						(scancode == 8'h34) ? 9'b000111000 :
						(scancode == 8'h24) ? 9'b000111111 :
						(scancode == 8'h1D) ? 9'b111111111 :
						(scancode == 8'h32) ? 9'b000000111 : r_rgb5;
			end
		if(zone==6) 
			begin
			r_rgb6<= 	(scancode == 8'h2d) ? 9'b111000000 :
						(scancode == 8'h34) ? 9'b000111000 :
						(scancode == 8'h24) ? 9'b000111111 :
						(scancode == 8'h1D) ? 9'b111111111 :
						(scancode == 8'h32) ? 9'b000000111 : r_rgb6;
			end
		if(zone==7) 
			begin
			r_rgb7<= 	(scancode == 8'h2d) ? 9'b111000000 :
						(scancode == 8'h34) ? 9'b000111000 :
						(scancode == 8'h24) ? 9'b000111111 :
						(scancode == 8'h1D) ? 9'b111111111 :
						(scancode == 8'h32) ? 9'b000000111 : r_rgb7;
			end
		if(zone==8) 
			begin
			r_rgb8<= 	(scancode == 8'h2d) ? 9'b111000000 :
						(scancode == 8'h34) ? 9'b000111000 :
						(scancode == 8'h24) ? 9'b000111111 :
						(scancode == 8'h1D) ? 9'b111111111 :
						(scancode == 8'h32) ? 9'b000000111 : r_rgb8;
			end
		if(zone==9) 
			begin
			r_rgb9<= 	(scancode == 8'h2d) ? 9'b111000000 :
						(scancode == 8'h34) ? 9'b000111000 :
						(scancode == 8'h24) ? 9'b000111111 :
						(scancode == 8'h1D) ? 9'b111111111 :
						(scancode == 8'h32) ? 9'b000000111 : r_rgb9;
			end
		if(zone == 0) //reset with Q
			begin
				r_rgb1 <= 9'b000000000;
				r_rgb2 <= 9'b000000000;
				r_rgb3 <= 9'b000000000;
				r_rgb4 <= 9'b000000000;
				r_rgb5 <= 9'b000000000;
				r_rgb6 <= 9'b000000000;
				r_rgb7 <= 9'b000000000;
				r_rgb8 <= 9'b000000000;
				r_rgb9 <= 9'b000000000;
				
				flag <= 1;
			end
		if(zone == 10) //greek flag with Y
			begin
				r_rgb1 <= 9'b111111111;
				r_rgb3 <= 9'b111111111;
				r_rgb7 <= 9'b111111111;
				r_rgb9 <= 9'b111111111;
				r_rgb2 <= 9'b000111111;
				r_rgb4 <= 9'b000111111;
				r_rgb5 <= 9'b000111111;
				r_rgb6 <= 9'b000111111;
				r_rgb8 <= 9'b000111111;
				
			end
		if(zone == 12) // loop with L
			begin
				flag <= 0;
			end
		if(zone == 11) //red snake with U
		begin
				r_rgb1 <= 9'b111000000;
				r_rgb2 <= 9'b110000000;
				r_rgb3 <= 9'b101000000;
				r_rgb6 <= 9'b100000000;
				r_rgb9 <= 9'b011000000;
				r_rgb8 <= 9'b010000000;
				r_rgb7 <= 9'b001000000;
				r_rgb4 <= 9'b000000000;
		end
	end
		else if(flag==0)
					begin
					//loop
					if(counter == 5499999) //2.27Hz
					//if(counter == 12499999) //divvalue = 100MHz/(2*desired Freq) - 1 = 1 //1Hz
					begin
						counter = 0; //reset value
						r_rgb1 <= r_rgb2;
						r_rgb2 <= r_rgb3;
						r_rgb3 <= r_rgb6;
						r_rgb6 <= r_rgb9;
						r_rgb9 <= r_rgb8;
						r_rgb8 <= r_rgb7;
						r_rgb7 <= r_rgb4;
						r_rgb4 <= r_rgb1;
					end
					else
					begin
						counter = counter + 1;
					end
					end
end


assign {red, green, blue} = 		 (section == 4'd1) ? r_rgb1 :
									 (section == 4'd2) ? r_rgb2 :
									 (section == 4'd3) ? r_rgb3 :
									 (section == 4'd4) ? r_rgb4 :
									 (section == 4'd5) ? r_rgb5 :
									 (section == 4'd6) ? r_rgb6 :
									 (section == 4'd7) ? r_rgb7 :
									 (section == 4'd8) ? r_rgb8 :
									 (section == 4'd9) ? r_rgb9 : {3'h0, 3'h0, 3'h0};
endmodule