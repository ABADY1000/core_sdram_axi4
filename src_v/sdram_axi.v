//-----------------------------------------------------------------
//                    SDRAM Controller (AXI4)
//                           V1.0
//                     Ultra-Embedded.com
//                     Copyright 2015-2019
//
//                 Email: admin@ultra-embedded.com
//
//                         License: GPL
// If you would like a version with a more permissive license for
// use in closed source commercial applications please contact me
// for details.
//-----------------------------------------------------------------
//
// This file is open source HDL; you can redistribute it and/or 
// modify it under the terms of the GNU General Public License as 
// published by the Free Software Foundation; either version 2 of 
// the License, or (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public 
// License along with this file; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------

module sdram_axi
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           inport_awvalid
    ,input  [ 31:0]  inport_awaddr
    ,input  [  3:0]  inport_awid
    ,input  [  7:0]  inport_awlen
    ,input  [  1:0]  inport_awburst
    ,input           inport_wvalid
    ,input  [ 31:0]  inport_wdata
    ,input  [  3:0]  inport_wstrb
    ,input           inport_wlast
    ,input           inport_bready
    ,input           inport_arvalid
    ,input  [ 31:0]  inport_araddr
    ,input  [  3:0]  inport_arid
    ,input  [  7:0]  inport_arlen
    ,input  [  1:0]  inport_arburst
    ,input           inport_rready
    ,input  [ 15:0]  sdram_data_input_i

    // Outputs
    ,output          inport_awready
    ,output          inport_wready
    ,output          inport_bvalid
    ,output [  1:0]  inport_bresp
    ,output [  3:0]  inport_bid
    ,output          inport_arready
    ,output          inport_rvalid
    ,output [ 31:0]  inport_rdata
    ,output [  1:0]  inport_rresp
    ,output [  3:0]  inport_rid
    ,output          inport_rlast
    ,output          sdram_clk_o
    ,output          sdram_cke_o
    ,output          sdram_cs_o
    ,output          sdram_ras_o
    ,output          sdram_cas_o
    ,output          sdram_we_o
    ,output [  1:0]  sdram_dqm_o
    ,output [ 12:0]  sdram_addr_o
    ,output [  1:0]  sdram_ba_o
    ,output [ 15:0]  sdram_data_output_o
    ,output          sdram_data_out_en_o
);



//-----------------------------------------------------------------
// Key Params
//-----------------------------------------------------------------
parameter SDRAM_MHZ             = 50;
parameter SDRAM_ADDR_W          = 24;
parameter SDRAM_COL_W           = 9;
parameter SDRAM_READ_LATENCY    = 2;

//-----------------------------------------------------------------
// AXI Interface
//-----------------------------------------------------------------
wire [ 31:0]  ram_addr_w;
wire [  3:0]  ram_wr_w;
wire          ram_rd_w;
wire          ram_accept_w;
wire [ 31:0]  ram_write_data_w;
wire [ 31:0]  ram_read_data_w;
wire [  7:0]  ram_len_w;
wire          ram_ack_w;
wire          ram_error_w;

sdram_axi_pmem
u_axi
(
    .clk_i(clk_i),
    .rst_i(rst_i),

    // AXI port
    .axi_awvalid_i(inport_awvalid),
    .axi_awaddr_i(inport_awaddr),
    .axi_awid_i(inport_awid),
    .axi_awlen_i(inport_awlen),
    .axi_awburst_i(inport_awburst),
    .axi_wvalid_i(inport_wvalid),
    .axi_wdata_i(inport_wdata),
    .axi_wstrb_i(inport_wstrb),
    .axi_wlast_i(inport_wlast),
    .axi_bready_i(inport_bready),
    .axi_arvalid_i(inport_arvalid),
    .axi_araddr_i(inport_araddr),
    .axi_arid_i(inport_arid),
    .axi_arlen_i(inport_arlen),
    .axi_arburst_i(inport_arburst),
    .axi_rready_i(inport_rready),
    .axi_awready_o(inport_awready),
    .axi_wready_o(inport_wready),
    .axi_bvalid_o(inport_bvalid),
    .axi_bresp_o(inport_bresp),
    .axi_bid_o(inport_bid),
    .axi_arready_o(inport_arready),
    .axi_rvalid_o(inport_rvalid),
    .axi_rdata_o(inport_rdata),
    .axi_rresp_o(inport_rresp),
    .axi_rid_o(inport_rid),
    .axi_rlast_o(inport_rlast),
    
    // RAM interface
    .ram_addr_o(ram_addr_w),
    .ram_accept_i(ram_accept_w),
    .ram_wr_o(ram_wr_w),
    .ram_rd_o(ram_rd_w),
    .ram_len_o(ram_len_w),
    .ram_write_data_o(ram_write_data_w),
    .ram_ack_i(ram_ack_w),
    .ram_error_i(ram_error_w),
    .ram_read_data_i(ram_read_data_w)
);

//-----------------------------------------------------------------
// SDRAM Controller
//-----------------------------------------------------------------
sdram_axi_core
#(
     .SDRAM_MHZ(SDRAM_MHZ)
    ,.SDRAM_ADDR_W(SDRAM_ADDR_W)
    ,.SDRAM_COL_W(SDRAM_COL_W)
    ,.SDRAM_READ_LATENCY(SDRAM_READ_LATENCY)
)
u_core
(
     .clk_i(clk_i)
    ,.rst_i(rst_i)

    ,.inport_wr_i(ram_wr_w)
    ,.inport_rd_i(ram_rd_w)
    ,.inport_len_i(ram_len_w)
    ,.inport_addr_i(ram_addr_w)
    ,.inport_write_data_i(ram_write_data_w)
    ,.inport_accept_o(ram_accept_w)
    ,.inport_ack_o(ram_ack_w)
    ,.inport_error_o(ram_error_w)
    ,.inport_read_data_o(ram_read_data_w)

    ,.sdram_clk_o(sdram_clk_o)
    ,.sdram_cke_o(sdram_cke_o)
    ,.sdram_cs_o(sdram_cs_o)
    ,.sdram_ras_o(sdram_ras_o)
    ,.sdram_cas_o(sdram_cas_o)
    ,.sdram_we_o(sdram_we_o)
    ,.sdram_dqm_o(sdram_dqm_o)
    ,.sdram_addr_o(sdram_addr_o)
    ,.sdram_ba_o(sdram_ba_o)
    ,.sdram_data_output_o(sdram_data_output_o)
    ,.sdram_data_out_en_o(sdram_data_out_en_o)
    ,.sdram_data_input_i(sdram_data_input_i)
);



endmodule
