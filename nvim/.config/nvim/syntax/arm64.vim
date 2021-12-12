" vim: set et ft=vim sw=2 sts=2 ts=8 tw=80 :
" Script:   a64asm.vim
" Original Author:   Saleem Abdulrasool <compnerd@compnerd.org>
" Forked from: http://github.com/compnerd/arm64asm
" Requires: Vim 7
" License:  Redistribute under the same terms as Vim itself
" Purpose:  ARM64 Assembly Syntax Highlighting

if exists("b:current_syntax")
  finish
endif

" NOTE(compnerd) '.' is not in the default keyword, and will cause the
" directives to not be recognised by default.  Also add '!' to ensure that the
" increment operator is matched.
if version < 600
  set iskeyword=!,#,$,%,.,48-57,:,;,=,@,_
else
  setlocal iskeyword=!,#,$,.,48-57,:,;,=,@,_
endif

syntax case match

syntax keyword AArch64Special NOTE TODO XXX contained

syntax case ignore

syntax region AArch64Comment start="//" end="$" keepend contains=AArch64Special
syntax region AArch64Comment start="/\*" end="\*/" contains=AArch64Special
" MachO uses ; as a comment leader
syntax region AArch64Comment start=";" end="$" contains=todo

syntax keyword AArch64Directive .align .p2align
syntax keyword AArch64Directive .global .globl .type
syntax keyword AArch64Directive .hword .word .xword .long .quad
syntax keyword AArch64Directive .loh
syntax keyword AArch64Directive .tlsdesccall
syntax keyword AArch64Directive .ltorg .pool
syntax keyword AArch64Directive .req .unreq
syntax keyword AArch64Directive .inst
syntax keyword AArch64Directive .private_extern .extern
syntax keyword AArch64Directive .section .text .data
" NOTE(compnerd) .type is already listed above
syntax keyword AArch64Directive .def .endef .scl
syntax keyword AArch64Directive .macro .endmacro .endm
syntax keyword AArch64Directive .set
syntax keyword AArch64Directive .if .else .endif
syntax keyword AArch64Directive .fill

syntax match AArch64Modifier /:lo12:/ contained
syntax match AArch64Modifier /:abs_g3:/ contained
syntax match AArch64Modifier /:abs_g2:/ contained
syntax match AArch64Modifier /:abs_g2_s:/ contained
syntax match AArch64Modifier /:abs_g2_nc:/ contained
syntax match AArch64Modifier /:abs_g1:/ contained
syntax match AArch64Modifier /:abs_g1_s:/ contained
syntax match AArch64Modifier /:abs_g1_nc:/ contained
syntax match AArch64Modifier /:abs_g0:/ contained
syntax match AArch64Modifier /:abs_g0_s:/ contained
syntax match AArch64Modifier /:abs_g0_nc:/ contained
syntax match AArch64Modifier /:dtprel_g2:/ contained
syntax match AArch64Modifier /:dtprel_g1:/ contained
syntax match AArch64Modifier /:dtprel_g1_nc:/ contained
syntax match AArch64Modifier /:dtprel_g0:/ contained
syntax match AArch64Modifier /:dtprel_g0_nc:/ contained
syntax match AArch64Modifier /:dtprel_hi12:/ contained
syntax match AArch64Modifier /:dtprel_lo12:/ contained
syntax match AArch64Modifier /:dtprel_lo12_nc:/ contained
syntax match AArch64Modifier /:tprel_g2:/ contained
syntax match AArch64Modifier /:tprel_g1:/ contained
syntax match AArch64Modifier /:tprel_g1_nc:/ contained
syntax match AArch64Modifier /:tprel_g0:/ contained
syntax match AArch64Modifier /:tprel_g0_nc:/ contained
syntax match AArch64Modifier /:tprel_hi12:/ contained
syntax match AArch64Modifier /:tprel_lo12:/ contained
syntax match AArch64Modifier /:tprel_lo12_nc:/ contained
syntax match AArch64Modifier /:tlsdesc:/ contained
syntax match AArch64Modifier /:tlsdesc_lo12:/ contained
syntax match AArch64Modifier /:got:/ contained
syntax match AArch64Modifier /:got_lo12:/ contained
syntax match AArch64Modifier /:gottprel:/ contained
syntax match AArch64Modifier /:gottprel_lo12:/ contained
syntax match AArch64Modifier /:gottprel_g1:/ contained
syntax match AArch64Modifier /:gottprel_g0_nc:/ contained

syntax match AArch64Modifier /@PAGE/ contained
syntax match AArch64Modifier /@PAGEOFF/ contained

syntax match AArch64Identifier /[-_$.A-Za-z0-9]\+/
syntax match AArch64Identifier /:.*:[-_$.A-Za-z0-9]\+/ contains=AArch64Modifier
" MachO uses @modifiers
syntax match AArch64Identifier /[-_$.A-Za-z0-9]\+@[a-zA-Z]\+/ contains=AArch64Modifier
" MachO uses L for the PrivateGloablPrefix, ELF uses .L
syntax match AArch64Identifier /\.\?L[-_$.A-Za-z0-9]\+/ contains=AArch64Modifier
syntax match AArch64Identifier /:.*:\.\?L[-_$.A-Za-z0-9]\+/ contains=AArch64Modifier
" MachO uses @modifiers
syntax match AArch64Identifier /\.\?L[-_$.A-Za-z0-9]\+[a-zA-Z]\+/ contains=AArch64Modifier

syntax match AArch64Label /^[-_$.A-Za-z0-9]\+\s*:/
" MachO uses L for the PrivateGloablPrefix, ELF uses .L
syntax match AArch64Label /^\.\?L[-_$.A-Za-z0-9]\+\s*:/
syntax match AArch64Label /^"[-_$.A-Za-z0-9 ]\+\s*":/

syntax keyword AArch64Mnemonic ABS       ADC       ADCS      ADD       ADDG
syntax keyword AArch64Mnemonic ADDHN     ADDHN2    ADDP      ADDS      ADDV
syntax keyword AArch64Mnemonic ADR       ADRP      AESD      AESE      AESIMC
syntax keyword AArch64Mnemonic AESMC     AND       ANDS      ASR       ASRV
syntax keyword AArch64Mnemonic AT        AUTDA     AUTDB     AUTDZA    AUTDZB
syntax keyword AArch64Mnemonic AUTIA     AUTIA1716 AUTIASP   AUTIAZ    AUTIB
syntax keyword AArch64Mnemonic AUTIB1716 AUTIBSP   AUTIBZ    AUTIZA    AUTIZB
syntax keyword AArch64Mnemonic AXFlag    B         B.AL      B.CC      B.CS
syntax keyword AArch64Mnemonic B.EQ      B.GE      B.GT      B.HI      B.HS
syntax keyword AArch64Mnemonic B.LE      B.LO      B.LS      B.LT      B.MI
syntax keyword AArch64Mnemonic B.NE      B.NV      B.PL      B.VC      B.VS
syntax keyword AArch64Mnemonic BAL       BCAX      BCC       BCS       BEQ
syntax keyword AArch64Mnemonic BFC       BFI       BFM       BFXIL     BGE
syntax keyword AArch64Mnemonic BGT       BHI       BHS       BIC       BICS
syntax keyword AArch64Mnemonic BIF       BIT       BL        BLE       BLO
syntax keyword AArch64Mnemonic BLR       BLRAA     BLRAAZ    BLRAB     BLRABZ
syntax keyword AArch64Mnemonic BLS       BLT       BMI       BNE       BNV
syntax keyword AArch64Mnemonic BPL       BR        BRAA      BRAAZ     BRAB
syntax keyword AArch64Mnemonic BRABZ     BRK       BSL       BTI       BVC
syntax keyword AArch64Mnemonic BVS       CAS       CASA      CASAB     CASAH
syntax keyword AArch64Mnemonic CASAL     CASALB    CASALH    CASB      CASH
syntax keyword AArch64Mnemonic CASL      CASLB     CASLH     CASP      CASPA
syntax keyword AArch64Mnemonic CASPAL    CASPL     CBNZ      CBZ       CCMN
syntax keyword AArch64Mnemonic CCMP      CFINV     CFP       CINC      CINV
syntax keyword AArch64Mnemonic CLREX     CLS       CLZ       CMEQ      CMGE
syntax keyword AArch64Mnemonic CMGT      CMHI      CMHS      CMLE      CMLT
syntax keyword AArch64Mnemonic CMN       CMP       CMPP      CMTST     CNEG
syntax keyword AArch64Mnemonic CNT       CPP       CRC32B    CRC32CB   CRC32CH
syntax keyword AArch64Mnemonic CRC32CW   CRC32CX   CRC32H    CRC32W    CRC32X
syntax keyword AArch64Mnemonic CSDB      CSEL      CSET      CSETM     CSINC
syntax keyword AArch64Mnemonic CSINV     CSNEG     DC        DCP3      DCPS1
syntax keyword AArch64Mnemonic DCPS2     DCPS3     DMB       DRPS      DSB
syntax keyword AArch64Mnemonic DUP       DVP       EON       EOR       EOR3
syntax keyword AArch64Mnemonic ERET      ERETAA    ERETAB    ESB       EXT
syntax keyword AArch64Mnemonic EXTR      FABD      FABS      FACGE     FACGT
syntax keyword AArch64Mnemonic FADD      FADDP     FCADD     FCCMP     FCCMPE
syntax keyword AArch64Mnemonic FCMEQ     FCMGE     FCMGT     FCMLA     FCMLE
syntax keyword AArch64Mnemonic FCMLT     FCMP      FCMPE     FCSEL     FCVT
syntax keyword AArch64Mnemonic FCVTAS    FCVTAU    FCVTL     FCVTL2    FCVTMS
syntax keyword AArch64Mnemonic FCVTMU    FCVTNS    FCVTNU    FCVTPS    FCVTPU
syntax keyword AArch64Mnemonic FCVTXN    FCVTXN2   FCVTZS    FCVTZU    FDIV
syntax keyword AArch64Mnemonic FMADD     FMAX      FMAXMP    FMAXNM    FMAXNMV
syntax keyword AArch64Mnemonic FMAXP     FMAXV     FMIN      FMINNM    FMINNMP
syntax keyword AArch64Mnemonic FMINNMV   FMINP     FMINV     FMLA      FMLAL
syntax keyword AArch64Mnemonic FMLAL2    FMLS      FMLSL     FMLSL2    FMOV
syntax keyword AArch64Mnemonic FMSUB     FMUL      FMULX     FNEG      FNMADD
syntax keyword AArch64Mnemonic FNMSUB    FNMUL     FRECPE    FRECPS    FRECPX
syntax keyword AArch64Mnemonic FRINT32X  FRINT32Z  FRINT64X  FRINT64Z  FRINTA
syntax keyword AArch64Mnemonic FRINTI    FRINTM    FRINTN    FRINTP    FRINTX
syntax keyword AArch64Mnemonic FRINTZ    FRSQRTE   FRSQRTS   FSQRT     FSUB
syntax keyword AArch64Mnemonic GMI       HINT      HLT       HVC       IC
syntax keyword AArch64Mnemonic INS       IRG       ISB       LD1       LD1R
syntax keyword AArch64Mnemonic LD2       LD2R      LD3       LD3R      LD4
syntax keyword AArch64Mnemonic LD4R      LDADD     LDADDA    LDADDAB   LDADDAH
syntax keyword AArch64Mnemonic LDADDAL   LDADDALB  LDADDALH  LDADDB    LDADDH
syntax keyword AArch64Mnemonic LDADDL    LDADDLB   LDADDLH   LDAPR     LDAPRB
syntax keyword AArch64Mnemonic LDAPRH    LDAPUR    LDAPURB   LDAPURH   LDAPURSB
syntax keyword AArch64Mnemonic LDAR      LDARB     LDARH     LDAXP     LDAXR
syntax keyword AArch64Mnemonic LDAXRB    LDAXRH    LDNP      LDP       LDPSW
syntax keyword AArch64Mnemonic LDR       LDRB      LDRH      LDRSH     LDRSW
syntax keyword AArch64Mnemonic LDSET     LDSETA    LDSETAB   LDSETAH   LDSETAL
syntax keyword AArch64Mnemonic LDSETALB  LDSETALH  LDSETB    LDSETH    LDSETL
syntax keyword AArch64Mnemonic LDSETLB   LDSETLH   LDSMAX    LDSMAXA   LDSMAXAB
syntax keyword AArch64Mnemonic LDSMAXAH  LDSMAXAL  LDSMAXALB LDSMAXALH LDSMAXB
syntax keyword AArch64Mnemonic LDSMAXH   LDSMAXL   LDSMAXLB  LDSMAXLH  LDSMIN
syntax keyword AArch64Mnemonic LDSMINA   LDSMINAB  LDSMINAH  LDSMINAL  LDSMINALB
syntax keyword AArch64Mnemonic LDSMINALH LDSMINB   LDSMINH   LDSMINL   LDSMINLB
syntax keyword AArch64Mnemonic LDSMINLH  LDTR      LDTRB     LDTRH     LDTRSB
syntax keyword AArch64Mnemonic LDTRSH    LDTRSW    LDUMAX    LDUMAXA   LDUMAXAB
syntax keyword AArch64Mnemonic LDUMAXAH  LDUMAXAL  LDUMAXALB LDUMAXALH LDUMAXB
syntax keyword AArch64Mnemonic LDUMAXH   LDUMAXL   LDUMAXLB  LDUMAXLH  LDUMIN
syntax keyword AArch64Mnemonic LDUMINA   LDUMINAB  LDUMINAH  LDUMINAL  LDUMINALB
syntax keyword AArch64Mnemonic LDUMINALH LDUMINB   LDUMINH   LDUMINL   LDUMINLB
syntax keyword AArch64Mnemonic LDUMINLH  LDUR      LDURB     LDURH     LDURSB
syntax keyword AArch64Mnemonic LDURSH    LDURSW    LDXP      LDXR      LDXRB
syntax keyword AArch64Mnemonic LDXRH     LSL       LSLV      LSR       LSRV
syntax keyword AArch64Mnemonic MADD      MLA       MLS       MNEG      MOV
syntax keyword AArch64Mnemonic MOVI      MOVK      MOVN      MOVZ      MRS
syntax keyword AArch64Mnemonic MSR       MSUB      MUL       MVN       MVNI
syntax keyword AArch64Mnemonic NEG       NEGS      NGC       NGCS      NOP
syntax keyword AArch64Mnemonic NOT       ORN       ORR       PACDA     PACDB
syntax keyword AArch64Mnemonic PACDZA    PACDZB    PACGA     PACIA     PACIA1716
syntax keyword AArch64Mnemonic PACIASP   PACIAZ    PACIB     PACIB1716 PACIBSP
syntax keyword AArch64Mnemonic PACIBZ    PACIZA    PACIZB    PMUL      PMULL
syntax keyword AArch64Mnemonic PMULL2    PRFM      PRFUM     PSB CSYNC PSSBB
syntax keyword AArch64Mnemonic RADDHN    RADDHN2   RAX1      RBIT      RET
syntax keyword AArch64Mnemonic RETAA     RETAB     REV       REV16     REV32
syntax keyword AArch64Mnemonic REV64     RMIF      ROR       RORV      RSHRN
syntax keyword AArch64Mnemonic RSHRN2    RSUBHN    RSUBHN2   SABA      SABAL
syntax keyword AArch64Mnemonic SABAL2    SABD      SABDL     SABDL2    SADALP
syntax keyword AArch64Mnemonic SADDL     SADDL2    SADDLP    SADDLV    SADDW
syntax keyword AArch64Mnemonic SADDW2    SB        SBC       SBCS      SBFIZ
syntax keyword AArch64Mnemonic SBFM      SBFX      SCVTF     SDIV      SDOT
syntax keyword AArch64Mnemonic SETF16    SETF8     SEV       SEVL      SHA1C
syntax keyword AArch64Mnemonic SHA1H     SHA1M     SHA1P     SHA1SU0   SHA1SU1
syntax keyword AArch64Mnemonic SHA256H   SHA256H2  SHA256SU0 SHA256SU1 SHA512H
syntax keyword AArch64Mnemonic SHA512H2  SHA512SU0 SHA512SU1 SHADD     SHL
syntax keyword AArch64Mnemonic SHLL      SHLL2     SHRADD    SHRN      SHRN2
syntax keyword AArch64Mnemonic SHSUB     SLI       SM3PARTW1 SM3PARTW2 SM3SS1
syntax keyword AArch64Mnemonic SM3TT1A   SM3TT1B   SM3TT2A   SM3TT2B   SM4E
syntax keyword AArch64Mnemonic SM4EKEY   SMADDL    SMAX      SMAXP     SMAXV
syntax keyword AArch64Mnemonic SMC       SMIN      SMINP     SMINV     SMLAL
syntax keyword AArch64Mnemonic SMLAL2    SMLSL     SMLSL2    SMNEGL    SMOV
syntax keyword AArch64Mnemonic SMSUBL    SMULH     SMULL     SMULL2    SQABS
syntax keyword AArch64Mnemonic SQADD     SQDMLAL   SQDMLAL2  SQDMLSL   SQDMLSL2
syntax keyword AArch64Mnemonic SQDMULH   SQDMULL   SQDMULL2  SQNEG     SQRDMLAH
syntax keyword AArch64Mnemonic SQRDMLSH  SQRDMULH  SQRSHL    SQRSHRN   SQRSHRN2
syntax keyword AArch64Mnemonic SQRSHRUN  SQRSHRUN2 SQSHL     SQSHLU    SQSHRN
syntax keyword AArch64Mnemonic SQSHRN2   SQSHRUN   SQSHRUN2  SQSUB     SQXTN
syntax keyword AArch64Mnemonic SQXTN2    SQXTUN    SQXTUN2   SRHADD    SRI
syntax keyword AArch64Mnemonic SRSHL     SRSHR     SRSRA     SSBB      SSHHR
syntax keyword AArch64Mnemonic SSHL      SSHLL     SSHLL2    SSHR      SSRA
syntax keyword AArch64Mnemonic SSUBL     SSUBL2    SSUBW     SSUBW2    ST1
syntax keyword AArch64Mnemonic ST2       ST2G      ST3       ST4       STADD
syntax keyword AArch64Mnemonic STADDB    STADDH    STADDL    STADDLB   STADDLH
syntax keyword AArch64Mnemonic STCLR     STCLRB    STCLRH    STCLRL    STCLRLB
syntax keyword AArch64Mnemonic STCLRLH   STEOR     STEORB    STEORH    STEORL
syntax keyword AArch64Mnemonic STEORLB   STEORLH   STG       STGP      STGV
syntax keyword AArch64Mnemonic STLLR     STLLRB    STLLRH    STLR      STLRB
syntax keyword AArch64Mnemonic STLRH     STLUR     STLURB    STLURH    STLXP
syntax keyword AArch64Mnemonic STLXR     STLXRB    STLXRH    STNP      STP
syntax keyword AArch64Mnemonic STR       STRB      STRH      STSET     STSETB
syntax keyword AArch64Mnemonic STSETH    STSETL    STSETLB   STSETLH   STSMAX
syntax keyword AArch64Mnemonic STSMAXB   STSMAXH   STSMAXL   STSMAXLB  STSMAXLH
syntax keyword AArch64Mnemonic STSMIN    STSMINB   STSMINH   STSMINL   STSMINLB
syntax keyword AArch64Mnemonic STSMINLH  STTR      STTRB     STTRH     STTTR
syntax keyword AArch64Mnemonic STUMAX    STUMAXB   STUMAXH   STUMAXL   STUMAXLB
syntax keyword AArch64Mnemonic STUMAXLH  STUMIN    STUMINB   STUMINH   STUMINL
syntax keyword AArch64Mnemonic STUMINLB  STUMINLH  STUR      STURB     STURH
syntax keyword AArch64Mnemonic STXP      STXR      STXRB     STXRH     STZ2G
syntax keyword AArch64Mnemonic STZG      SUB       SUBG      SUBHN     SUBHN2
syntax keyword AArch64Mnemonic SUBP      SUBPS     SUBS      SUQADD    SVC
syntax keyword AArch64Mnemonic SWP       SWPA      SWPAB     SWPAH     SWPAL
syntax keyword AArch64Mnemonic SWPALB    SWPALH    SWPB      SWPH      SWPL
syntax keyword AArch64Mnemonic SWPLB     SWPLH     SXTB      SXTH      SXTL
syntax keyword AArch64Mnemonic SXTL2     SXTW      SYS       SYSL      TBL
syntax keyword AArch64Mnemonic TBNZ      TBX       TBZ       TLBI      TRN1
syntax keyword AArch64Mnemonic TRN2      TSB CSYNC TST       UABA      UABAL
syntax keyword AArch64Mnemonic UABAL2    UABD      UABDL     UABDL2    UADALP
syntax keyword AArch64Mnemonic UADDL     UADDL2    UADDLP    UADDLV    UADDW
syntax keyword AArch64Mnemonic UADDW2    UBFIZ     UBFM      UBFX      UCVTF
syntax keyword AArch64Mnemonic UDF       UDIV      UDOT      UHADD     UHSUB
syntax keyword AArch64Mnemonic UMADDL    UMAX      UMAXP     UMAXV     UMIN
syntax keyword AArch64Mnemonic UMINP     UMINV     UMLAL     UMLAL2    UMLSL
syntax keyword AArch64Mnemonic UMLSL2    UMNEGL    UMOV      UMSUBL    UMULH
syntax keyword AArch64Mnemonic UMULL     UMULL2    UQADD     UQRSHL    UQRSHRN
syntax keyword AArch64Mnemonic UQRSHRN2  UQSHL     UQSHRN    UQSHRN2   UQSUB
syntax keyword AArch64Mnemonic UQXTN     UQXTN2    URECPE    URHADD    URSHL
syntax keyword AArch64Mnemonic URSHR     URSQRTE   URSRA     USHL      USHLL
syntax keyword AArch64Mnemonic USHLL2    USHR      USQADD    USRA      USUBL
syntax keyword AArch64Mnemonic USUBL2    USUBW     USUBW2    UXTB      UXTH
syntax keyword AArch64Mnemonic UXTL      UXTL2     UZP1      UZP2      WFE
syntax keyword AArch64Mnemonic WFI       XAFlag    XAR       XPACD     XPACI
syntax keyword AArch64Mnemonic XPACLRI   XTN       XTN2      XTNP      YIELD
syntax keyword AArch64Mnemonic ZIP1      ZIP2

syntax match AArch64Macro  /#[_a-zA-Z][_a-zA-Z0-9]*/
syntax match AArch64Number /#-\?\d\+/
syntax match AArch64Number /#([^)]\+)/
" TODO(compnerd) add floating point and hexadecimal numeric literal

" NOTE(compnerd) this must be matched after numerics
syntax match AArch64Label /\d\{1,2\}[:fb]/

syntax keyword AArch64Operator ! ==

syntax keyword AArch64Register w0  w1  w2  w3  w4  w5  w6  w7  w8  w9
syntax keyword AArch64Register w11 w12 w13 w14 w15 w16 w17 w18 w19 w20
syntax keyword AArch64Register w22 w23 w24 w25 w26 w27 w28 w29 w30 w31

syntax keyword AArch64Register x0  x1  x2  x3  x4  x5  x6  x7  x8  x9
syntax keyword AArch64Register x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
syntax keyword AArch64Register x22 x23 x24 x25 x26 x27 x28 x29 x30 x31

syntax keyword AArch64Register v0  v1  v2  v3  v4  v5  v6  v7  v8  v9
syntax keyword AArch64Register v11 v12 v13 v14 v15 v16 v17 v18 v19 v20
syntax keyword AArch64Register v22 v23 v24 v25 v26 v27 v28 v29 v30 v31

syntax keyword AArch64Register q0  q1  q2  q3  q4  q5  q6  q7  q8  q9
syntax keyword AArch64Register q11 q12 q13 q14 q15 q16 q17 q18 q19 q20
syntax keyword AArch64Register q22 q23 q24 q25 q26 q27 q28 q29 q30 q31

syntax keyword AArch64Register d0  d1  d2  d3  d4  d5  d6  d7  d8  d9
syntax keyword AArch64Register d11 d12 d13 d14 d15 d16 d17 d18 d19 d20
syntax keyword AArch64Register d22 d23 d24 d25 d26 d27 d28 d29 d30 d31

syntax keyword AArch64Register s0  s1  s2  s3  s4  s5  s6  s7  s8  s9
syntax keyword AArch64Register s11 s12 s13 s14 s15 s16 s17 s18 s19 s20
syntax keyword AArch64Register s22 s23 s24 s25 s26 s27 s28 s29 s30 s31

syntax keyword AArch64Register h0  h1  h2  h3  h4  h5  h6  h7  h8  h9
syntax keyword AArch64Register h11 h12 h13 h14 h15 h16 h17 h18 h19 h20
syntax keyword AArch64Register h22 h23 h24 h25 h26 h27 h28 h29 h30 h31

syntax keyword AArch64Register b0  b1  b2  b3  b4  b5  b6  b7  b8  b9
syntax keyword AArch64Register b11 b12 b13 b14 b15 b16 b17 b18 b19 b20
syntax keyword AArch64Register b22 b23 b24 b25 b26 b27 b28 b29 b30 b31

syntax keyword AArch64Register wzr xzr

syntax keyword AArch64Register sp pc pstate

syntax match AArch64Type /[@%]function/
syntax match AArch64Type /[@%]object/
syntax match AArch64Type /[@%]tls_object/
syntax match AArch64Type /[@%]common/
syntax match AArch64Type /[@%]notype/
syntax match AArch64Type /[@%]gnu_unique_object/

highlight default link AArch64Comment    Comment
highlight default link AArch64Directive  PreProc
highlight default link AArch64Identifier Identifier
highlight default link AArch64Label      Label
highlight default link AArch64Macro      Macro
highlight default link AArch64Mnemonic   Keyword
highlight default link AArch64Modifier   Special
highlight default link AArch64Number     Number
highlight default link AArch64Operator   Operator
highlight default link AArch64Register   StorageClass
highlight default link AArch64Type       Tag
highlight default link AArch64TODO       Todo

let b:current_syntax = "a64asm"
