`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/26 10:49:28
// Design Name: 
// Module Name: image_template
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module image_template
(
	input   wire				i_clk,
	input   wire				i_rst_n,

	input	wire				i_en,
	input	wire [7:0]			i_data,

	output	reg 				o_en,
	
	output  reg [7:0]			o_temp_11,
	output  reg [7:0]			o_temp_12,
	output reg [7:0]			o_temp_13,
	output  reg [7:0]			o_temp_21,
    output  reg [7:0]			o_temp_22,
    output  reg [7:0]			o_temp_23
//	output  reg [7:0]			o_temp_31,
//	output  reg [7:0]			o_temp_32,
//	output  reg [7:0]			o_temp_33
	
	
);


  

  
	
parameter  H_ACTIVE = 1280; //图像宽度                              
parameter  V_ACTIVE = 720;  //图像高度

reg  [10:0]	h_cnt;
reg  [10:0]	v_cnt;

wire [7:0]	fifo_1_in;
wire 		fifo_1_wr_en;
wire 		fifo_1_rd_en;
wire [7:0]	fifo_1_out;

//wire [7:0]	fifo_2_in;
//wire 		fifo_2_wr_en;
//wire 		fifo_2_rd_en;
//wire [7:0]	fifo_2_out;

//显示区域行计数
always@(posedge i_clk or negedge i_rst_n) 
begin
    if(!i_rst_n)
	begin
        h_cnt <= 11'd0;
    end
    else if(i_en)
	begin
		if(h_cnt == H_ACTIVE - 1'b1)
			h_cnt <= 11'd0;
		else 
			h_cnt <= h_cnt + 11'd1;
    end
end

//显示区域场计数
always@(posedge i_clk or negedge i_rst_n) 
begin
    if(!i_rst_n)
	begin
        v_cnt <= 11'd0;
    end
    else if(h_cnt == H_ACTIVE - 1'b1)
	begin
		if(v_cnt == V_ACTIVE - 1'b1)
			v_cnt <= 11'd0;
		else 
			v_cnt <= v_cnt + 11'd1;
    end
end

assign fifo_1_in	= i_data;
assign fifo_1_wr_en	= (v_cnt < V_ACTIVE - 1) ? i_en : 1'b0;
assign fifo_1_rd_en	= (v_cnt > 0 ) ? i_en : 1'b0;

//assign fifo_2_in	= fifo_1_out;
//assign fifo_2_wr_en	= fifo_1_rd_en && (v_cnt < V_ACTIVE - 2);
//assign fifo_2_rd_en	= (v_cnt > 1 ) ? i_en : 1'b0;



//fifo_generator_0 u_fifo_1(
//	.clk		(i_clk			), 
//	.srst		(!i_rst_n		), 
//	.din 		(fifo_1_in		),
//	.wr_en		(fifo_1_wr_en	),
//	.rd_en		(fifo_1_rd_en	),
//	.dout 		(fifo_1_out		),
//	.full 		(				),
//	.empty		(				), 
//	.data_count	(				)
//);

fifo_generator_0 u_fifo_1(
	.clk		(i_clk			), 
	.srst		(!i_rst_n		), 
	.din 		(fifo_1_in		),
	.wr_en		(fifo_1_wr_en	),
	.rd_en		(fifo_1_rd_en	),
	.dout 		(fifo_1_out		),
	.full 		(				),
	.empty		(				), 
	.data_count	(				)
);

//fifo_generator_0 u_fifo_2(
//	.clk		(i_clk			), 
//	.srst		(!i_rst_n		), 
//	.din 		(fifo_2_in		),
//	.wr_en		(fifo_2_wr_en	),
//	.rd_en		(fifo_2_rd_en	),
//	.dout 		(fifo_2_out		),  
//	.full 		(				),
//	.empty		(				), 
//	.data_count	(				)
//);


always@(posedge i_clk or negedge i_rst_n) 
begin
    if(!i_rst_n) 
	begin
		o_temp_11	<= 8'd0;
		o_temp_12	<= 8'd0;
		o_temp_13	<= 8'd0;
		
		o_temp_21	<= 8'd0;
		o_temp_22	<= 8'd0;
		o_temp_23	<= 8'd0;
		
//		o_temp_31	<= 8'd0;
//		o_temp_32	<= 8'd0;
//		o_temp_33	<= 8'd0;
    end
	else if(v_cnt == 0)
	begin
		if(h_cnt == 0)
		begin
			o_temp_11	<= i_data;
			o_temp_12	<= i_data;
			o_temp_13	<= i_data;
			o_temp_21	<= i_data;
			o_temp_22	<= i_data;
			o_temp_23	<= i_data;
//			o_temp_31	<= i_data;
//			o_temp_32	<= i_data;
//			o_temp_33	<= i_data;	
		end
		else
		begin
			o_temp_11	<= o_temp_12;
			o_temp_12	<= o_temp_13;
			o_temp_13	<= i_data;
			o_temp_21	<= o_temp_22;
			o_temp_22	<= o_temp_23;
			o_temp_23	<= i_data;
//			o_temp_31	<= o_temp_32;
//			o_temp_32	<= o_temp_33;
//			o_temp_33	<= i_data;	
		end		
	end	
	else if(v_cnt == 1)
	begin
		if(h_cnt == 0)
		begin
			o_temp_11	<= fifo_1_out;
			o_temp_12	<= fifo_1_out;
			o_temp_13	<= fifo_1_out;
			o_temp_21	<= i_data;
			o_temp_22	<= i_data;
			o_temp_23	<= i_data;
//			o_temp_31	<= i_data;
//			o_temp_32	<= i_data;
//			o_temp_33	<= i_data;	
		end
		else
		begin
			o_temp_11	<= o_temp_12;
			o_temp_12	<= o_temp_13;
			o_temp_13	<= fifo_1_out;
			o_temp_21	<= o_temp_22;
			o_temp_22	<= o_temp_23;
			o_temp_23	<= i_data;
//			o_temp_31	<= o_temp_32;
//			o_temp_32	<= o_temp_33;
//			o_temp_33	<= i_data;	
		end		
	end		
	else
	begin
		if(h_cnt == 0)
		begin
			o_temp_11	<= fifo_1_out;
			o_temp_12	<= fifo_1_out;
			o_temp_13	<= fifo_1_out;
			o_temp_21	<= i_data;
			o_temp_22	<= i_data;
			o_temp_23	<= i_data;
//			o_temp_31	<= i_data;
//			o_temp_32	<= i_data;
//			o_temp_33	<= i_data;	
		end	
		else
		begin
			o_temp_11	<= o_temp_12;
			o_temp_12	<= o_temp_13;
			o_temp_13	<= fifo_1_out;			
			o_temp_21	<= o_temp_22;
			o_temp_22	<= o_temp_23;
			o_temp_23	<= i_data;			
//			o_temp_31	<= o_temp_32;
//			o_temp_32	<= o_temp_33;
//			o_temp_33	<= i_data;	
		end
	end	
end

always@(posedge i_clk or negedge i_rst_n) 
begin
    if(!i_rst_n) 
	begin
		o_en	<= 1'b0;
    end
	else if((v_cnt > 1)&&(h_cnt > 1))
	begin
		o_en	<= i_en;
	end
	else
	begin
		o_en	<= 1'b0;
	end	
end



endmodule

