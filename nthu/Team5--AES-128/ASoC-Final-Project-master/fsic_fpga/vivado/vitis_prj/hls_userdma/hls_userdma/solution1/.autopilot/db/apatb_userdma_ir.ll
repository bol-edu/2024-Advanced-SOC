; ModuleID = '/home/ricky/asoc/final_project/fsic_fpga/vivado/vitis_prj/hls_userdma/hls_userdma/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_uint<2>" = type { %"struct.ap_int_base<2, false>" }
%"struct.ap_int_base<2, false>" = type { %"struct.ssdm_int<2, false>" }
%"struct.ssdm_int<2, false>" = type { i2 }
%"struct.ap_int<32>" = type { %"struct.ap_int_base<32, true>" }
%"struct.ap_int_base<32, true>" = type { %"struct.ssdm_int<32, true>" }
%"struct.ssdm_int<32, true>" = type { i32 }
%"struct.ap_int<1>" = type { %"struct.ap_int_base<1, true>" }
%"struct.ap_int_base<1, true>" = type { %"struct.ssdm_int<1, true>" }
%"struct.ssdm_int<1, true>" = type { i1 }
%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" = type { %"struct.hls::axis<ap_uint<32>, 7, 0, 0, '8', false>" }
%"struct.hls::axis<ap_uint<32>, 7, 0, 0, '8', false>" = type { %"struct.ap_int<32>", %"struct.ap_uint<4>", %"struct.ap_uint<4>", %"struct.ap_uint<7>", %"struct.ap_int<1>", %"struct.hls::axis_disabled_signal", %"struct.hls::axis_disabled_signal" }
%"struct.ap_uint<4>" = type { %"struct.ap_int_base<4, false>" }
%"struct.ap_int_base<4, false>" = type { %"struct.ssdm_int<4, false>" }
%"struct.ssdm_int<4, false>" = type { i4 }
%"struct.ap_uint<7>" = type { %"struct.ap_int_base<7, false>" }
%"struct.ap_int_base<7, false>" = type { %"struct.ssdm_int<7, false>" }
%"struct.ssdm_int<7, false>" = type { i7 }
%"struct.hls::axis_disabled_signal" = type { i8 }

; Function Attrs: noinline
define void @apatb_userdma_ir(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias nonnull dereferenceable(12) %inStreamTop, i1* noalias nocapture nonnull %s2m_buf_sts, %"struct.ap_int<32>"* nocapture readonly %s2m_len, %"struct.ap_int<1>"* nocapture readonly %s2m_enb_clrsts, %"struct.ap_int<32>"* noalias nocapture nonnull "fpga.decayed.dim.hint"="1024" "maxi" %s2mbuf, %"struct.ap_uint<2>"* noalias nocapture nonnull %s2m_err, %"struct.ap_int<32>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="1024" "maxi" %m2sbuf, i1* noalias nocapture nonnull %m2s_buf_sts, i32 %m2s_len, %"struct.ap_int<1>"* nocapture readonly %m2s_enb_clrsts, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias nonnull dereferenceable(12) %outStreamTop, i1 zeroext %endianness) local_unnamed_addr #0 {
entry:
  %inStreamTop_copy.data = alloca i32, align 512
  %inStreamTop_copy.keep = alloca i4, align 512
  %inStreamTop_copy.strb = alloca i4, align 512
  %inStreamTop_copy.user = alloca i7, align 512
  %inStreamTop_copy.last = alloca i1, align 512
  %s2m_buf_sts_copy = alloca i1, align 512
  %malloccall = call i8* @malloc(i64 4096)
  %s2mbuf_copy = bitcast i8* %malloccall to [1024 x i32]*
  %s2m_err_copy = alloca i2, align 512
  %malloccall1 = call i8* @malloc(i64 4096)
  %m2sbuf_copy = bitcast i8* %malloccall1 to [1024 x i32]*
  %m2s_buf_sts_copy = alloca i1, align 512
  %outStreamTop_copy.data = alloca i32, align 512
  %outStreamTop_copy.keep = alloca i4, align 512
  %outStreamTop_copy.strb = alloca i4, align 512
  %outStreamTop_copy.user = alloca i7, align 512
  %outStreamTop_copy.last = alloca i1, align 512
  %0 = bitcast %"struct.ap_int<32>"* %s2mbuf to [1024 x %"struct.ap_int<32>"]*
  %1 = bitcast %"struct.ap_int<32>"* %m2sbuf to [1024 x %"struct.ap_int<32>"]*
  call fastcc void @copy_in(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* nonnull %inStreamTop, i32* nonnull align 512 %inStreamTop_copy.data, i4* nonnull align 512 %inStreamTop_copy.keep, i4* nonnull align 512 %inStreamTop_copy.strb, i7* nonnull align 512 %inStreamTop_copy.user, i1* nonnull align 512 %inStreamTop_copy.last, i1* nonnull %s2m_buf_sts, i1* nonnull align 512 %s2m_buf_sts_copy, [1024 x %"struct.ap_int<32>"]* nonnull %0, [1024 x i32]* %s2mbuf_copy, %"struct.ap_uint<2>"* nonnull %s2m_err, i2* nonnull align 512 %s2m_err_copy, [1024 x %"struct.ap_int<32>"]* nonnull %1, [1024 x i32]* %m2sbuf_copy, i1* nonnull %m2s_buf_sts, i1* nonnull align 512 %m2s_buf_sts_copy, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* nonnull %outStreamTop, i32* nonnull align 512 %outStreamTop_copy.data, i4* nonnull align 512 %outStreamTop_copy.keep, i4* nonnull align 512 %outStreamTop_copy.strb, i7* nonnull align 512 %outStreamTop_copy.user, i1* nonnull align 512 %outStreamTop_copy.last)
  call void @apatb_userdma_hw(i32* %inStreamTop_copy.data, i4* %inStreamTop_copy.keep, i4* %inStreamTop_copy.strb, i7* %inStreamTop_copy.user, i1* %inStreamTop_copy.last, i1* %s2m_buf_sts_copy, %"struct.ap_int<32>"* %s2m_len, %"struct.ap_int<1>"* %s2m_enb_clrsts, [1024 x i32]* %s2mbuf_copy, i2* %s2m_err_copy, [1024 x i32]* %m2sbuf_copy, i1* %m2s_buf_sts_copy, i32 %m2s_len, %"struct.ap_int<1>"* %m2s_enb_clrsts, i32* %outStreamTop_copy.data, i4* %outStreamTop_copy.keep, i4* %outStreamTop_copy.strb, i7* %outStreamTop_copy.user, i1* %outStreamTop_copy.last, i1 %endianness)
  call void @copy_back(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %inStreamTop, i32* %inStreamTop_copy.data, i4* %inStreamTop_copy.keep, i4* %inStreamTop_copy.strb, i7* %inStreamTop_copy.user, i1* %inStreamTop_copy.last, i1* %s2m_buf_sts, i1* %s2m_buf_sts_copy, [1024 x %"struct.ap_int<32>"]* %0, [1024 x i32]* %s2mbuf_copy, %"struct.ap_uint<2>"* %s2m_err, i2* %s2m_err_copy, [1024 x %"struct.ap_int<32>"]* %1, [1024 x i32]* %m2sbuf_copy, i1* %m2s_buf_sts, i1* %m2s_buf_sts_copy, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %outStreamTop, i32* %outStreamTop_copy.data, i4* %outStreamTop_copy.keep, i4* %outStreamTop_copy.strb, i7* %outStreamTop_copy.user, i1* %outStreamTop_copy.last)
  call void @free(i8* %malloccall)
  call void @free(i8* %malloccall1)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @copy_in(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias "unpacked"="0", i32* noalias align 512 "unpacked"="1.0" %_V_data_V, i4* noalias align 512 "unpacked"="1.1" %_V_keep_V, i4* noalias align 512 "unpacked"="1.2" %_V_strb_V, i7* noalias align 512 "unpacked"="1.3" %_V_user_V, i1* noalias align 512 "unpacked"="1.4" %_V_last_V, i1* noalias readonly "unpacked"="2", i1* noalias align 512 "unpacked"="3", [1024 x %"struct.ap_int<32>"]* noalias readonly "unpacked"="4", [1024 x i32]* noalias "unpacked"="5", %"struct.ap_uint<2>"* noalias readonly "unpacked"="6", i2* noalias nocapture align 512 "unpacked"="7.0", [1024 x %"struct.ap_int<32>"]* noalias readonly "unpacked"="8", [1024 x i32]* noalias "unpacked"="9", i1* noalias readonly "unpacked"="10", i1* noalias align 512 "unpacked"="11", %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias "unpacked"="12", i32* noalias align 512 "unpacked"="13.0" %_V_data_V1, i4* noalias align 512 "unpacked"="13.1" %_V_keep_V2, i4* noalias align 512 "unpacked"="13.2" %_V_strb_V3, i7* noalias align 512 "unpacked"="13.3" %_V_user_V4, i1* noalias align 512 "unpacked"="13.4" %_V_last_V5) unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"(i32* align 512 %_V_data_V, i4* align 512 %_V_keep_V, i4* align 512 %_V_strb_V, i7* align 512 %_V_user_V, i1* align 512 %_V_last_V, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %2, i1* %1)
  call fastcc void @"onebyonecpy_hls.p0a1024struct.ap_int<32>"([1024 x i32]* %4, [1024 x %"struct.ap_int<32>"]* %3)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<2>"(i2* align 512 %6, %"struct.ap_uint<2>"* %5)
  call fastcc void @"onebyonecpy_hls.p0a1024struct.ap_int<32>"([1024 x i32]* %8, [1024 x %"struct.ap_int<32>"]* %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %10, i1* %9)
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"(i32* align 512 %_V_data_V1, i4* align 512 %_V_keep_V2, i4* align 512 %_V_strb_V3, i7* align 512 %_V_user_V4, i1* align 512 %_V_last_V5, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %11)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i1(i1* noalias align 512 %dst, i1* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i1* %dst, null
  %1 = icmp eq i1* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = bitcast i1* %src to i8*
  %4 = load i8, i8* %3
  %5 = trunc i8 %4 to i1
  store i1 %5, i1* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a1024struct.ap_int<32>"([1024 x %"struct.ap_int<32>"]* %dst, [1024 x %"struct.ap_int<32>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [1024 x %"struct.ap_int<32>"]* %src, null
  %1 = icmp eq [1024 x %"struct.ap_int<32>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [1024 x %"struct.ap_int<32>"], [1024 x %"struct.ap_int<32>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [1024 x %"struct.ap_int<32>"], [1024 x %"struct.ap_int<32>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %3, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<2>"(i2* noalias nocapture align 512 "unpacked"="0.0" %dst, %"struct.ap_uint<2>"* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<2>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.03 = getelementptr %"struct.ap_uint<2>", %"struct.ap_uint<2>"* %src, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i2* %src.0.0.03 to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i2
  store i2 %3, i2* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @copy_out(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias "unpacked"="0", i32* noalias align 512 "unpacked"="1.0" %_V_data_V, i4* noalias align 512 "unpacked"="1.1" %_V_keep_V, i4* noalias align 512 "unpacked"="1.2" %_V_strb_V, i7* noalias align 512 "unpacked"="1.3" %_V_user_V, i1* noalias align 512 "unpacked"="1.4" %_V_last_V, i1* noalias "unpacked"="2", i1* noalias readonly align 512 "unpacked"="3", [1024 x %"struct.ap_int<32>"]* noalias "unpacked"="4", [1024 x i32]* noalias readonly "unpacked"="5", %"struct.ap_uint<2>"* noalias "unpacked"="6", i2* noalias nocapture readonly align 512 "unpacked"="7.0", [1024 x %"struct.ap_int<32>"]* noalias "unpacked"="8", [1024 x i32]* noalias readonly "unpacked"="9", i1* noalias "unpacked"="10", i1* noalias readonly align 512 "unpacked"="11", %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias "unpacked"="12", i32* noalias align 512 "unpacked"="13.0" %_V_data_V1, i4* noalias align 512 "unpacked"="13.1" %_V_keep_V2, i4* noalias align 512 "unpacked"="13.2" %_V_strb_V3, i7* noalias align 512 "unpacked"="13.3" %_V_user_V4, i1* noalias align 512 "unpacked"="13.4" %_V_last_V5) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.61"(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %0, i32* align 512 %_V_data_V, i4* align 512 %_V_keep_V, i4* align 512 %_V_strb_V, i7* align 512 %_V_user_V, i1* align 512 %_V_last_V)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %1, i1* align 512 %2)
  call fastcc void @"onebyonecpy_hls.p0a1024struct.ap_int<32>.40"([1024 x %"struct.ap_int<32>"]* %3, [1024 x i32]* %4)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<2>.16"(%"struct.ap_uint<2>"* %5, i2* align 512 %6)
  call fastcc void @"onebyonecpy_hls.p0a1024struct.ap_int<32>.40"([1024 x %"struct.ap_int<32>"]* %7, [1024 x i32]* %8)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %9, i1* align 512 %10)
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.61"(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %11, i32* align 512 %_V_data_V1, i4* align 512 %_V_keep_V2, i4* align 512 %_V_strb_V3, i7* align 512 %_V_user_V4, i1* align 512 %_V_last_V5)
  ret void
}

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<2>.16"(%"struct.ap_uint<2>"* noalias "unpacked"="0" %dst, i2* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<2>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.04 = getelementptr %"struct.ap_uint<2>", %"struct.ap_uint<2>"* %dst, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i2* %src to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i2
  store i2 %3, i2* %dst.0.0.04, align 1
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a1024struct.ap_int<32>"([1024 x i32]* noalias %dst, [1024 x %"struct.ap_int<32>"]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [1024 x i32]* %dst, null
  %1 = icmp eq [1024 x %"struct.ap_int<32>"]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a1024struct.ap_int<32>.36"([1024 x i32]* nonnull %dst, [1024 x %"struct.ap_int<32>"]* nonnull %src, i64 1024)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a1024struct.ap_int<32>.36"([1024 x i32]* %dst, [1024 x %"struct.ap_int<32>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [1024 x %"struct.ap_int<32>"]* %src, null
  %1 = icmp eq [1024 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [1024 x %"struct.ap_int<32>"], [1024 x %"struct.ap_int<32>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [1024 x i32], [1024 x i32]* %dst, i64 0, i64 %for.loop.idx8
  %4 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %4, i32* %3, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a1024struct.ap_int<32>.40"([1024 x %"struct.ap_int<32>"]* noalias %dst, [1024 x i32]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [1024 x %"struct.ap_int<32>"]* %dst, null
  %1 = icmp eq [1024 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a1024struct.ap_int<32>.43"([1024 x %"struct.ap_int<32>"]* nonnull %dst, [1024 x i32]* nonnull %src, i64 1024)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a1024struct.ap_int<32>.43"([1024 x %"struct.ap_int<32>"]* %dst, [1024 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [1024 x i32]* %src, null
  %1 = icmp eq [1024 x %"struct.ap_int<32>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [1024 x i32], [1024 x i32]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [1024 x %"struct.ap_int<32>"], [1024 x %"struct.ap_int<32>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i32, i32* %3, align 4
  store i32 %4, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"(i32* noalias align 512 "unpacked"="0.0" %dst_V_data_V, i4* noalias align 512 "unpacked"="0.1" %dst_V_keep_V, i4* noalias align 512 "unpacked"="0.2" %dst_V_strb_V, i7* noalias align 512 "unpacked"="0.3" %dst_V_user_V, i1* noalias align 512 "unpacked"="0.4" %dst_V_last_V, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias %src) unnamed_addr #5 {
entry:
  %0 = icmp eq %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call fastcc void @"streamcpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.57"(i32* align 512 %dst_V_data_V, i4* align 512 %dst_V_keep_V, i4* align 512 %dst_V_strb_V, i7* align 512 %dst_V_user_V, i1* align 512 %dst_V_last_V, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* nonnull %src)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"streamcpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.57"(i32* noalias nocapture align 512 "unpacked"="0.0" %_V_data_V, i4* noalias nocapture align 512 "unpacked"="0.1" %_V_keep_V, i4* noalias nocapture align 512 "unpacked"="0.2" %_V_strb_V, i7* noalias nocapture align 512 "unpacked"="0.3" %_V_user_V, i1* noalias nocapture align 512 "unpacked"="0.4" %_V_last_V, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias nocapture) unnamed_addr #6 {
entry:
  %1 = alloca %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"
  %2 = alloca i32
  %3 = alloca i4
  %4 = alloca i4
  %5 = alloca i7
  %6 = alloca i1
  br label %empty

empty:                                            ; preds = %push, %entry
  %7 = bitcast %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %0 to i8*
  %8 = call i1 @fpga_fifo_not_empty_12(i8* %7)
  br i1 %8, label %push, label %ret

push:                                             ; preds = %empty
  %9 = bitcast %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %1 to i8*
  %10 = bitcast %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %0 to i8*
  call void @fpga_fifo_pop_12(i8* %9, i8* %10)
  %11 = load volatile %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>", %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %1
  %.fca.0.0.0.0.0.extract = extractvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %11, 0, 0, 0, 0, 0
  %.fca.0.1.0.0.0.extract = extractvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %11, 0, 1, 0, 0, 0
  %.fca.0.2.0.0.0.extract = extractvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %11, 0, 2, 0, 0, 0
  %.fca.0.3.0.0.0.extract = extractvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %11, 0, 3, 0, 0, 0
  %.fca.0.4.0.0.0.extract = extractvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %11, 0, 4, 0, 0, 0
  store i32 %.fca.0.0.0.0.0.extract, i32* %2
  %12 = bitcast i32* %2 to i8*
  %13 = bitcast i32* %_V_data_V to i8*
  call void @fpga_fifo_push_4(i8* %12, i8* %13)
  store i4 %.fca.0.1.0.0.0.extract, i4* %4
  %14 = bitcast i4* %4 to i8*
  %15 = bitcast i4* %_V_keep_V to i8*
  call void @fpga_fifo_push_1(i8* %14, i8* %15)
  store i4 %.fca.0.2.0.0.0.extract, i4* %3
  %16 = bitcast i4* %3 to i8*
  %17 = bitcast i4* %_V_strb_V to i8*
  call void @fpga_fifo_push_1(i8* %16, i8* %17)
  store i7 %.fca.0.3.0.0.0.extract, i7* %5
  %18 = bitcast i7* %5 to i8*
  %19 = bitcast i7* %_V_user_V to i8*
  call void @fpga_fifo_push_1(i8* %18, i8* %19)
  store i1 %.fca.0.4.0.0.0.extract, i1* %6
  %20 = bitcast i1* %6 to i8*
  %21 = bitcast i1* %_V_last_V to i8*
  call void @fpga_fifo_push_1(i8* %20, i8* %21)
  br label %empty, !llvm.loop !5

ret:                                              ; preds = %empty
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.61"(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias %dst, i32* noalias align 512 "unpacked"="1.0" %src_V_data_V, i4* noalias align 512 "unpacked"="1.1" %src_V_keep_V, i4* noalias align 512 "unpacked"="1.2" %src_V_strb_V, i7* noalias align 512 "unpacked"="1.3" %src_V_user_V, i1* noalias align 512 "unpacked"="1.4" %src_V_last_V) unnamed_addr #5 {
entry:
  %0 = icmp eq %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call fastcc void @"streamcpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.64"(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* nonnull %dst, i32* align 512 %src_V_data_V, i4* align 512 %src_V_keep_V, i4* align 512 %src_V_strb_V, i7* align 512 %src_V_user_V, i1* align 512 %src_V_last_V)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"streamcpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.64"(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias nocapture, i32* noalias nocapture align 512 "unpacked"="1.0" %_V_data_V, i4* noalias nocapture align 512 "unpacked"="1.1" %_V_keep_V, i4* noalias nocapture align 512 "unpacked"="1.2" %_V_strb_V, i7* noalias nocapture align 512 "unpacked"="1.3" %_V_user_V, i1* noalias nocapture align 512 "unpacked"="1.4" %_V_last_V) unnamed_addr #6 {
entry:
  %1 = alloca i32
  %2 = alloca i4
  %3 = alloca i4
  %4 = alloca i7
  %5 = alloca i1
  %6 = alloca %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"
  br label %empty

empty:                                            ; preds = %push, %entry
  %7 = bitcast i32* %_V_data_V to i8*
  %8 = call i1 @fpga_fifo_not_empty_4(i8* %7)
  br i1 %8, label %push, label %ret

push:                                             ; preds = %empty
  %9 = bitcast i32* %1 to i8*
  %10 = bitcast i32* %_V_data_V to i8*
  call void @fpga_fifo_pop_4(i8* %9, i8* %10)
  %11 = load volatile i32, i32* %1
  %12 = bitcast i4* %3 to i8*
  %13 = bitcast i4* %_V_keep_V to i8*
  call void @fpga_fifo_pop_1(i8* %12, i8* %13)
  %14 = bitcast i4* %3 to i8*
  %15 = load i8, i8* %14
  %16 = trunc i8 %15 to i4
  %17 = bitcast i4* %2 to i8*
  %18 = bitcast i4* %_V_strb_V to i8*
  call void @fpga_fifo_pop_1(i8* %17, i8* %18)
  %19 = bitcast i4* %2 to i8*
  %20 = load i8, i8* %19
  %21 = trunc i8 %20 to i4
  %22 = bitcast i7* %4 to i8*
  %23 = bitcast i7* %_V_user_V to i8*
  call void @fpga_fifo_pop_1(i8* %22, i8* %23)
  %24 = bitcast i7* %4 to i8*
  %25 = load i8, i8* %24
  %26 = trunc i8 %25 to i7
  %27 = bitcast i1* %5 to i8*
  %28 = bitcast i1* %_V_last_V to i8*
  call void @fpga_fifo_pop_1(i8* %27, i8* %28)
  %29 = bitcast i1* %5 to i8*
  %30 = load i8, i8* %29
  %31 = trunc i8 %30 to i1
  %.fca.0.0.0.0.0.insert = insertvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" undef, i32 %11, 0, 0, 0, 0, 0
  %.fca.0.1.0.0.0.insert = insertvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %.fca.0.0.0.0.0.insert, i4 %16, 0, 1, 0, 0, 0
  %.fca.0.2.0.0.0.insert = insertvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %.fca.0.1.0.0.0.insert, i4 %21, 0, 2, 0, 0, 0
  %.fca.0.3.0.0.0.insert = insertvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %.fca.0.2.0.0.0.insert, i7 %26, 0, 3, 0, 0, 0
  %.fca.0.4.0.0.0.insert = insertvalue %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %.fca.0.3.0.0.0.insert, i1 %31, 0, 4, 0, 0, 0
  store %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>" %.fca.0.4.0.0.0.insert, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %6
  %32 = bitcast %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %6 to i8*
  %33 = bitcast %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %0 to i8*
  call void @fpga_fifo_push_12(i8* %32, i8* %33)
  br label %empty, !llvm.loop !5

ret:                                              ; preds = %empty
  ret void
}

declare void @apatb_userdma_hw(i32*, i4*, i4*, i7*, i1*, i1*, %"struct.ap_int<32>"*, %"struct.ap_int<1>"*, [1024 x i32]*, i2*, [1024 x i32]*, i1*, i32, %"struct.ap_int<1>"*, i32*, i4*, i4*, i7*, i1*, i1)

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @copy_back(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias "unpacked"="0", i32* noalias align 512 "unpacked"="1.0" %_V_data_V, i4* noalias align 512 "unpacked"="1.1" %_V_keep_V, i4* noalias align 512 "unpacked"="1.2" %_V_strb_V, i7* noalias align 512 "unpacked"="1.3" %_V_user_V, i1* noalias align 512 "unpacked"="1.4" %_V_last_V, i1* noalias "unpacked"="2", i1* noalias readonly align 512 "unpacked"="3", [1024 x %"struct.ap_int<32>"]* noalias "unpacked"="4", [1024 x i32]* noalias readonly "unpacked"="5", %"struct.ap_uint<2>"* noalias "unpacked"="6", i2* noalias nocapture readonly align 512 "unpacked"="7.0", [1024 x %"struct.ap_int<32>"]* noalias "unpacked"="8", [1024 x i32]* noalias readonly "unpacked"="9", i1* noalias "unpacked"="10", i1* noalias readonly align 512 "unpacked"="11", %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* noalias "unpacked"="12", i32* noalias align 512 "unpacked"="13.0" %_V_data_V1, i4* noalias align 512 "unpacked"="13.1" %_V_keep_V2, i4* noalias align 512 "unpacked"="13.2" %_V_strb_V3, i7* noalias align 512 "unpacked"="13.3" %_V_user_V4, i1* noalias align 512 "unpacked"="13.4" %_V_last_V5) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.61"(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %0, i32* align 512 %_V_data_V, i4* align 512 %_V_keep_V, i4* align 512 %_V_strb_V, i7* align 512 %_V_user_V, i1* align 512 %_V_last_V)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %1, i1* align 512 %2)
  call fastcc void @"onebyonecpy_hls.p0a1024struct.ap_int<32>.40"([1024 x %"struct.ap_int<32>"]* %3, [1024 x i32]* %4)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<2>.16"(%"struct.ap_uint<2>"* %5, i2* align 512 %6)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %9, i1* align 512 %10)
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>.61"(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %11, i32* align 512 %_V_data_V1, i4* align 512 %_V_keep_V2, i4* align 512 %_V_strb_V3, i7* align 512 %_V_user_V4, i1* align 512 %_V_last_V5)
  ret void
}

define void @userdma_hw_stub_wrapper(i32*, i4*, i4*, i7*, i1*, i1*, %"struct.ap_int<32>"*, %"struct.ap_int<1>"*, [1024 x i32]*, i2*, [1024 x i32]*, i1*, i32, %"struct.ap_int<1>"*, i32*, i4*, i4*, i7*, i1*, i1) #7 {
entry:
  %20 = alloca %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"
  %malloccall = tail call i8* @malloc(i64 4096)
  %21 = bitcast i8* %malloccall to [1024 x %"struct.ap_int<32>"]*
  %22 = alloca %"struct.ap_uint<2>"
  %malloccall1 = tail call i8* @malloc(i64 4096)
  %23 = bitcast i8* %malloccall1 to [1024 x %"struct.ap_int<32>"]*
  %24 = alloca %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"
  call void @copy_out(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %20, i32* %0, i4* %1, i4* %2, i7* %3, i1* %4, i1* null, i1* %5, [1024 x %"struct.ap_int<32>"]* %21, [1024 x i32]* %8, %"struct.ap_uint<2>"* %22, i2* %9, [1024 x %"struct.ap_int<32>"]* %23, [1024 x i32]* %10, i1* null, i1* %11, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %24, i32* %14, i4* %15, i4* %16, i7* %17, i1* %18)
  %25 = bitcast [1024 x %"struct.ap_int<32>"]* %21 to %"struct.ap_int<32>"*
  %26 = bitcast [1024 x %"struct.ap_int<32>"]* %23 to %"struct.ap_int<32>"*
  call void @userdma_hw_stub(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %20, i1* %5, %"struct.ap_int<32>"* %6, %"struct.ap_int<1>"* %7, %"struct.ap_int<32>"* %25, %"struct.ap_uint<2>"* %22, %"struct.ap_int<32>"* %26, i1* %11, i32 %12, %"struct.ap_int<1>"* %13, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %24, i1 %19)
  call void @copy_in(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %20, i32* %0, i4* %1, i4* %2, i7* %3, i1* %4, i1* null, i1* %5, [1024 x %"struct.ap_int<32>"]* %21, [1024 x i32]* %8, %"struct.ap_uint<2>"* %22, i2* %9, [1024 x %"struct.ap_int<32>"]* %23, [1024 x i32]* %10, i1* null, i1* %11, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"* %24, i32* %14, i4* %15, i4* %16, i7* %17, i1* %18)
  ret void
}

declare void @userdma_hw_stub(%"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"*, i1*, %"struct.ap_int<32>"*, %"struct.ap_int<1>"*, %"struct.ap_int<32>"*, %"struct.ap_uint<2>"*, %"struct.ap_int<32>"*, i1*, i32, %"struct.ap_int<1>"*, %"class.hls::stream<hls::axis<ap_uint<32>, 7, 0, 0, '8', false>, 0>"*, i1)

declare i1 @fpga_fifo_not_empty_12(i8*)

declare i1 @fpga_fifo_not_empty_4(i8*)

declare void @fpga_fifo_pop_4(i8*, i8*)

declare void @fpga_fifo_pop_12(i8*, i8*)

declare void @fpga_fifo_pop_1(i8*, i8*)

declare void @fpga_fifo_push_4(i8*, i8*)

declare void @fpga_fifo_push_12(i8*, i8*)

declare void @fpga_fifo_push_1(i8*, i8*)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { argmemonly noinline willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #6 = { argmemonly noinline willreturn "fpga.wrapper.func"="streamcpy_hls" }
attributes #7 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.rotate.disable"}
