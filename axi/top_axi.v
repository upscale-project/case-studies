// Naming scheme
// m_axi_* for AXI signals that the master drives
// s_axi_* for AXI signals that the slave drives

// (* keep *) tell the frontend to keep the signal/module even if it does not
//            drive an output

/*************************************************************************
 * Declare any free signals in the module declaration
 */

`define CFG_ASIC 0
module top_axi(axi_aclk, axi_aresetn,
	       // Free inputs for master
	       m_wr_access, m_wr_packet, m_rd_access, m_rd_packet, m_rr_wait,
	       // Free inputs for slave
	       s_wr_wait, s_rd_wait, s_rr_access, s_rr_packet,
	       // Outputs
	       // AXI Master emesh outputs
	       m_wr_wait, m_rd_wait, m_rr_access, m_rr_packet,
	       // AXI Slave emesh outputs
	       s_wr_access, s_wr_packet, s_rd_access, s_rd_packet, s_rr_wait
	       );
   parameter IDW  = 12;
   parameter PW     = 104;
   parameter AW     = 32;
   parameter DW     = 32;

   (* keep *)
   input wire  	       axi_aclk;    // global clock signal.
   (* keep *)
   input wire  	       axi_aresetn; // global reset singal.


   /*************************************************************************
    * Declare any free signals here as inputs
    */

   //########################
   //EMESH INTERFACES
   //########################

   // Free master signals
   // Write request
   input wire 	       m_wr_access;
   input wire 	       m_wr_packet;

   // Read request
   input wire 	       m_rd_access;
   input wire 	       m_rd_packet;

   // Read response
   input wire 	       m_rr_wait;

   // Free inputs for slave
   // Write request
   input wire 	       s_wr_wait;

   // Read request
   input wire 	       s_rd_wait;

   // Read response
   input wire 	       s_rr_access;
   input wire 	       s_rr_packet;


   // AXI Master emesh outputs
   // Write request
   output wire 	       m_wr_wait;

   // Read request
   output wire 	       m_rd_wait;

   // Read response
   output wire 	       m_rr_access;
   output wire 	       m_rr_packet;

   // AXI Slave emesh outputs
   // Write request
   output wire 	       s_wr_access;
   output wire 	       s_wr_packet;

   // Read request
   output wire 	       s_rd_access;
   output wire 	       s_rd_packet;

   // Read response
   output wire 	       s_rr_wait;

   /*************************************************************************
    * Instantiate and wire-up AXI master module here
    */

   //########################
   //AXI MASTER INTERFACE
   //########################

   //Write address channel
   (* keep *)
   wire [IDW-1:0] m_axi_awid;    // write address ID
   (* keep *)
   wire [31 : 0]  m_axi_awaddr;  // master interface write address
   (* keep *)
   wire [7 : 0]   m_axi_awlen;   // burst length.
   (* keep *)
   wire [2 : 0]   m_axi_awsize;  // burst size.
   (* keep *)
   wire [1 : 0]   m_axi_awburst; // burst type.
   (* keep *)
   wire           m_axi_awlock;  // lock type
   (* keep *)
   wire [3 : 0]   m_axi_awcache; // memory type.
   (* keep *)
   wire [2 : 0]   m_axi_awprot;  // protection type.
   (* keep *)
   wire [3 : 0]   m_axi_awqos;   // quality of service
   (* keep *)
   wire           m_axi_awvalid; // write address valid
   (* keep *)
   wire           s_axi_awready; // write address ready

   //Write data channel
   (* keep *)
   wire [IDW-1:0] m_axi_wid;
   (* keep *)
   wire [63 : 0]  m_axi_wdata;   // master interface write data.
   (* keep *)
   wire [7 : 0]   m_axi_wstrb;   // byte write strobes
   (* keep *)
   wire           m_axi_wlast;   // last transfer in a write burst.
   (* keep *)
   wire           m_axi_wvalid;  // indicates data is ready to go
   (* keep *)
   wire           s_axi_wready;  // slave is ready for data

   //Write response channel
   (* keep *)
   wire [IDW-1:0] s_axi_bid;
   (* keep *)
   wire [1 : 0]   s_axi_bresp;   // status of the write transaction.
   (* keep *)
   wire           s_axi_bvalid;  // channel is a valid write response
   (* keep *)
   wire           m_axi_bready;  // master can accept write response.

   //Read address channel
   (* keep *)
   wire [IDW-1:0] m_axi_arid;    // read address ID
   (* keep *)
   wire [31 : 0]  m_axi_araddr;  // initial address of a read burst
   (* keep *)
   wire [7 : 0]   m_axi_arlen;   // burst length
   (* keep *)
   wire [2 : 0]   m_axi_arsize;  // burst size
   (* keep *)
   wire [1 : 0]   m_axi_arburst; // burst type
   (* keep *)
   wire           m_axi_arlock;  // lock type
   (* keep *)
   wire [3 : 0]   m_axi_arcache; // memory type
   (* keep *)
   wire [2 : 0]   m_axi_arprot;  // protection type
   (* keep *)
   wire [3 : 0]   m_axi_arqos;   // quality of service info
   (* keep *)
   wire           m_axi_arvalid; // valid read address
   (* keep *)
   wire           s_axi_arready; // slave is ready to accept an address

   //Read data channel
   (* keep *)
   wire [IDW-1:0] s_axi_rid;     // read data ID
   (* keep *)
   wire [63 : 0]  s_axi_rdata;   // master read data
   (* keep *)
   wire [1 : 0]   s_axi_rresp;   // status of the read transfer
   (* keep *)
   wire           s_axi_rlast;   // last transfer in a read burst
   (* keep *)
   wire           s_axi_rvalid;  // signaling the required read data
   (* keep *)
   wire           m_axi_rready;  // master can accept the readback data

   (* keep *)
   emaxi
     #(.M_IDW(IDW),
       .PW(PW),
       .AW(AW),
       .DW(DW))
   master (.wr_wait(m_wr_wait),
           .rd_wait(m_rd_wait),
           .rr_access(m_rr_access),
           .rr_packet(m_rr_packet),
           .m_axi_awid(m_axi_awid),
           .m_axi_awaddr(m_axi_awaddr),
           .m_axi_awlen(m_axi_awlen),
           .m_axi_awsize(m_axi_awsize),
           .m_axi_awburst(m_axi_awburst),
           .m_axi_awlock(m_axi_awlock),
           .m_axi_awcache(m_axi_awcache),
           .m_axi_awprot(m_axi_awprot),
           .m_axi_awqos(m_axi_awqos),
           .m_axi_awvalid(m_axi_awvalid),
           .m_axi_wid(m_axi_wid),
           .m_axi_wdata(m_axi_wdata),
           .m_axi_wstrb(m_axi_wstrb),
           .m_axi_wlast(m_axi_wlast),
           .m_axi_wvalid(m_axi_wvalid),
           .m_axi_bready(m_axi_bready),
           .m_axi_arid(m_axi_arid),
           .m_axi_araddr(m_axi_araddr),
           .m_axi_arlen(m_axi_arlen),
           .m_axi_arsize(m_axi_arsize),
           .m_axi_arburst(m_axi_arburst),
           .m_axi_arlock(m_axi_arlock),
           .m_axi_arcache(m_axi_arcache),
           .m_axi_arprot(m_axi_arprot),
           .m_axi_arqos(m_axi_arqos),
           .m_axi_arvalid(m_axi_arvalid),
           .m_axi_rready(m_axi_rready),
           // Inputs
           .wr_access(m_wr_access),
           .wr_packet(m_wr_packet),
           .rd_access(m_rd_access),
           .rd_packet(m_rd_packet),
           .rr_wait(m_rr_wait),
           .m_axi_aclk(axi_aclk),
           .m_axi_aresetn(axi_aresetn),
           .m_axi_awready(s_axi_awready),
           .m_axi_wready(s_axi_wready),
           .m_axi_bid(s_axi_bid),
           .m_axi_bresp(s_axi_bresp),
           .m_axi_bvalid(s_axi_bvalid),
           .m_axi_arready(s_axi_arready),
           .m_axi_rid(s_axi_rid),
           .m_axi_rdata(s_axi_rdata),
           .m_axi_rresp(s_axi_rresp),
           .m_axi_rlast(s_axi_rlast),
           .m_axi_rvalid(s_axi_rvalid)
           );

   /*************************************************************************
    * Instantiate and wire-up AXI slave module here
    */

     (* keep *)
     esaxi
       #(.S_IDW(IDW),
         .PW(PW),
         .AW(AW),
         .DW(DW))
   slave (// Outputs
          .wr_access(s_wr_access),
          .wr_packet(s_wr_packet),
          .rd_access(s_rd_access),
          .rd_packet(s_rd_packet),
          .rr_wait(s_rr_wait),
          .s_axi_arready(s_axi_arready),
          .s_axi_awready(s_axi_awready),
          .s_axi_bid(s_axi_bid),
          .s_axi_bresp(s_axi_bresp),
          .s_axi_bvalid(s_axi_bvalid),
          .s_axi_rid(s_axi_rid),
          .s_axi_rdata(s_axi_rdata),
          .s_axi_rlast(s_axi_rlast),
          .s_axi_rresp(s_axi_rresp),
          .s_axi_rvalid(s_axi_rvalid),
          .s_axi_wready(s_axi_wready),
          // Inputs
          .wr_wait(s_wr_wait),
          .rd_wait(s_rd_wait),
          .rr_access(s_rr_access),
          .rr_packet(s_rr_packet),
          .s_axi_aclk(axi_aclk),
          .s_axi_aresetn(axi_aresetn),
          .s_axi_arid(m_axi_arid),
          .s_axi_araddr(m_axi_araddr),
          .s_axi_arburst(m_axi_arburst),
          .s_axi_arcache(m_axi_arcache),
          .s_axi_arlock(m_axi_arlock),
          .s_axi_arlen(m_axi_arlen),
          .s_axi_arprot(m_axi_arprot),
          .s_axi_arqos(m_axi_arqos),
          .s_axi_arsize(m_axi_arsize),
          .s_axi_arvalid(m_axi_arvalid),
          .s_axi_awid(m_axi_awid),
          .s_axi_awaddr(m_axi_awaddr),
          .s_axi_awburst(m_axi_awburst),
          .s_axi_awcache(m_axi_awcache),
          .s_axi_awlock(m_axi_awlock),
          .s_axi_awlen(m_axi_awlen),
          .s_axi_awprot(m_axi_awprot),
          .s_axi_awqos(m_axi_awqos),
          .s_axi_awsize(m_axi_awsize),
          .s_axi_awvalid(m_axi_awvalid),
          .s_axi_bready(m_axi_bready),
          .s_axi_rready(m_axi_rready),
          .s_axi_wid(m_axi_wid),
          .s_axi_wdata(m_axi_wdata),
          .s_axi_wlast(m_axi_wlast),
          .s_axi_wstrb(m_axi_wstrb),
          .s_axi_wvalid(m_axi_wvalid)
          );

endmodule // top_axi
