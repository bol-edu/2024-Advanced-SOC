
--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
PACKAGE mgc_io_sync_pkg_v2 IS

COMPONENT mgc_io_sync_v2
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END COMPONENT;

END mgc_io_sync_pkg_v2;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY mgc_io_sync_v2 IS
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END mgc_io_sync_v2;

ARCHITECTURE beh OF mgc_io_sync_v2 IS
BEGIN

  lz <= ld;

END beh;


--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/hls_pkgs/src/funcs.vhd 

-- a package of attributes that give verification tools a hint about
-- the function being implemented
PACKAGE attributes IS
  ATTRIBUTE CALYPTO_FUNC : string;
  ATTRIBUTE CALYPTO_DATA_ORDER : string;
end attributes;

-----------------------------------------------------------------------
-- Package that declares synthesizable functions needed for RTL output
-----------------------------------------------------------------------

LIBRARY ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

PACKAGE funcs IS

-----------------------------------------------------------------
-- utility functions
-----------------------------------------------------------------

   FUNCTION TO_STDLOGIC(arg1: BOOLEAN) RETURN STD_LOGIC;
--   FUNCTION TO_STDLOGIC(arg1: STD_ULOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: STD_LOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: SIGNED(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGICVECTOR(arg1: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

   FUNCTION maximum(arg1, arg2 : INTEGER) RETURN INTEGER;
   FUNCTION minimum(arg1, arg2 : INTEGER) RETURN INTEGER;
   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER;
   FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2 : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
   
-----------------------------------------------------------------
-- logic functions
-----------------------------------------------------------------

   FUNCTION and_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION or_s (inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION xor_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;

   FUNCTION and_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;
   FUNCTION or_v (inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;
   FUNCTION xor_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- mux functions
-----------------------------------------------------------------

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC       ) RETURN STD_LOGIC;
   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC       ) RETURN STD_LOGIC_VECTOR;
   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- latch functions
-----------------------------------------------------------------
   FUNCTION lat_s(dinput: STD_LOGIC       ; clk: STD_LOGIC; doutput: STD_LOGIC       ) RETURN STD_LOGIC;
   FUNCTION lat_v(dinput: STD_LOGIC_VECTOR; clk: STD_LOGIC; doutput: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- tristate functions
-----------------------------------------------------------------
--   FUNCTION tri_s(dinput: STD_LOGIC       ; control: STD_LOGIC) RETURN STD_LOGIC;
--   FUNCTION tri_v(dinput: STD_LOGIC_VECTOR; control: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- compare functions returning STD_LOGIC
-- in contrast to the functions returning boolean
-----------------------------------------------------------------

   FUNCTION "=" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "=" (l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "/="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "/="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "<="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "<="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "<" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "<" (l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION ">="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION ">="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION ">" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION ">" (l, r: SIGNED  ) RETURN STD_LOGIC;

   -- RETURN 2 bits (left => lt, right => eq)
   FUNCTION cmp (l, r: STD_LOGIC_VECTOR) RETURN STD_LOGIC;

-----------------------------------------------------------------
-- Vectorized Overloaded Arithmetic Operators
-----------------------------------------------------------------

   FUNCTION faccu(arg: UNSIGNED; width: NATURAL) RETURN UNSIGNED;
 
   FUNCTION fabs(arg1: SIGNED  ) RETURN UNSIGNED;

   FUNCTION "/"  (l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "MOD"(l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "REM"(l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "**" (l, r: UNSIGNED) RETURN UNSIGNED;

   FUNCTION "/"  (l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "MOD"(l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "REM"(l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "**" (l, r: SIGNED  ) RETURN SIGNED  ;

-----------------------------------------------------------------
--               S H I F T   F U C T I O N S
-- negative shift shifts the opposite direction
-- *_stdar functions use shift functions from std_logic_arith
-----------------------------------------------------------------

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION fshl(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshl(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION frot(arg1: STD_LOGIC_VECTOR; arg2: STD_LOGIC_VECTOR; signd2: BOOLEAN; sdir: INTEGER range -1 TO 1) RETURN STD_LOGIC_VECTOR;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR;

   -----------------------------------------------------------------
   -- *_stdar functions use shift functions from std_logic_arith
   -----------------------------------------------------------------
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;

-----------------------------------------------------------------
-- indexing functions: LSB always has index 0
-----------------------------------------------------------------

   FUNCTION readindex(vec: STD_LOGIC_VECTOR; index: INTEGER                 ) RETURN STD_LOGIC;
   FUNCTION readslice(vec: STD_LOGIC_VECTOR; index: INTEGER; width: POSITIVE) RETURN STD_LOGIC_VECTOR;

   FUNCTION writeindex(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC       ; index: INTEGER) RETURN STD_LOGIC_VECTOR;
   FUNCTION n_bits(p: NATURAL) RETURN POSITIVE;
   --FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; index: INTEGER) RETURN STD_LOGIC_VECTOR;
   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; enable: STD_LOGIC_VECTOR; byte_width: INTEGER;  index: INTEGER) RETURN STD_LOGIC_VECTOR ;

   FUNCTION ceil_log2(size : NATURAL) return NATURAL;
   FUNCTION bits(size : NATURAL) return NATURAL;    

   PROCEDURE csa(a, b, c: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR);
   PROCEDURE csha(a, b: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR);
   
END funcs;


--------------------------- B O D Y ----------------------------


PACKAGE BODY funcs IS

-----------------------------------------------------------------
-- utility functions
-----------------------------------------------------------------

   FUNCTION TO_STDLOGIC(arg1: BOOLEAN) RETURN STD_LOGIC IS
     BEGIN IF arg1 THEN RETURN '1'; ELSE RETURN '0'; END IF; END;
--   FUNCTION TO_STDLOGIC(arg1: STD_ULOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC IS
--     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: STD_LOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: SIGNED(0 DOWNTO 0)) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;

   FUNCTION TO_STDLOGICVECTOR(arg1: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
     VARIABLE result: STD_LOGIC_VECTOR(0 DOWNTO 0);
   BEGIN
     result := (0 => arg1);
     RETURN result;
   END;

   FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 > arg2) THEN
       RETURN(arg1) ;
     ELSE
       RETURN(arg2) ;
     END IF;
   END;

   FUNCTION minimum (arg1,arg2: INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 < arg2) THEN
       RETURN(arg1) ;
     ELSE
       RETURN(arg2) ;
     END IF;
   END;

   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 = arg2) THEN
       RETURN(seleq) ;
     ELSE
       RETURN(selne) ;
     END IF;
   END;

   FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len: INTEGER := input1'LENGTH;
     ALIAS input1a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input1;
     ALIAS input2a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input2;
     VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     --synopsys translate_off
     FOR i IN len-1 DOWNTO 0 LOOP
       result(i) := resolved(input1a(i) & input2a(i));
     END LOOP;
     --synopsys translate_on
     RETURN result;
   END;

   FUNCTION resolve_unsigned(input1: UNSIGNED; input2: UNSIGNED) RETURN UNSIGNED IS
   BEGIN RETURN UNSIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1), STD_LOGIC_VECTOR(input2))); END;

   FUNCTION resolve_signed(input1: SIGNED; input2: SIGNED) RETURN SIGNED IS
   BEGIN RETURN SIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1), STD_LOGIC_VECTOR(input2))); END;

-----------------------------------------------------------------
-- Logic Functions
-----------------------------------------------------------------

   FUNCTION "not"(arg1: UNSIGNED) RETURN UNSIGNED IS
     BEGIN RETURN UNSIGNED(not STD_LOGIC_VECTOR(arg1)); END;
   FUNCTION and_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(and_v(inputs, 1)); END;
   FUNCTION or_s (inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(or_v(inputs, 1)); END;
   FUNCTION xor_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(xor_v(inputs, 1)); END;

   FUNCTION and_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     FOR i IN icnt2-1 DOWNTO 1 LOOP
       inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
       result := result AND inputsx(olenM1 DOWNTO 0);
     END LOOP;
     RETURN result;
   END;

   FUNCTION or_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     -- this if is added as a quick fix for a bug in catapult evaluating the loop even if inputs'LENGTH==1
     -- see dts0100971279
     IF icnt2 > 1 THEN
       FOR i IN icnt2-1 DOWNTO 1 LOOP
         inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
         result := result OR inputsx(olenM1 DOWNTO 0);
       END LOOP;
     END IF;
     RETURN result;
   END;

   FUNCTION xor_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     FOR i IN icnt2-1 DOWNTO 1 LOOP
       inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
       result := result XOR inputsx(olenM1 DOWNTO 0);
     END LOOP;
     RETURN result;
   END;

-----------------------------------------------------------------
-- Muxes
-----------------------------------------------------------------
   
   FUNCTION mux_sel2_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(1 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 4;
     ALIAS    inputs0: STD_LOGIC_VECTOR( inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector( size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "00" =>
       result := inputs0(1*size-1 DOWNTO 0*size);
     WHEN "01" =>
       result := inputs0(2*size-1 DOWNTO 1*size);
     WHEN "10" =>
       result := inputs0(3*size-1 DOWNTO 2*size);
     WHEN "11" =>
       result := inputs0(4*size-1 DOWNTO 3*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel3_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(2 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 8;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "000" =>
       result := inputs0(1*size-1 DOWNTO 0*size);
     WHEN "001" =>
       result := inputs0(2*size-1 DOWNTO 1*size);
     WHEN "010" =>
       result := inputs0(3*size-1 DOWNTO 2*size);
     WHEN "011" =>
       result := inputs0(4*size-1 DOWNTO 3*size);
     WHEN "100" =>
       result := inputs0(5*size-1 DOWNTO 4*size);
     WHEN "101" =>
       result := inputs0(6*size-1 DOWNTO 5*size);
     WHEN "110" =>
       result := inputs0(7*size-1 DOWNTO 6*size);
     WHEN "111" =>
       result := inputs0(8*size-1 DOWNTO 7*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel4_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(3 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 16;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "0000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "0001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "0010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "0011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "0100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "0101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "0110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "0111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "1000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "1001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "1010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "1011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "1100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "1101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "1110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "1111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel5_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(4 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 32;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0 );
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "00000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "00001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "00010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "00011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "00100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "00101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "00110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "00111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "01000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "01001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "01010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "01011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "01100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "01101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "01110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "01111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN "10000" =>
       result := inputs0( 17*size-1 DOWNTO 16*size);
     WHEN "10001" =>
       result := inputs0( 18*size-1 DOWNTO 17*size);
     WHEN "10010" =>
       result := inputs0( 19*size-1 DOWNTO 18*size);
     WHEN "10011" =>
       result := inputs0( 20*size-1 DOWNTO 19*size);
     WHEN "10100" =>
       result := inputs0( 21*size-1 DOWNTO 20*size);
     WHEN "10101" =>
       result := inputs0( 22*size-1 DOWNTO 21*size);
     WHEN "10110" =>
       result := inputs0( 23*size-1 DOWNTO 22*size);
     WHEN "10111" =>
       result := inputs0( 24*size-1 DOWNTO 23*size);
     WHEN "11000" =>
       result := inputs0( 25*size-1 DOWNTO 24*size);
     WHEN "11001" =>
       result := inputs0( 26*size-1 DOWNTO 25*size);
     WHEN "11010" =>
       result := inputs0( 27*size-1 DOWNTO 26*size);
     WHEN "11011" =>
       result := inputs0( 28*size-1 DOWNTO 27*size);
     WHEN "11100" =>
       result := inputs0( 29*size-1 DOWNTO 28*size);
     WHEN "11101" =>
       result := inputs0( 30*size-1 DOWNTO 29*size);
     WHEN "11110" =>
       result := inputs0( 31*size-1 DOWNTO 30*size);
     WHEN "11111" =>
       result := inputs0( 32*size-1 DOWNTO 31*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel6_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(5 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 64;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "000000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "000001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "000010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "000011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "000100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "000101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "000110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "000111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "001000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "001001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "001010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "001011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "001100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "001101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "001110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "001111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN "010000" =>
       result := inputs0( 17*size-1 DOWNTO 16*size);
     WHEN "010001" =>
       result := inputs0( 18*size-1 DOWNTO 17*size);
     WHEN "010010" =>
       result := inputs0( 19*size-1 DOWNTO 18*size);
     WHEN "010011" =>
       result := inputs0( 20*size-1 DOWNTO 19*size);
     WHEN "010100" =>
       result := inputs0( 21*size-1 DOWNTO 20*size);
     WHEN "010101" =>
       result := inputs0( 22*size-1 DOWNTO 21*size);
     WHEN "010110" =>
       result := inputs0( 23*size-1 DOWNTO 22*size);
     WHEN "010111" =>
       result := inputs0( 24*size-1 DOWNTO 23*size);
     WHEN "011000" =>
       result := inputs0( 25*size-1 DOWNTO 24*size);
     WHEN "011001" =>
       result := inputs0( 26*size-1 DOWNTO 25*size);
     WHEN "011010" =>
       result := inputs0( 27*size-1 DOWNTO 26*size);
     WHEN "011011" =>
       result := inputs0( 28*size-1 DOWNTO 27*size);
     WHEN "011100" =>
       result := inputs0( 29*size-1 DOWNTO 28*size);
     WHEN "011101" =>
       result := inputs0( 30*size-1 DOWNTO 29*size);
     WHEN "011110" =>
       result := inputs0( 31*size-1 DOWNTO 30*size);
     WHEN "011111" =>
       result := inputs0( 32*size-1 DOWNTO 31*size);
     WHEN "100000" =>
       result := inputs0( 33*size-1 DOWNTO 32*size);
     WHEN "100001" =>
       result := inputs0( 34*size-1 DOWNTO 33*size);
     WHEN "100010" =>
       result := inputs0( 35*size-1 DOWNTO 34*size);
     WHEN "100011" =>
       result := inputs0( 36*size-1 DOWNTO 35*size);
     WHEN "100100" =>
       result := inputs0( 37*size-1 DOWNTO 36*size);
     WHEN "100101" =>
       result := inputs0( 38*size-1 DOWNTO 37*size);
     WHEN "100110" =>
       result := inputs0( 39*size-1 DOWNTO 38*size);
     WHEN "100111" =>
       result := inputs0( 40*size-1 DOWNTO 39*size);
     WHEN "101000" =>
       result := inputs0( 41*size-1 DOWNTO 40*size);
     WHEN "101001" =>
       result := inputs0( 42*size-1 DOWNTO 41*size);
     WHEN "101010" =>
       result := inputs0( 43*size-1 DOWNTO 42*size);
     WHEN "101011" =>
       result := inputs0( 44*size-1 DOWNTO 43*size);
     WHEN "101100" =>
       result := inputs0( 45*size-1 DOWNTO 44*size);
     WHEN "101101" =>
       result := inputs0( 46*size-1 DOWNTO 45*size);
     WHEN "101110" =>
       result := inputs0( 47*size-1 DOWNTO 46*size);
     WHEN "101111" =>
       result := inputs0( 48*size-1 DOWNTO 47*size);
     WHEN "110000" =>
       result := inputs0( 49*size-1 DOWNTO 48*size);
     WHEN "110001" =>
       result := inputs0( 50*size-1 DOWNTO 49*size);
     WHEN "110010" =>
       result := inputs0( 51*size-1 DOWNTO 50*size);
     WHEN "110011" =>
       result := inputs0( 52*size-1 DOWNTO 51*size);
     WHEN "110100" =>
       result := inputs0( 53*size-1 DOWNTO 52*size);
     WHEN "110101" =>
       result := inputs0( 54*size-1 DOWNTO 53*size);
     WHEN "110110" =>
       result := inputs0( 55*size-1 DOWNTO 54*size);
     WHEN "110111" =>
       result := inputs0( 56*size-1 DOWNTO 55*size);
     WHEN "111000" =>
       result := inputs0( 57*size-1 DOWNTO 56*size);
     WHEN "111001" =>
       result := inputs0( 58*size-1 DOWNTO 57*size);
     WHEN "111010" =>
       result := inputs0( 59*size-1 DOWNTO 58*size);
     WHEN "111011" =>
       result := inputs0( 60*size-1 DOWNTO 59*size);
     WHEN "111100" =>
       result := inputs0( 61*size-1 DOWNTO 60*size);
     WHEN "111101" =>
       result := inputs0( 62*size-1 DOWNTO 61*size);
     WHEN "111110" =>
       result := inputs0( 63*size-1 DOWNTO 62*size);
     WHEN "111111" =>
       result := inputs0( 64*size-1 DOWNTO 63*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC) RETURN STD_LOGIC IS
   BEGIN RETURN TO_STDLOGIC(mux_v(inputs, sel)); END;

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
   BEGIN RETURN TO_STDLOGIC(mux_v(inputs, sel)); END;

   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS  --pragma hls_map_to_operator mux
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     CONSTANT size   : POSITIVE := inputs'LENGTH / 2;
     CONSTANT olen   : POSITIVE := inputs'LENGTH / 2;
     VARIABLE result : STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT inputs'LENGTH = olen * 2 SEVERITY FAILURE;
     --synopsys translate_on
       CASE sel IS
       WHEN '1'
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
            =>
         result := inputs0( size-1 DOWNTO 0);
       WHEN '0' 
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
            =>
         result := inputs0(2*size-1  DOWNTO size);
       WHEN others =>
         --synopsys translate_off
         result := resolve_std_logic_vector(inputs0(size-1 DOWNTO 0), inputs0( 2*size-1 DOWNTO size));
         --synopsys translate_on
       END CASE;
       RETURN result;
   END;
--   BEGIN RETURN mux_v(inputs, TO_STDLOGICVECTOR(sel)); END;

   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS --pragma hls_map_to_operator mux
     ALIAS    inputs0: STD_LOGIC_VECTOR( inputs'LENGTH-1 DOWNTO 0) IS inputs;
     ALIAS    sel0   : STD_LOGIC_VECTOR( sel'LENGTH-1 DOWNTO 0 ) IS sel;

     VARIABLE sellen : INTEGER RANGE 2-sel'LENGTH TO sel'LENGTH;
     CONSTANT size   : POSITIVE := inputs'LENGTH / 2;
     CONSTANT olen   : POSITIVE := inputs'LENGTH / 2**sel'LENGTH;
     VARIABLE result : STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
     TYPE inputs_array_type is array(natural range <>) of std_logic_vector( olen - 1 DOWNTO 0);
     VARIABLE inputs_array : inputs_array_type( 2**sel'LENGTH - 1 DOWNTO 0);
   BEGIN
     sellen := sel'LENGTH;
     --synopsys translate_off
     ASSERT inputs'LENGTH = olen * 2**sellen SEVERITY FAILURE;
     sellen := 2-sellen;
     --synopsys translate_on
     CASE sellen IS
     WHEN 1 =>
       CASE sel0(0) IS

       WHEN '1' 
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
            =>
         result := inputs0(  size-1 DOWNTO 0);
       WHEN '0' 
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
            =>
         result := inputs0(2*size-1 DOWNTO size);
       WHEN others =>
         --synopsys translate_off
         result := resolve_std_logic_vector(inputs0( size-1 DOWNTO 0), inputs0( 2*size-1 DOWNTO size));
         --synopsys translate_on
       END CASE;
     WHEN 2 =>
       result := mux_sel2_v(inputs, not sel);
     WHEN 3 =>
       result := mux_sel3_v(inputs, not sel);
     WHEN 4 =>
       result := mux_sel4_v(inputs, not sel);
     WHEN 5 =>
       result := mux_sel5_v(inputs, not sel);
     WHEN 6 =>
       result := mux_sel6_v(inputs, not sel);
     WHEN others =>
       -- synopsys translate_off
       IF(Is_X(sel0)) THEN
         result := (others => 'X');
       ELSE
       -- synopsys translate_on
         FOR i in 0 to 2**sel'LENGTH - 1 LOOP
           inputs_array(i) := inputs0( ((i + 1) * olen) - 1  DOWNTO i*olen);
         END LOOP;
         result := inputs_array(CONV_INTEGER( (UNSIGNED(NOT sel0)) ));
       -- synopsys translate_off
       END IF;
       -- synopsys translate_on
     END CASE;
     RETURN result;
   END;

 
-----------------------------------------------------------------
-- Latches
-----------------------------------------------------------------

   FUNCTION lat_s(dinput: STD_LOGIC; clk: STD_LOGIC; doutput: STD_LOGIC) RETURN STD_LOGIC IS
   BEGIN RETURN mux_s(STD_LOGIC_VECTOR'(doutput & dinput), clk); END;

   FUNCTION lat_v(dinput: STD_LOGIC_VECTOR ; clk: STD_LOGIC; doutput: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR IS
   BEGIN
     --synopsys translate_off
     ASSERT dinput'LENGTH = doutput'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     RETURN mux_v(doutput & dinput, clk);
   END;

-----------------------------------------------------------------
-- Tri-States
-----------------------------------------------------------------
--   FUNCTION tri_s(dinput: STD_LOGIC; control: STD_LOGIC) RETURN STD_LOGIC IS
--   BEGIN RETURN TO_STDLOGIC(tri_v(TO_STDLOGICVECTOR(dinput), control)); END;
--
--   FUNCTION tri_v(dinput: STD_LOGIC_VECTOR ; control: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
--     VARIABLE result: STD_LOGIC_VECTOR(dinput'range);
--   BEGIN
--     CASE control IS
--     WHEN '0' | 'L' =>
--       result := (others => 'Z');
--     WHEN '1' | 'H' =>
--       FOR i IN dinput'range LOOP
--         result(i) := to_UX01(dinput(i));
--       END LOOP;
--     WHEN others =>
--       -- synopsys translate_off
--       result := (others => 'X');
--       -- synopsys translate_on
--     END CASE;
--     RETURN result;
--   END;

-----------------------------------------------------------------
-- compare functions returning STD_LOGIC
-- in contrast to the functions returning boolean
-----------------------------------------------------------------

   FUNCTION "=" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "/="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "/="(l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;

   FUNCTION "<" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     VARIABLE diff: UNSIGNED(l'LENGTH DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT l'LENGTH = r'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     diff := ('0'&l) - ('0'&r);
     RETURN diff(l'LENGTH);
   END;
   FUNCTION "<"(l, r: SIGNED  ) RETURN STD_LOGIC IS
   BEGIN
     RETURN (UNSIGNED(l) < UNSIGNED(r)) xor (l(l'LEFT) xor r(r'LEFT));
   END;

   FUNCTION "<="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(r < l); END;
   FUNCTION "<=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(r < l); END;
   FUNCTION ">" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN r < l; END;
   FUNCTION ">"(l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN r < l; END;
   FUNCTION ">="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(l < r); END;
   FUNCTION ">=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(l < r); END;

   FUNCTION cmp (l, r: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
   BEGIN
     --synopsys translate_off
     ASSERT l'LENGTH = r'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     RETURN not or_s(l xor r);
   END;

-----------------------------------------------------------------
-- Vectorized Overloaded Arithmetic Operators
-----------------------------------------------------------------

   --some functions to placate spyglass
   FUNCTION mult_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a*b;
   END mult_natural;

   FUNCTION div_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a/b;
   END div_natural;

   FUNCTION mod_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a mod b;
   END mod_natural;

   FUNCTION add_unsigned(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a+b;
   END add_unsigned;

   FUNCTION sub_unsigned(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a-b;
   END sub_unsigned;

   FUNCTION sub_int(a,b : INTEGER) RETURN INTEGER IS
   BEGIN
     return a-b;
   END sub_int;

   FUNCTION concat_0(b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return '0' & b;
   END concat_0;

   FUNCTION concat_uns(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a&b;
   END concat_uns;

   FUNCTION concat_vect(a,b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
   BEGIN
     return a&b;
   END concat_vect;





   FUNCTION faccu(arg: UNSIGNED; width: NATURAL) RETURN UNSIGNED IS
     CONSTANT ninps : NATURAL := arg'LENGTH / width;
     ALIAS    arg0  : UNSIGNED(arg'LENGTH-1 DOWNTO 0) IS arg;
     VARIABLE result: UNSIGNED(width-1 DOWNTO 0);
     VARIABLE from  : INTEGER;
     VARIABLE dto   : INTEGER;
   BEGIN
     --synopsys translate_off
     ASSERT arg'LENGTH = width * ninps SEVERITY FAILURE;
     --synopsys translate_on
     result := (OTHERS => '0');
     FOR i IN ninps-1 DOWNTO 0 LOOP
       --result := result + arg0((i+1)*width-1 DOWNTO i*width);
       from := mult_natural((i+1), width)-1; --2.1.6.3
       dto  := mult_natural(i,width); --2.1.6.3
       result := add_unsigned(result , arg0(from DOWNTO dto) );
     END LOOP;
     RETURN result;
   END faccu;

   FUNCTION  fabs (arg1: SIGNED) RETURN UNSIGNED IS
   BEGIN
     CASE arg1(arg1'LEFT) IS
     WHEN '1'
     --synopsys translate_off
          | 'H'
     --synopsys translate_on
       =>
       RETURN UNSIGNED'("0") - UNSIGNED(arg1);
     WHEN '0'
     --synopsys translate_off
          | 'L'
     --synopsys translate_on
       =>
       RETURN UNSIGNED(arg1);
     WHEN others =>
       RETURN resolve_unsigned(UNSIGNED(arg1), UNSIGNED'("0") - UNSIGNED(arg1));
     END CASE;
   END;

   PROCEDURE divmod(l, r: UNSIGNED; rdiv, rmod: OUT UNSIGNED) IS
     CONSTANT llen: INTEGER := l'LENGTH;
     CONSTANT rlen: INTEGER := r'LENGTH;
     CONSTANT llen_plus_rlen: INTEGER := llen + rlen;
     VARIABLE lbuf: UNSIGNED(llen+rlen-1 DOWNTO 0);
     VARIABLE diff: UNSIGNED(rlen DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT rdiv'LENGTH = llen AND rmod'LENGTH = rlen SEVERITY FAILURE;
     --synopsys translate_on
     lbuf := (others => '0');
     lbuf(llen-1 DOWNTO 0) := l;
     FOR i IN rdiv'range LOOP
       diff := sub_unsigned(lbuf(llen_plus_rlen-1 DOWNTO llen-1) ,(concat_0(r)));
       rdiv(i) := not diff(rlen);
       IF diff(rlen) = '0' THEN
         lbuf(llen_plus_rlen-1 DOWNTO llen-1) := diff;
       END IF;
       lbuf(llen_plus_rlen-1 DOWNTO 1) := lbuf(llen_plus_rlen-2 DOWNTO 0);
     END LOOP;
     rmod := lbuf(llen_plus_rlen-1 DOWNTO llen);
   END divmod;

   FUNCTION "/"  (l, r: UNSIGNED) RETURN UNSIGNED IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(l, r, rdiv, rmod);
     RETURN rdiv;
   END "/";

   FUNCTION "MOD"(l, r: UNSIGNED) RETURN UNSIGNED IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(l, r, rdiv, rmod);
     RETURN rmod;
   END;

   FUNCTION "REM"(l, r: UNSIGNED) RETURN UNSIGNED IS
     BEGIN RETURN l MOD r; END;

   FUNCTION "/"  (l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) /= to_X01(r(r'LEFT)) THEN
       rdiv := UNSIGNED'("0") - rdiv;
     END IF;
     RETURN SIGNED(rdiv); -- overflow problem "1000" / "11"
   END "/";

   FUNCTION "MOD"(l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
     CONSTANT rnul: UNSIGNED(r'LENGTH-1 DOWNTO 0) := (others => '0');
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) = '1' THEN
       rmod := UNSIGNED'("0") - rmod;
     END IF;
     IF rmod /= rnul AND to_X01(l(l'LEFT)) /= to_X01(r(r'LEFT)) THEN
       rmod := UNSIGNED(r) + rmod;
     END IF;
     RETURN SIGNED(rmod);
   END "MOD";

   FUNCTION "REM"(l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) = '1' THEN
       rmod := UNSIGNED'("0") - rmod;
     END IF;
     RETURN SIGNED(rmod);
   END "REM";

   FUNCTION mult_unsigned(l,r : UNSIGNED) return UNSIGNED is
   BEGIN
     return l*r; 
   END mult_unsigned;

   FUNCTION "**" (l, r : UNSIGNED) RETURN UNSIGNED IS
     CONSTANT llen  : NATURAL := l'LENGTH;
     VARIABLE result: UNSIGNED(llen-1 DOWNTO 0);
     VARIABLE fak   : UNSIGNED(llen-1 DOWNTO 0);
   BEGIN
     fak := l;
     result := (others => '0'); result(0) := '1';
     FOR i IN r'reverse_range LOOP
       --was:result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(result & (result*fak)), r(i)));
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR( concat_uns(result , mult_unsigned(result,fak) )), r(i)));

       fak := mult_unsigned(fak , fak);
     END LOOP;
     RETURN result;
   END "**";

   FUNCTION "**" (l, r : SIGNED) RETURN SIGNED IS
     CONSTANT rlen  : NATURAL := r'LENGTH;
     ALIAS    r0    : SIGNED(0 TO r'LENGTH-1) IS r;
     VARIABLE result: SIGNED(l'range);
   BEGIN
     CASE r(r'LEFT) IS
     WHEN '0'
   --synopsys translate_off
          | 'L'
   --synopsys translate_on
     =>
       result := SIGNED(UNSIGNED(l) ** UNSIGNED(r0(1 TO r'LENGTH-1)));
     WHEN '1'
   --synopsys translate_off
          | 'H'
   --synopsys translate_on
     =>
       result := (others => '0');
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END "**";

-----------------------------------------------------------------
--               S H I F T   F U C T I O N S
-- negative shift shifts the opposite direction
-----------------------------------------------------------------

   FUNCTION add_nat(arg1 : NATURAL; arg2 : NATURAL ) RETURN NATURAL IS
   BEGIN
     return (arg1 + arg2);
   END;
   
--   FUNCTION UNSIGNED_2_BIT_VECTOR(arg1 : NATURAL; arg2 : NATURAL ) RETURN BIT_VECTOR IS
--   BEGIN
--     return (arg1 + arg2);
--   END;
   
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shl(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: SIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shl(SIGNED(result), arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shr(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: SIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shr(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: SIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: SIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: SIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_signed(
           fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl_stdar(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
        =>
         RETURN fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
        =>
         RETURN fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: SIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl_stdar(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_signed(
           fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr_stdar(arg1, arg2, '0', olen); END;

   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;


   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
     VARIABLE temp: UNSIGNED(len-1 DOWNTO 0);
     --SUBTYPE  sw_range IS NATURAL range 1 TO len;
     VARIABLE sw: NATURAL range 1 TO len;
     VARIABLE temp_idx : INTEGER; --2.1.6.3
   BEGIN
     sw := 1;
     result := (others => sbit);
     result(ilen-1 DOWNTO 0) := arg1;
     FOR i IN arg2'reverse_range LOOP
       temp := (others => '0');
       FOR i2 IN len-1-sw DOWNTO 0 LOOP
         --was:temp(i2+sw) := result(i2);
         temp_idx := add_nat(i2,sw);
         temp(temp_idx) := result(i2);
       END LOOP;
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(concat_uns(result,temp)), arg2(i)));
       sw := minimum(mult_natural(sw,2), len);
     END LOOP;
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
     VARIABLE temp: UNSIGNED(len-1 DOWNTO 0);
     SUBTYPE  sw_range IS NATURAL range 1 TO len;
     VARIABLE sw: sw_range;
     VARIABLE result_idx : INTEGER; --2.1.6.3
   BEGIN
     sw := 1;
     result := (others => sbit);
     result(ilen-1 DOWNTO 0) := arg1;
     FOR i IN arg2'reverse_range LOOP
       temp := (others => sbit);
       FOR i2 IN len-1-sw DOWNTO 0 LOOP
         -- was: temp(i2) := result(i2+sw);
         result_idx := add_nat(i2,sw);
         temp(i2) := result(result_idx);
       END LOOP;
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(concat_uns(result,temp)), arg2(i)));
       sw := minimum(mult_natural(sw,2), len);
     END LOOP;
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshl(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshr(arg1x_pad(arg1l+1 DOWNTO 1), not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshl(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr(arg1x_pad(arg1l+1 DOWNTO 1), not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshr(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshl(arg1 & '0', not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshr(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl(arg1 & '0', not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl(arg1, arg2, '0', olen); END;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr(arg1, arg2, '0', olen); END;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl(arg1, arg2, '0', olen); END;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr(arg1, arg2, '0', olen); END;

   FUNCTION fshl(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshl(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshr(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshr(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshl(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshl(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshr(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshr(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;


   FUNCTION frot(arg1: STD_LOGIC_VECTOR; arg2: STD_LOGIC_VECTOR; signd2: BOOLEAN; sdir: INTEGER range -1 TO 1) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len: INTEGER := arg1'LENGTH;
     VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     VARIABLE temp: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     SUBTYPE sw_range IS NATURAL range 0 TO len-1;
     VARIABLE sw: sw_range;
     VARIABLE temp_idx : INTEGER; --2.1.6.3
   BEGIN
     result := (others=>'0');
     result := arg1;
     sw := sdir MOD len;
     FOR i IN arg2'reverse_range LOOP
       EXIT WHEN sw = 0;
       IF signd2 AND i = arg2'LEFT THEN 
         sw := sub_int(len,sw); 
       END IF;
       -- temp := result(len-sw-1 DOWNTO 0) & result(len-1 DOWNTO len-sw)
       FOR i2 IN len-1 DOWNTO 0 LOOP
         --was: temp((i2+sw) MOD len) := result(i2);
         temp_idx := add_nat(i2,sw) MOD len;
         temp(temp_idx) := result(i2);
       END LOOP;
       result := mux_v(STD_LOGIC_VECTOR(concat_vect(result,temp)), arg2(i));
       sw := mod_natural(mult_natural(sw,2), len);
     END LOOP;
     RETURN result;
   END frot;

   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), FALSE, 1); END;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), FALSE, -1); END;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), TRUE, 1); END;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), TRUE, -1); END;

-----------------------------------------------------------------
-- indexing functions: LSB always has index 0
-----------------------------------------------------------------

   FUNCTION readindex(vec: STD_LOGIC_VECTOR; index: INTEGER                 ) RETURN STD_LOGIC IS
     CONSTANT len : INTEGER := vec'LENGTH;
     ALIAS    vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS vec;
   BEGIN
     IF index >= len OR index < 0 THEN
       RETURN 'X';
     END IF;
     RETURN vec0(index);
   END;

   FUNCTION readslice(vec: STD_LOGIC_VECTOR; index: INTEGER; width: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len : INTEGER := vec'LENGTH;
     CONSTANT indexPwidthM1 : INTEGER := index+width-1; --2.1.6.3
     ALIAS    vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS vec;
     CONSTANT xxx : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := (others => 'X');
   BEGIN
     IF index+width > len OR index < 0 THEN
       RETURN xxx;
     END IF;
     RETURN vec0(indexPwidthM1 DOWNTO index);
   END;

   FUNCTION writeindex(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC       ; index: INTEGER) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len : INTEGER := vec'LENGTH;
     VARIABLE vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     CONSTANT xxx : STD_LOGIC_VECTOR(len-1 DOWNTO 0) := (others => 'X');
   BEGIN
     vec0 := vec;
     IF index >= len OR index < 0 THEN
       RETURN xxx;
     END IF;
     vec0(index) := dinput;
     RETURN vec0;
   END;

   FUNCTION n_bits(p: NATURAL) RETURN POSITIVE IS
     VARIABLE n_b : POSITIVE;
     VARIABLE p_v : NATURAL;
   BEGIN
     p_v := p;
     FOR i IN 1 TO 32 LOOP
       p_v := div_natural(p_v,2);
       n_b := i;
       EXIT WHEN (p_v = 0);
     END LOOP;
     RETURN n_b;
   END;


--   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; index: INTEGER) RETURN STD_LOGIC_VECTOR IS
--
--     CONSTANT vlen: INTEGER := vec'LENGTH;
--     CONSTANT ilen: INTEGER := dinput'LENGTH;
--     CONSTANT max_shift: INTEGER := vlen-ilen;
--     CONSTANT ones: UNSIGNED(ilen-1 DOWNTO 0) := (others => '1');
--     CONSTANT xxx : STD_LOGIC_VECTOR(vlen-1 DOWNTO 0) := (others => 'X');
--     VARIABLE shift : UNSIGNED(n_bits(max_shift)-1 DOWNTO 0);
--     VARIABLE vec0: STD_LOGIC_VECTOR(vlen-1 DOWNTO 0);
--     VARIABLE inp: UNSIGNED(vlen-1 DOWNTO 0);
--     VARIABLE mask: UNSIGNED(vlen-1 DOWNTO 0);
--   BEGIN
--     inp := (others => '0');
--     mask := (others => '0');
--
--     IF index > max_shift OR index < 0 THEN
--       RETURN xxx;
--     END IF;
--
--     shift := CONV_UNSIGNED(index, shift'LENGTH);
--     inp(ilen-1 DOWNTO 0) := UNSIGNED(dinput);
--     mask(ilen-1 DOWNTO 0) := ones;
--     inp := fshl(inp, shift, vlen);
--     mask := fshl(mask, shift, vlen);
--     vec0 := (vec and (not STD_LOGIC_VECTOR(mask))) or STD_LOGIC_VECTOR(inp);
--     RETURN vec0;
--   END;

   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; enable: STD_LOGIC_VECTOR; byte_width: INTEGER;  index: INTEGER) RETURN STD_LOGIC_VECTOR IS

     type enable_matrix is array (0 to enable'LENGTH-1 ) of std_logic_vector(byte_width-1 downto 0);
     CONSTANT vlen: INTEGER := vec'LENGTH;
     CONSTANT ilen: INTEGER := dinput'LENGTH;
     CONSTANT max_shift: INTEGER := vlen-ilen;
     CONSTANT ones: UNSIGNED(ilen-1 DOWNTO 0) := (others => '1');
     CONSTANT xxx : STD_LOGIC_VECTOR(vlen-1 DOWNTO 0) := (others => 'X');
     VARIABLE shift : UNSIGNED(n_bits(max_shift)-1 DOWNTO 0);
     VARIABLE vec0: STD_LOGIC_VECTOR(vlen-1 DOWNTO 0);
     VARIABLE inp: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE mask: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE mask2: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE enables: enable_matrix;
     VARIABLE cat_enables: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0 );
     VARIABLE lsbi : INTEGER;
     VARIABLE msbi : INTEGER;

   BEGIN
     cat_enables := (others => '0');
     lsbi := 0;
     msbi := byte_width-1;
     inp := (others => '0');
     mask := (others => '0');

     IF index > max_shift OR index < 0 THEN
       RETURN xxx;
     END IF;

     --initialize enables
     for i in 0 TO (enable'LENGTH-1) loop
       enables(i)  := (others => enable(i));
       cat_enables(msbi downto lsbi) := enables(i) ;
       lsbi := msbi+1;
       msbi := msbi+byte_width;
     end loop;


     shift := CONV_UNSIGNED(index, shift'LENGTH);
     inp(ilen-1 DOWNTO 0) := UNSIGNED(dinput);
     mask(ilen-1 DOWNTO 0) := UNSIGNED((STD_LOGIC_VECTOR(ones) AND cat_enables));
     inp := fshl(inp, shift, vlen);
     mask := fshl(mask, shift, vlen);
     vec0 := (vec and (not STD_LOGIC_VECTOR(mask))) or STD_LOGIC_VECTOR(inp);
     RETURN vec0;
   END;


   FUNCTION ceil_log2(size : NATURAL) return NATURAL is
     VARIABLE cnt : NATURAL;
     VARIABLE res : NATURAL;
   begin
     cnt := 1;
     res := 0;
     while (cnt < size) loop
       res := res + 1;
       cnt := 2 * cnt;
     end loop;
     return res;
   END;
   
   FUNCTION bits(size : NATURAL) return NATURAL is
   begin
     return ceil_log2(size);
   END;

   PROCEDURE csa(a, b, c: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR) IS
   BEGIN
     s    := conv_std_logic_vector(a, s'LENGTH) xor conv_std_logic_vector(b, s'LENGTH) xor conv_std_logic_vector(c, s'LENGTH);
     cout := ( (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(b, cout'LENGTH)) or (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(c, cout'LENGTH)) or (conv_std_logic_vector(b, cout'LENGTH) and conv_std_logic_vector(c, cout'LENGTH)) );
   END PROCEDURE csa;

   PROCEDURE csha(a, b: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR) IS
   BEGIN
     s    := conv_std_logic_vector(a, s'LENGTH) xor conv_std_logic_vector(b, s'LENGTH);
     cout := (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(b, cout'LENGTH));
   END PROCEDURE csha;

END funcs;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_comps.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;

PACKAGE mgc_comps IS
 
FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER;
FUNCTION ceil_log2(size : NATURAL) return NATURAL;
 

COMPONENT mgc_not
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_and
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_nand
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_or
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_nor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_xor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_xnor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_lut
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_switch
  GENERIC (
    widths  : NATURAL;
    ninps  : NATURAL;
    widtha  : NATURAL;
    ninpa  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(widtha*ninpa - 1 DOWNTO 0);
    c: in  std_logic_vector(widths*ninps - 1 DOWNTO 0);
    s: in  std_logic;
    z: out std_logic_vector(widtha       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mux
  GENERIC (
    width  :  NATURAL;
    ctrlw  :  NATURAL;
    p2ctrlw : NATURAL := 0
  );
  PORT (
    a: in  std_logic_vector(width*(2**ctrlw) - 1 DOWNTO 0);
    c: in  std_logic_vector(ctrlw            - 1 DOWNTO 0);
    z: out std_logic_vector(width            - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mux1hot
  GENERIC (
    width  : NATURAL;
    ctrlw  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ctrlw - 1 DOWNTO 0);
    c: in  std_logic_vector(ctrlw       - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_reg_pos
  GENERIC (
    width  : NATURAL;
    has_a_rst : NATURAL;  -- 0 to 1
    a_rst_on  : NATURAL;  -- 0 to 1
    has_s_rst : NATURAL;  -- 0 to 1
    s_rst_on  : NATURAL;  -- 0 to 1
    has_enable : NATURAL; -- 0 to 1
    enable_on  : NATURAL  -- 0 to 1
  );
  PORT (
    clk: in  std_logic;
    d  : in  std_logic_vector(width-1 DOWNTO 0);
    z  : out std_logic_vector(width-1 DOWNTO 0);
    sync_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    sync_rst : in std_logic;
    async_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    async_rst : in std_logic;
    en : in std_logic
  );
END COMPONENT;

COMPONENT mgc_reg_neg
  GENERIC (
    width  : NATURAL;
    has_a_rst : NATURAL;  -- 0 to 1
    a_rst_on  : NATURAL;  -- 0 to 1
    has_s_rst : NATURAL;  -- 0 to 1
    s_rst_on  : NATURAL;   -- 0 to 1
    has_enable : NATURAL; -- 0 to 1
    enable_on  : NATURAL -- 0 to 1
  );
  PORT (
    clk: in  std_logic;
    d  : in  std_logic_vector(width-1 DOWNTO 0);
    z  : out std_logic_vector(width-1 DOWNTO 0);
    sync_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    sync_rst : in std_logic;
    async_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    async_rst : in std_logic;
    en : in std_logic
  );
END COMPONENT;

COMPONENT mgc_generic_reg
  GENERIC(
   width: natural := 8;
   ph_clk: integer range 0 to 1 := 1; -- clock polarity, 1=rising_edge
   ph_en: integer range 0 to 1 := 1;
   ph_a_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   ph_s_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   a_rst_used: integer range 0 to 1 := 1;
   s_rst_used: integer range 0 to 1 := 0;
   en_used: integer range 0 to 1 := 1
  );
  PORT(
   d: std_logic_vector(width-1 downto 0);
   clk: in std_logic;
   en: in std_logic;
   a_rst: in std_logic;
   s_rst: in std_logic;
   q: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_equal
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a : in  std_logic_vector(width-1 DOWNTO 0);
    b : in  std_logic_vector(width-1 DOWNTO 0);
    eq: out std_logic;
    ne: out std_logic
  );
END COMPONENT;

COMPONENT mgc_shift_l
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_r
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_bl
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_br
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_rot
  GENERIC (
    width  : NATURAL;
    width_s: NATURAL;
    signd_s: NATURAL;      -- 0:unsigned 1:signed
    sleft  : NATURAL;      -- 0:right 1:left;
    log2w  : NATURAL := 0; -- LOG2(width)
    l2wp2  : NATURAL := 0  --2**LOG2(width)
  );
  PORT (
    a : in  std_logic_vector(width  -1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width  -1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_sub
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add_ci
  GENERIC (
    width_a : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width_a, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width_a, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width_a,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width_a,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_addc
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add_msb
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add3
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_c : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_c : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(ifeqsel(width_c,0,width,width_c)-1 DOWNTO 0);
    d: in  std_logic_vector(0 DOWNTO 0);
    e: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_lt
  GENERIC (
    width_a : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic
  );
END COMPONENT;

COMPONENT mgc_add_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_sub_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_addc_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     c: in std_logic_vector(0 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_addsub
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    add: in  std_logic;
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_accu
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_abs
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_sqr
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_z : NATURAL    -- <= 2 * width_a
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_z : NATURAL    -- <= width_a + width_b
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul_fast
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_z : NATURAL    -- <= width_a + width_b
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul_pipe
  GENERIC (
    width_a       : NATURAL;
    signd_a       : NATURAL;
    width_b       : NATURAL;
    signd_b       : NATURAL;
    width_z       : NATURAL; -- <= width_a + width_b
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 
    s_rst_active  : NATURAL; -- 0 to 1 
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 

  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    s_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2add1
  GENERIC (
    gentype : NATURAL;
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    isadd   : NATURAL;
    add_b2  : NATURAL;
    add_d2  : NATURAL;
    use_const  : NATURAL
  );
  PORT (
    a   : in  std_logic_vector(width_a-1 DOWNTO 0);
    b   : in  std_logic_vector(width_b-1 DOWNTO 0);
    b2  : in  std_logic_vector(width_b2-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    c   : in  std_logic_vector(width_c-1 DOWNTO 0);
    d   : in  std_logic_vector(width_d-1 DOWNTO 0);
    d2  : in  std_logic_vector(width_d2-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    cst : in  std_logic_vector(width_e-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    z   : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2add1_pipe
  GENERIC (
    gentype : NATURAL;
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c + width_d)+1
    isadd   : NATURAL;
    add_b2   : NATURAL;
    add_d2   : NATURAL;
    use_const : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    b2     : in  std_logic_vector(width_b2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    c     : in  std_logic_vector(width_c-1 DOWNTO 0);
    d     : in  std_logic_vector(width_d-1 DOWNTO 0);
    d2     : in  std_logic_vector(width_d2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    cst   : in  std_logic_vector(width_e-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic;--spyglass disable SYNTH_5121,W240
    s_rst : in  std_logic;--spyglass disable SYNTH_5121,W240
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul4add1
  GENERIC (
    gentype : NATURAL;
    width_a1 : NATURAL;
    signd_a1 : NATURAL;
    width_a2 : NATURAL;
    signd_a2 : NATURAL;
    width_b1 : NATURAL;
    signd_b1 : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c1 : NATURAL;
    signd_c1 : NATURAL;
    width_c2 : NATURAL;
    signd_c2 : NATURAL;
    width_d1 : NATURAL;
    signd_d1 : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_z : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    add_a : NATURAL;
    add_b : NATURAL;
    add_c : NATURAL;
    use_const : NATURAL
  );
  PORT (
    a1  : in  std_logic_vector(width_a1-1 DOWNTO 0);
    a2  : in  std_logic_vector(width_a2-1 DOWNTO 0);
    b1  : in  std_logic_vector(width_b1-1 DOWNTO 0);
    b2  : in  std_logic_vector(width_b2-1 DOWNTO 0);
    c1  : in  std_logic_vector(width_c1-1 DOWNTO 0);
    c2  : in  std_logic_vector(width_c2-1 DOWNTO 0);
    d1  : in  std_logic_vector(width_d1-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    d2  : in  std_logic_vector(width_d2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    c  : in  std_logic_vector(width_c-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    z   : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul4add1_pipe
  GENERIC (
    gentype : NATURAL;
    width_a1 : NATURAL;
    signd_a1 : NATURAL;
    width_a2 : NATURAL;
    signd_a2 : NATURAL;
    width_b1 : NATURAL;
    signd_b1 : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c1 : NATURAL;
    signd_c1 : NATURAL;
    width_c2 : NATURAL;
    signd_c2 : NATURAL;
    width_d1 : NATURAL;
    signd_d1 : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_c  : NATURAL;
    signd_c  : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c + width_d)+1
    add_a : NATURAL;
    add_b : NATURAL;
    add_c : NATURAL;
    use_const : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a1  : in  std_logic_vector(width_a1-1 DOWNTO 0);
    a2  : in  std_logic_vector(width_a2-1 DOWNTO 0);
    b1  : in  std_logic_vector(width_b1-1 DOWNTO 0);
    b2  : in  std_logic_vector(width_b2-1 DOWNTO 0);
    c1  : in  std_logic_vector(width_c1-1 DOWNTO 0);
    c2  : in  std_logic_vector(width_c2-1 DOWNTO 0);
    d1  : in  std_logic_vector(width_d1-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    d2  : in  std_logic_vector(width_d2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    c   : in  std_logic_vector(width_c-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    s_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_muladd1
  -- operation is z = a * (b + d) + c + cst
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_cst : NATURAL;
    signd_cst : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c, width_cst)+1
    add_axb : NATURAL;
    add_c   : NATURAL;
    add_d   : NATURAL;
    use_const : NATURAL
  );
  PORT (
    a:   in  std_logic_vector(width_a-1 DOWNTO 0);
    b:   in  std_logic_vector(width_b-1 DOWNTO 0);
    c:   in  std_logic_vector(width_c-1 DOWNTO 0);
    cst: in  std_logic_vector(width_cst-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    d:   in  std_logic_vector(width_d-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    z:   out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_muladd1_pipe
  -- operation is z = a * (b + d) + c + cst
  GENERIC (
    gentype : NATURAL;
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_cst : NATURAL;
    signd_cst : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c, width_cst)+1
    add_axb : NATURAL;
    add_c   : NATURAL;
    add_d   : NATURAL;
    use_const : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    c     : in  std_logic_vector(width_c-1 DOWNTO 0);
    cst   : in  std_logic_vector(width_cst-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    d     : in  std_logic_vector(width_d-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    s_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_cplxmul
  GENERIC (
    width_ar : NATURAL;
    signd_ar : NATURAL;
    width_ai : NATURAL;
    signd_ai : NATURAL;
    width_br : NATURAL;
    signd_br : NATURAL;
    width_bi : NATURAL;
    signd_bi : NATURAL;
    width_zr : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    width_zi : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    add_rr   : NATURAL;
    add_ri   : NATURAL;
    add_ir   : NATURAL;
    add_ii   : NATURAL;
    gentype  : NATURAL
  );
  PORT (
    ar  : in  std_logic_vector(width_ar-1 DOWNTO 0);
    ai  : in  std_logic_vector(width_ai-1 DOWNTO 0);
    br  : in  std_logic_vector(width_br-1 DOWNTO 0);
    bi  : in  std_logic_vector(width_bi-1 DOWNTO 0);
    zr  : out std_logic_vector(width_zr-1 DOWNTO 0);
    zi  : out std_logic_vector(width_zi-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_cplxmul_pipe
  GENERIC (
    width_ar : NATURAL;
    signd_ar : NATURAL;
    width_ai : NATURAL;
    signd_ai : NATURAL;
    width_br : NATURAL;
    signd_br : NATURAL;
    width_bi : NATURAL;
    signd_bi : NATURAL;
    width_zr : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    width_zi : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    add_rr   : NATURAL;
    add_ri   : NATURAL;
    add_ir   : NATURAL;
    add_ii   : NATURAL;
    gentype  : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 --spyglass disable SYNTH_5121,W240
    s_rst_active  : NATURAL; -- 0 to 1 --spyglass disable SYNTH_5121,W240
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    ar  : in  std_logic_vector(width_ar-1 DOWNTO 0);
    ai  : in  std_logic_vector(width_ai-1 DOWNTO 0);
    br  : in  std_logic_vector(width_br-1 DOWNTO 0);
    bi  : in  std_logic_vector(width_bi-1 DOWNTO 0);
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic;
    s_rst : in  std_logic;
    zr  : out std_logic_vector(width_zr-1 DOWNTO 0);
    zi  : out std_logic_vector(width_zi-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mulacc_pipe
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c)+1
    add_d   : NATURAL;
    is_square: NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a         : in  std_logic_vector(width_a-1 DOWNTO 0);
    b         : in  std_logic_vector(width_b-1 DOWNTO 0);
    c         : in  std_logic_vector(width_c-1 DOWNTO 0);
    d         : in  std_logic_vector(width_d-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240 
    load      : in  std_logic;
    datavalid : in  std_logic;
    clk       : in  std_logic;
    en        : in  std_logic;
    a_rst     : in  std_logic; --spyglass disable SYNTH_5121,W240 
    s_rst     : in  std_logic; --spyglass disable SYNTH_5121,W240
    z         : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2acc_pipe
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_b2: NATURAL;
    signd_b2: NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_d2: NATURAL;
    signd_d2: NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c)+1
    add_cxd : NATURAL;
    add_b2  : NATURAL;
    add_d2  : NATURAL;
    square_b: NATURAL;
    square_d: NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a         : in  std_logic_vector(width_a-1 DOWNTO 0);
    b         : in  std_logic_vector(width_b-1 DOWNTO 0);
    b2        : in  std_logic_vector(width_b2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    c         : in  std_logic_vector(width_c-1 DOWNTO 0);
    d         : in  std_logic_vector(width_d-1 DOWNTO 0);
    d2        : in  std_logic_vector(width_d2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    e         : in  std_logic_vector(width_e-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    load      : in  std_logic;
    datavalid : in  std_logic;
    clk       : in  std_logic;
    en        : in  std_logic;
    a_rst     : in  std_logic;--spyglass disable SYNTH_5121,W240
    s_rst     : in  std_logic;--spyglass disable SYNTH_5121,W240
    z         : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul4acc_pipe
  GENERIC (
    width_a0 : NATURAL;
    signd_a0 : NATURAL;
    width_a1 : NATURAL;
    signd_a1 : NATURAL;
    width_b0 : NATURAL;
    signd_b0 : NATURAL;
    width_b1 : NATURAL;
    signd_b1 : NATURAL;
    width_c0 : NATURAL;
    signd_c0 : NATURAL;
    width_c1 : NATURAL;
    signd_c1 : NATURAL;
    width_d0 : NATURAL;
    signd_d0 : NATURAL;
    width_d1 : NATURAL;
    signd_d1 : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c)+1
    add_a : NATURAL;
    add_b : NATURAL;
    add_c : NATURAL;
    min_fb_size : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a0         : in  std_logic_vector(width_a0-1 DOWNTO 0);
    a1         : in  std_logic_vector(width_a1-1 DOWNTO 0);
    b0         : in  std_logic_vector(width_b0-1 DOWNTO 0);
    b1         : in  std_logic_vector(width_b1-1 DOWNTO 0);
    c0         : in  std_logic_vector(width_c0-1 DOWNTO 0);
    c1         : in  std_logic_vector(width_c1-1 DOWNTO 0);
    d0         : in  std_logic_vector(width_d0-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    d1         : in  std_logic_vector(width_d1-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    e         : in  std_logic_vector(width_e-1 DOWNTO 0);   --spyglass disable SYNTH_5121,W240
    load      : in  std_logic;
    datavalid : in  std_logic;
    clk       : in  std_logic;
    en        : in  std_logic;
    a_rst     : in  std_logic; --spyglass disable SYNTH_5121,W240
    s_rst     : in  std_logic; --spyglass disable SYNTH_5121,W240
    z         : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_div
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_a-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mod
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_rem
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_csa
  GENERIC (
     width : NATURAL
  );
  PORT (
     a: in std_logic_vector(width-1 downto 0);
     b: in std_logic_vector(width-1 downto 0);
     c: in std_logic_vector(width-1 downto 0);
     s: out std_logic_vector(width-1 downto 0);
     cout: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_csha
  GENERIC (
     width : NATURAL
  );
  PORT (
     a: in std_logic_vector(width-1 downto 0);
     b: in std_logic_vector(width-1 downto 0);
     s: out std_logic_vector(width-1 downto 0);
     cout: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_rom
    GENERIC (
      rom_id : natural := 1;
      size : natural := 33;
      width : natural := 32
      );
    PORT (
      data_in : std_logic_vector((size*width)-1 downto 0);
      addr : std_logic_vector(ceil_log2(size)-1 downto 0);
      data_out : out std_logic_vector(width-1 downto 0)
    );
END COMPONENT;

END mgc_comps;

PACKAGE BODY mgc_comps IS
 
   FUNCTION ceil_log2(size : NATURAL) return NATURAL is
     VARIABLE cnt : NATURAL;
     VARIABLE res : NATURAL;
   begin
     cnt := 1;
     res := 0;
     while (cnt < size) loop
       res := res + 1;
       cnt := 2 * cnt;
     end loop;
     return res;
   END;

   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 = arg2) THEN
       RETURN(seleq) ;
     ELSE
       RETURN(selne) ;
     END IF;
   END;
 
END mgc_comps;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.vhd 

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_div IS
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_a-1 DOWNTO 0)
  );
END mgc_div;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

USE work.funcs.all;

ARCHITECTURE beh OF mgc_div IS
BEGIN
  z <= std_logic_vector(unsigned(a) / unsigned(b)) WHEN signd = 0 ELSE
       std_logic_vector(  signed(a) /   signed(b));
END beh;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_shift_comps_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;

PACKAGE mgc_shift_comps_v5 IS

COMPONENT mgc_shift_l_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_r_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_bl_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_br_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

END mgc_shift_comps_v5;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_shift_bl_beh_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_shift_bl_v5 IS
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END mgc_shift_bl_v5;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

ARCHITECTURE beh OF mgc_shift_bl_v5 IS

  FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    CONSTANT len: INTEGER := input1'LENGTH;
    ALIAS input1a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input1;
    ALIAS input2a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input2;
    VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
  BEGIN
    result := (others => '0');
    --synopsys translate_off
    FOR i IN len-1 DOWNTO 0 LOOP
      result(i) := resolved(input1a(i) & input2a(i));
    END LOOP;
    --synopsys translate_on
    RETURN result;
  END;

  FUNCTION resolve_unsigned(input1: UNSIGNED; input2: UNSIGNED)
  RETURN UNSIGNED IS
  BEGIN
    RETURN UNSIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1),
                                             STD_LOGIC_VECTOR(input2)));
  END;

  FUNCTION resolve_signed(input1: SIGNED; input2: SIGNED)
  RETURN SIGNED IS
  BEGIN
    RETURN SIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1),
                                           STD_LOGIC_VECTOR(input2)));
  END;

  FUNCTION "not"(arg1: UNSIGNED) RETURN UNSIGNED IS
    BEGIN RETURN UNSIGNED(not STD_LOGIC_VECTOR(arg1)); END;

  FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
  BEGIN
    IF(arg1 > arg2) THEN
      RETURN(arg1) ;
    ELSE
      RETURN(arg2) ;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shr(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: SIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(SIGNED(result), arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshr_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: SIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shr(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

 FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
    ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
    CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
    ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
    VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
    VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
  BEGIN
    result := (others=>'0');
    arg1x_pad(arg1l+1) := sbit;
    arg1x_pad(arg1l downto 0) := arg1x;
    IF arg2l = 0 THEN
      RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
    -- ELSIF arg1l = 0 THEN
    --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
    ELSE
      CASE arg2x(arg2l) IS
      WHEN '0'
    --synopsys translate_off
           | 'L'
    --synopsys translate_on
      =>
        RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
      WHEN '1'
    --synopsys translate_off
           | 'H'
    --synopsys translate_on
      =>
        RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
      WHEN others =>
        --synopsys translate_off
        result := resolve_unsigned(
          fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
          fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
        );
        --synopsys translate_on
        RETURN result;
      END CASE;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
    ALIAS    arg1x: SIGNED(arg1l DOWNTO 0) IS arg1;
    CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
    ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
    VARIABLE arg1x_pad: SIGNED(arg1l+1 DOWNTO 0);
    VARIABLE result: SIGNED(olen-1 DOWNTO 0);
  BEGIN
    result := (others=>'0');
    arg1x_pad(arg1l+1) := sbit;
    arg1x_pad(arg1l downto 0) := arg1x;
    IF arg2l = 0 THEN
      RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
    -- ELSIF arg1l = 0 THEN
    --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
    ELSE
      CASE arg2x(arg2l) IS
      WHEN '0'
      --synopsys translate_off
           | 'L'
      --synopsys translate_on
      =>
        RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
      WHEN '1'
      --synopsys translate_off
           | 'H'
      --synopsys translate_on
      =>
        RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
      WHEN others =>
        --synopsys translate_off
        result := resolve_signed(
          fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
          fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
        );
        --synopsys translate_on
        RETURN result;
      END CASE;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE)
  RETURN UNSIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, '0', olen);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE)
  RETURN SIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen);
  END;

BEGIN
UNSGNED:  IF signd_a = 0 GENERATE
    z <= std_logic_vector(fshl_stdar(unsigned(a), signed(s), width_z));
  END GENERATE;
SGNED:  IF signd_a /= 0 GENERATE
    z <= std_logic_vector(fshl_stdar(  signed(a), signed(s), width_z));
  END GENERATE;
END beh;

--------> ../td_ccore_solutions/leading_sign_22_0_dc00658b4b4575636e73bb7f99c473ff6c07_0/rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2023.2/1059873 Production Release
--  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
-- 
--  Generated by:   r12016@cad40
--  Generated date: Thu Jun 13 03:06:15 2024
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    leading_sign_22_0
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY leading_sign_22_0 IS
  PORT(
    mantissa : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
    rtn : OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
  );
END leading_sign_22_0;

ARCHITECTURE v1 OF leading_sign_22_0 IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_6_2_sdt_2
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_18_3_sdt_3
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_2
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_14_2_sdt_1
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_1
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_34_2_sdt_1
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      : STD_LOGIC;
  SIGNAL c_h_1_2 : STD_LOGIC;
  SIGNAL c_h_1_5 : STD_LOGIC;
  SIGNAL c_h_1_6 : STD_LOGIC;
  SIGNAL c_h_1_8 : STD_LOGIC;
  SIGNAL c_h_1_9 : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc
      : STD_LOGIC;

  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_77_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000
      : STD_LOGIC;
  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

BEGIN
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_6_2_sdt_2
      <= NOT(CONV_SL_1_1(mantissa(19 DOWNTO 18)/=STD_LOGIC_VECTOR'("00")));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_14_2_sdt_1
      <= NOT(CONV_SL_1_1(mantissa(17 DOWNTO 16)/=STD_LOGIC_VECTOR'("00")));
  c_h_1_2 <= (NOT (mantissa(20))) AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_6_2_sdt_2;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_18_3_sdt_3
      <= CONV_SL_1_1(mantissa(15 DOWNTO 14)=STD_LOGIC_VECTOR'("00")) AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_14_2_sdt_1;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_2
      <= NOT(CONV_SL_1_1(mantissa(11 DOWNTO 10)/=STD_LOGIC_VECTOR'("00")));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_1
      <= NOT(CONV_SL_1_1(mantissa(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_34_2_sdt_1
      <= NOT(CONV_SL_1_1(mantissa(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("00")));
  c_h_1_5 <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_1
      AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_2;
  c_h_1_6 <= c_h_1_2 AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_18_3_sdt_3;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4
      <= CONV_SL_1_1(mantissa(7 DOWNTO 6)=STD_LOGIC_VECTOR'("00")) AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_34_2_sdt_1
      AND c_h_1_5;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2
      <= NOT(CONV_SL_1_1(mantissa(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      <= NOT(CONV_SL_1_1(mantissa(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00")));
  c_h_1_8 <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2;
  c_h_1_9 <= c_h_1_6 AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc
      <= CONV_SL_1_1(mantissa(1 DOWNTO 0)=STD_LOGIC_VECTOR'("00")) AND c_h_1_8 AND
      c_h_1_9;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_nl
      <= c_h_1_6 AND (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4);
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_77_nl
      <= c_h_1_2 AND (c_h_1_5 OR (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_18_3_sdt_3))
      AND (c_h_1_8 OR (NOT c_h_1_9));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      <= (NOT((mantissa(20)) OR (NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_14_2_sdt_1
      OR (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_6_2_sdt_2)))
      OR ((NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_1
      AND (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_34_2_sdt_1
      OR (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_2))))
      AND c_h_1_6) OR ((NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      AND (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2)))
      AND c_h_1_9))) OR ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000
      <= NOT((NOT(CONV_SL_1_1(mantissa(20 DOWNTO 19)/=STD_LOGIC_VECTOR'("01"))))
      OR (((mantissa(17)) OR (NOT(CONV_SL_1_1(mantissa(16 DOWNTO 15)/=STD_LOGIC_VECTOR'("01")))))
      AND c_h_1_2) OR ((NOT((NOT((mantissa(13)) OR (NOT(CONV_SL_1_1(mantissa(12 DOWNTO
      11)/=STD_LOGIC_VECTOR'("01")))))) AND (NOT(((mantissa(9)) OR (NOT(CONV_SL_1_1(mantissa(8
      DOWNTO 7)/=STD_LOGIC_VECTOR'("01"))))) AND c_h_1_5)))) AND c_h_1_6) OR ((NOT((NOT((mantissa(5))
      OR (NOT(CONV_SL_1_1(mantissa(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("01")))))) AND
      (NOT((mantissa(1)) AND c_h_1_8)))) AND c_h_1_9) OR ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc);
  rtn <= STD_LOGIC_VECTOR'( c_h_1_9 & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_nl
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_77_nl
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000);
END v1;




--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_shift_l_beh_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_shift_l_v5 IS
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END mgc_shift_l_v5;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

ARCHITECTURE beh OF mgc_shift_l_v5 IS

  FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
  BEGIN
    IF(arg1 > arg2) THEN
      RETURN(arg1) ;
    ELSE
      RETURN(arg2) ;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: SIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(SIGNED(result), arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE)
  RETURN UNSIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, '0', olen);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE)
  RETURN SIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen);
  END;

BEGIN
UNSGNED:  IF signd_a = 0 GENERATE
    z <= std_logic_vector(fshl_stdar(unsigned(a), unsigned(s), width_z));
  END GENERATE;
SGNED:  IF signd_a /= 0 GENERATE
    z <= std_logic_vector(fshl_stdar(  signed(a), unsigned(s), width_z));
  END GENERATE;
END beh;

--------> ./rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2023.2/1059873 Production Release
--  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
-- 
--  Generated by:   r12016@cad40
--  Generated date: Thu Jun 13 03:09:27 2024
-- ----------------------------------------------------------------------

-- 
LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


PACKAGE UNET_IP_batchnorm_relumgc_rom_11_736_5_1_pkg IS 
  COMPONENT UNET_IP_batchnorm_relumgc_rom_11_736_5_1
    PORT (
      addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
  END COMPONENT;
END UNET_IP_batchnorm_relumgc_rom_11_736_5_1_pkg;

PACKAGE BODY UNET_IP_batchnorm_relumgc_rom_11_736_5_1_pkg IS
END UNET_IP_batchnorm_relumgc_rom_11_736_5_1_pkg;

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


USE work.UNET_IP_batchnorm_relumgc_rom_11_736_5_1_pkg.all;
LIBRARY std;

USE std.textio.all;
USE ieee.std_logic_textio.all;

ENTITY UNET_IP_batchnorm_relumgc_rom_11_736_5_1 IS
    PORT (
      addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END UNET_IP_batchnorm_relumgc_rom_11_736_5_1;

ARCHITECTURE v3 OF UNET_IP_batchnorm_relumgc_rom_11_736_5_1 IS
  -- Start of SIF_NL_VHDL::nhl_rom_body
  -- Constants for ROM dimensions
  CONSTANT n_width    : INTEGER := 5;
  CONSTANT n_size     : INTEGER := 736;
  CONSTANT n_addr_w   : INTEGER := 10;
  CONSTANT n_inreg    : INTEGER := 0;
  CONSTANT n_outreg   : INTEGER := 0;
  -- Define data types for ROM storage;
  SUBTYPE  word  IS std_logic_vector((n_width)-1 DOWNTO 0);
  TYPE     lookup_table IS ARRAY (0 to n_size-1) of word;

  SIGNAL mem : lookup_table := lookup_table'(
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10000"),
    word'("10000"),
    word'("10011"),
    word'("01111"),
    word'("01111"),
    word'("01111"),
    word'("10010"),
    word'("10000"),
    word'("10011"),
    word'("01111")
  );
BEGIN

  -- Reading ROM
  PROCESS(addr)
    VARIABLE idx_addr : INTEGER;
  BEGIN
    idx_addr := conv_integer(unsigned(addr(9 DOWNTO 0)));
    IF idx_addr >= 0 AND idx_addr < 736 THEN
      data_out <= mem(idx_addr);
    ELSE
      data_out <= (OTHERS => '0');
    END IF;
  END PROCESS;

END v3;



--------> ./rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2023.2/1059873 Production Release
--  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
-- 
--  Generated by:   r12016@cad40
--  Generated date: Thu Jun 13 03:09:27 2024
-- ----------------------------------------------------------------------

-- 
LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


PACKAGE UNET_IP_batchnorm_relumgc_rom_12_736_4_1_pkg IS 
  COMPONENT UNET_IP_batchnorm_relumgc_rom_12_736_4_1
    PORT (
      addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;
END UNET_IP_batchnorm_relumgc_rom_12_736_4_1_pkg;

PACKAGE BODY UNET_IP_batchnorm_relumgc_rom_12_736_4_1_pkg IS
END UNET_IP_batchnorm_relumgc_rom_12_736_4_1_pkg;

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


USE work.UNET_IP_batchnorm_relumgc_rom_12_736_4_1_pkg.all;
LIBRARY std;

USE std.textio.all;
USE ieee.std_logic_textio.all;

ENTITY UNET_IP_batchnorm_relumgc_rom_12_736_4_1 IS
    PORT (
      addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END UNET_IP_batchnorm_relumgc_rom_12_736_4_1;

ARCHITECTURE v3 OF UNET_IP_batchnorm_relumgc_rom_12_736_4_1 IS
  -- Start of SIF_NL_VHDL::nhl_rom_body
  -- Constants for ROM dimensions
  CONSTANT n_width    : INTEGER := 4;
  CONSTANT n_size     : INTEGER := 736;
  CONSTANT n_addr_w   : INTEGER := 10;
  CONSTANT n_inreg    : INTEGER := 0;
  CONSTANT n_outreg   : INTEGER := 0;
  -- Define data types for ROM storage;
  SUBTYPE  word  IS std_logic_vector((n_width)-1 DOWNTO 0);
  TYPE     lookup_table IS ARRAY (0 to n_size-1) of word;

  SIGNAL mem : lookup_table := lookup_table'(
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("1111"),
    word'("1111"),
    word'("0000"),
    word'("0000"),
    word'("0100"),
    word'("0000"),
    word'("1111"),
    word'("1110"),
    word'("0101"),
    word'("0000"),
    word'("0100"),
    word'("1111")
  );
BEGIN

  -- Reading ROM
  PROCESS(addr)
    VARIABLE idx_addr : INTEGER;
  BEGIN
    idx_addr := conv_integer(unsigned(addr(9 DOWNTO 0)));
    IF idx_addr >= 0 AND idx_addr < 736 THEN
      data_out <= mem(idx_addr);
    ELSE
      data_out <= (OTHERS => '0');
    END IF;
  END PROCESS;

END v3;



--------> ./rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2023.2/1059873 Production Release
--  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
-- 
--  Generated by:   r12016@cad40
--  Generated date: Thu Jun 13 03:09:27 2024
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen
    IS
  PORT(
    clken : OUT STD_LOGIC;
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    clken_d : IN STD_LOGIC;
    d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
    we_d : IN STD_LOGIC;
    writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen;

ARCHITECTURE v3 OF UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen
    IS
  -- Default Constants

BEGIN
  clken <= (clken_d);
  we <= (writeA_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
END v3;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen
    IS
  PORT(
    clken : OUT STD_LOGIC;
    q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    clken_d : IN STD_LOGIC;
    q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
    re_d : IN STD_LOGIC;
    readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen;

ARCHITECTURE v3 OF UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen
    IS
  -- Default Constants

BEGIN
  clken <= (clken_d);
  q_d <= q;
  re <= (readA_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
END v3;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_batchnorm_relu_run_batch_run_batch_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY UNET_IP_batchnorm_relu_run_batch_run_batch_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    arst_n : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
    main_C_0_tr0 : IN STD_LOGIC;
    LOOP_MEAN_C_0_tr0 : IN STD_LOGIC;
    LOOP_CH_C_5_tr0 : IN STD_LOGIC;
    LOOP_VAR_C_3_tr0 : IN STD_LOGIC;
    LOOP_OUT_C_0_tr0 : IN STD_LOGIC;
    LOOP_CH_C_12_tr0 : IN STD_LOGIC
  );
END UNET_IP_batchnorm_relu_run_batch_run_batch_fsm;

ARCHITECTURE v3 OF UNET_IP_batchnorm_relu_run_batch_run_batch_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1
  TYPE UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1_ST IS (main_C_0, LOOP_MEAN_C_0,
      LOOP_CH_C_0, LOOP_CH_C_1, LOOP_CH_C_2, LOOP_CH_C_3, LOOP_CH_C_4, LOOP_CH_C_5,
      LOOP_VAR_C_0, LOOP_VAR_C_1, LOOP_VAR_C_2, LOOP_VAR_C_3, LOOP_CH_C_6, LOOP_CH_C_7,
      LOOP_CH_C_8, LOOP_CH_C_9, LOOP_CH_C_10, LOOP_CH_C_11, LOOP_OUT_C_0, LOOP_CH_C_12,
      main_C_1);

  SIGNAL state_var : UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1_ST;
  SIGNAL state_var_NS : UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1_ST;

BEGIN
  UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1 : PROCESS (main_C_0_tr0, LOOP_MEAN_C_0_tr0,
      LOOP_CH_C_5_tr0, LOOP_VAR_C_3_tr0, LOOP_OUT_C_0_tr0, LOOP_CH_C_12_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN LOOP_MEAN_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000010");
        IF ( LOOP_MEAN_C_0_tr0 = '1' ) THEN
          state_var_NS <= LOOP_CH_C_0;
        ELSE
          state_var_NS <= LOOP_MEAN_C_0;
        END IF;
      WHEN LOOP_CH_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000100");
        state_var_NS <= LOOP_CH_C_1;
      WHEN LOOP_CH_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000001000");
        state_var_NS <= LOOP_CH_C_2;
      WHEN LOOP_CH_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000010000");
        state_var_NS <= LOOP_CH_C_3;
      WHEN LOOP_CH_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000100000");
        state_var_NS <= LOOP_CH_C_4;
      WHEN LOOP_CH_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000001000000");
        state_var_NS <= LOOP_CH_C_5;
      WHEN LOOP_CH_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000010000000");
        IF ( LOOP_CH_C_5_tr0 = '1' ) THEN
          state_var_NS <= LOOP_CH_C_6;
        ELSE
          state_var_NS <= LOOP_VAR_C_0;
        END IF;
      WHEN LOOP_VAR_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000100000000");
        state_var_NS <= LOOP_VAR_C_1;
      WHEN LOOP_VAR_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000001000000000");
        state_var_NS <= LOOP_VAR_C_2;
      WHEN LOOP_VAR_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000010000000000");
        state_var_NS <= LOOP_VAR_C_3;
      WHEN LOOP_VAR_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000100000000000");
        IF ( LOOP_VAR_C_3_tr0 = '1' ) THEN
          state_var_NS <= LOOP_CH_C_6;
        ELSE
          state_var_NS <= LOOP_VAR_C_0;
        END IF;
      WHEN LOOP_CH_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000001000000000000");
        state_var_NS <= LOOP_CH_C_7;
      WHEN LOOP_CH_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000010000000000000");
        state_var_NS <= LOOP_CH_C_8;
      WHEN LOOP_CH_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000100000000000000");
        state_var_NS <= LOOP_CH_C_9;
      WHEN LOOP_CH_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001000000000000000");
        state_var_NS <= LOOP_CH_C_10;
      WHEN LOOP_CH_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010000000000000000");
        state_var_NS <= LOOP_CH_C_11;
      WHEN LOOP_CH_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100000000000000000");
        state_var_NS <= LOOP_OUT_C_0;
      WHEN LOOP_OUT_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000000000000000000");
        IF ( LOOP_OUT_C_0_tr0 = '1' ) THEN
          state_var_NS <= LOOP_CH_C_12;
        ELSE
          state_var_NS <= LOOP_OUT_C_0;
        END IF;
      WHEN LOOP_CH_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000000000000000000");
        IF ( LOOP_CH_C_12_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= LOOP_MEAN_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000000000000000000");
        state_var_NS <= main_C_0;
      -- main_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000001");
        IF ( main_C_0_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= LOOP_MEAN_C_0;
        END IF;
    END CASE;
  END PROCESS UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1;

  UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1_REG : PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      state_var <= main_C_0;
    ELSIF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= main_C_0;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1_REG;

END v3;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_batchnorm_relu_run_batch_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY UNET_IP_batchnorm_relu_run_batch_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    arst_n : IN STD_LOGIC;
    operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z : IN STD_LOGIC_VECTOR (33
        DOWNTO 0);
    operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg : OUT STD_LOGIC_VECTOR
        (27 DOWNTO 0)
  );
END UNET_IP_batchnorm_relu_run_batch_wait_dp;

ARCHITECTURE v3 OF UNET_IP_batchnorm_relu_run_batch_wait_dp IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6 :
      STD_LOGIC_VECTOR (27 DOWNTO 0);

BEGIN
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6 <= STD_LOGIC_VECTOR'(
          "0000000000000000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6 <=
            STD_LOGIC_VECTOR'( "0000000000000000000000000000");
      ELSE
        operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6 <=
            operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z(33 DOWNTO 6);
      END IF;
    END IF;
  END PROCESS;
END v3;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_batchnorm_relu_run_batch
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY UNET_IP_batchnorm_relu_run_batch IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    arst_n : IN STD_LOGIC;
    input_triosy_lz : OUT STD_LOGIC;
    output_triosy_lz : OUT STD_LOGIC;
    channels : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    height : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    width : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    offset : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    input_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    input_rsci_radr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    output_rsci_d_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    output_rsci_wadr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a : OUT STD_LOGIC_VECTOR
        (33 DOWNTO 0);
    operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b : OUT STD_LOGIC_VECTOR
        (12 DOWNTO 0);
    operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z : IN STD_LOGIC_VECTOR (33
        DOWNTO 0);
    input_rsci_re_d_pff : OUT STD_LOGIC;
    output_rsci_we_d_pff : OUT STD_LOGIC
  );
END UNET_IP_batchnorm_relu_run_batch;

ARCHITECTURE v3 OF UNET_IP_batchnorm_relu_run_batch IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL LOOP_OUT_div_5_cmp_z : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_1_z : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_2_z : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_3_z : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_4_z : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg : STD_LOGIC_VECTOR
      (27 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_a_21_6 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_b_13_0 : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_1_a_21_6 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_1_b_13_0 : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_2_a_21_6 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_2_b_13_0 : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_3_a_21_6 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_3_b_13_0 : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_4_a_21_6 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_4_b_13_0 : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL fsm_output : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL LOOP_OUT_LOOP_OUT_acc_tmp : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp
      : STD_LOGIC;
  SIGNAL and_dcpl_45 : STD_LOGIC;
  SIGNAL and_dcpl_46 : STD_LOGIC;
  SIGNAL and_dcpl_49 : STD_LOGIC;
  SIGNAL and_dcpl_50 : STD_LOGIC;
  SIGNAL or_dcpl_54 : STD_LOGIC;
  SIGNAL or_dcpl_55 : STD_LOGIC;
  SIGNAL or_dcpl_56 : STD_LOGIC;
  SIGNAL or_dcpl_58 : STD_LOGIC;
  SIGNAL or_dcpl_60 : STD_LOGIC;
  SIGNAL and_dcpl_63 : STD_LOGIC;
  SIGNAL and_dcpl_65 : STD_LOGIC;
  SIGNAL or_dcpl_62 : STD_LOGIC;
  SIGNAL or_dcpl_64 : STD_LOGIC;
  SIGNAL and_dcpl_77 : STD_LOGIC;
  SIGNAL and_dcpl_79 : STD_LOGIC;
  SIGNAL and_dcpl_84 : STD_LOGIC;
  SIGNAL and_dcpl_85 : STD_LOGIC;
  SIGNAL and_dcpl_87 : STD_LOGIC;
  SIGNAL and_dcpl_89 : STD_LOGIC;
  SIGNAL and_dcpl_91 : STD_LOGIC;
  SIGNAL and_dcpl_92 : STD_LOGIC;
  SIGNAL and_dcpl_94 : STD_LOGIC;
  SIGNAL LOOP_MEAN_stage_0 : STD_LOGIC;
  SIGNAL exit_LOOP_CH_sva_mx0 : STD_LOGIC;
  SIGNAL LOOP_MEAN_stage_0_2 : STD_LOGIC;
  SIGNAL LOOP_OUT_stage_0 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_8 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_7 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_6 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_5 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_4 : STD_LOGIC;
  SIGNAL LOOP_OUT_stage_0_5 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_3 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_2 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_1 : STD_LOGIC;
  SIGNAL LOOP_MEAN_stage_0_3 : STD_LOGIC;
  SIGNAL LOOP_MEAN_asn_6_itm_2 : STD_LOGIC;
  SIGNAL LOOP_OUT_div_5cyc_st_4 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_OUT_stage_0_8 : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1
      : STD_LOGIC;
  SIGNAL LOOP_CH_var_21_1_sva : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5cyc_st_1 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_OUT_stage_0_4 : STD_LOGIC;
  SIGNAL exit_LOOP_OUT_sva_st_9 : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3
      : STD_LOGIC;
  SIGNAL LOOP_OUT_div_5cyc_st_5 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_OUT_stage_0_9 : STD_LOGIC;
  SIGNAL reg_output_triosy_obj_ld_cse : STD_LOGIC;
  SIGNAL nor_4_cse : STD_LOGIC;
  SIGNAL or_cse : STD_LOGIC;
  SIGNAL or_123_ssc : STD_LOGIC;
  SIGNAL reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd : STD_LOGIC_VECTOR
      (13 DOWNTO 0);
  SIGNAL reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2 : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL or_159_cse : STD_LOGIC;
  SIGNAL nor_21_cse : STD_LOGIC;
  SIGNAL LOOP_MEAN_mul_itm_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_MEAN_asn_3_itm_1 : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL LOOP_VAR_acc_1_itm : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0 : STD_LOGIC_VECTOR (11
      DOWNTO 0);
  SIGNAL LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2 : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL operator_32_8_false_AC_TRN_AC_WRAP_lshift_itm : STD_LOGIC_VECTOR (31 DOWNTO
      0);
  SIGNAL LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm : STD_LOGIC_VECTOR
      (4 DOWNTO 0);
  SIGNAL LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm : STD_LOGIC_VECTOR (20 DOWNTO
      0);
  SIGNAL z_out : STD_LOGIC_VECTOR (19 DOWNTO 0);
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL num_elements_sva : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL LOOP_CH_c_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL LOOP_CH_var_tmp_33_6_sva : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL LOOP_CH_i_1_sva : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL LOOP_CH_mean_sva : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5cyc : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_OUT_stage_0_6 : STD_LOGIC;
  SIGNAL LOOP_OUT_stage_0_7 : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1
      : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
      : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL LOOP_OUT_mul_itm_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1
      : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1
      : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
      : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1
      : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2
      : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1 : STD_LOGIC_VECTOR
      (4 DOWNTO 0);
  SIGNAL LOOP_OUT_acc_5_itm_1 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1 : STD_LOGIC_VECTOR
      (3 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5cyc_st_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5cyc_st_3 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL mut_1_1_13_0 : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL LOOP_OUT_div_tmp_duc_17_0 : STD_LOGIC_VECTOR (17 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_4_b_13_0_mx0c1 : STD_LOGIC;
  SIGNAL LOOP_OUT_div_5_cmp_3_b_13_0_mx0c1 : STD_LOGIC;
  SIGNAL LOOP_OUT_div_5_cmp_2_b_13_0_mx0c1 : STD_LOGIC;
  SIGNAL LOOP_OUT_div_5_cmp_1_b_13_0_mx0c1 : STD_LOGIC;
  SIGNAL LOOP_OUT_div_5_cmp_b_13_0_mx0c1 : STD_LOGIC;
  SIGNAL LOOP_CH_c_sva_2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL LOOP_CH_var_tmp_33_6_sva_mx0w1 : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL LOOP_CH_i_1_sva_2 : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL LOOP_VAR_acc_4_cse_sva_mx0w1 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL LOOP_CH_mean_tmp_19_8_sva_2 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1
      : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL LOOP_VAR_mul_4 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_OUT_acc_imod_1 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_OUT_acc_idiv_1 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_OUT_acc_3_cse_sva_1 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL LOOP_VAR_acc_4_cse_sva_14_12 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_VAR_acc_4_cse_sva_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1 : STD_LOGIC_VECTOR
      (4 DOWNTO 0);
  SIGNAL and_107_rgt : STD_LOGIC;
  SIGNAL and_108_rgt : STD_LOGIC;
  SIGNAL and_109_rgt : STD_LOGIC;
  SIGNAL and_110_rgt : STD_LOGIC;
  SIGNAL and_111_rgt : STD_LOGIC;
  SIGNAL reg_LOOP_CH_idx_14_0_sva_2_ftd : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL reg_LOOP_CH_idx_14_0_sva_2_ftd_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL LOOP_CH_idx_14_0_sva_3_14_12 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_CH_idx_14_0_sva_3_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL LOOP_CH_c_or_cse : STD_LOGIC;
  SIGNAL reg_LOOP_CH_idx_14_0_sva_4_ftd : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL reg_LOOP_CH_idx_14_0_sva_4_ftd_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL LOOP_CH_idx_14_0_sva_5_14_12 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_CH_idx_14_0_sva_5_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL reg_LOOP_CH_idx_14_0_sva_6_ftd : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL reg_LOOP_CH_idx_14_0_sva_6_ftd_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL LOOP_CH_idx_14_0_sva_7_14_12 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL LOOP_CH_idx_14_0_sva_7_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL reg_LOOP_CH_idx_14_0_sva_8_ftd : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL reg_LOOP_CH_idx_14_0_sva_8_ftd_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1
      : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL LOOP_OUT_acc_10_itm_13_1 : STD_LOGIC;

  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_nl : STD_LOGIC_VECTOR (13
      DOWNTO 0);
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_1_nl : STD_LOGIC;
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_and_5_nl : STD_LOGIC;
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_nl : STD_LOGIC;
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_1_nl : STD_LOGIC_VECTOR
      (1 DOWNTO 0);
  SIGNAL LOOP_MEAN_mux1h_8_nl : STD_LOGIC;
  SIGNAL LOOP_OUT_LOOP_OUT_and_nl : STD_LOGIC;
  SIGNAL LOOP_VAR_acc_7_nl : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL LOOP_VAR_acc_8_nl : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL nor_29_nl : STD_LOGIC;
  SIGNAL LOOP_MEAN_mux_3_nl : STD_LOGIC;
  SIGNAL LOOP_OUT_mux_nl : STD_LOGIC;
  SIGNAL LOOP_CH_mean_tmp_LOOP_CH_mean_tmp_and_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL LOOP_CH_mean_tmp_mux_1_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL and_159_nl : STD_LOGIC;
  SIGNAL LOOP_CH_mean_tmp_nand_nl : STD_LOGIC;
  SIGNAL or_164_nl : STD_LOGIC;
  SIGNAL LOOP_OUT_LOOP_OUT_mul_nl : STD_LOGIC_VECTOR (17 DOWNTO 0);
  SIGNAL LOOP_OUT_mux1h_6_nl : STD_LOGIC_VECTOR (17 DOWNTO 0);
  SIGNAL and_105_nl : STD_LOGIC;
  SIGNAL LOOP_OUT_mux_10_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl : STD_LOGIC_VECTOR
      (4 DOWNTO 0);
  SIGNAL LOOP_CH_acc_2_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL LOOP_CH_acc_3_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL LOOP_VAR_mul_2_nl : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl
      : STD_LOGIC_VECTOR (35 DOWNTO 0);
  SIGNAL LOOP_OUT_acc_10_nl : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL num_elements_num_elements_or_1_nl : STD_LOGIC;
  SIGNAL num_elements_num_elements_and_3_nl : STD_LOGIC;
  SIGNAL num_elements_mux_2_nl : STD_LOGIC;
  SIGNAL num_elements_mux1h_6_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL num_elements_num_elements_and_4_nl : STD_LOGIC;
  SIGNAL num_elements_num_elements_and_5_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL num_elements_mux_3_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL not_150_nl : STD_LOGIC;
  SIGNAL num_elements_mux1h_7_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL LOOP_OUT_mux_18_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_a : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_b : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_z_1 : STD_LOGIC_VECTOR (21 DOWNTO 0);

  SIGNAL LOOP_OUT_div_5_cmp_1_a : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_1_b : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_1_z_1 : STD_LOGIC_VECTOR (21 DOWNTO 0);

  SIGNAL LOOP_OUT_div_5_cmp_2_a : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_2_b : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_2_z_1 : STD_LOGIC_VECTOR (21 DOWNTO 0);

  SIGNAL LOOP_OUT_div_5_cmp_3_a : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_3_b : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_3_z_1 : STD_LOGIC_VECTOR (21 DOWNTO 0);

  SIGNAL LOOP_OUT_div_5_cmp_4_a : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_4_b : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL LOOP_OUT_div_5_cmp_4_z_1 : STD_LOGIC_VECTOR (21 DOWNTO 0);

  SIGNAL operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_a : STD_LOGIC_VECTOR (24 DOWNTO
      0);
  SIGNAL operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_s : STD_LOGIC_VECTOR (4 DOWNTO
      0);
  SIGNAL operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_z : STD_LOGIC_VECTOR (31 DOWNTO
      0);

  SIGNAL LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_rg_addr : STD_LOGIC_VECTOR
      (9 DOWNTO 0);
  SIGNAL LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_rg_data_out : STD_LOGIC_VECTOR
      (4 DOWNTO 0);

  SIGNAL LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_rg_addr : STD_LOGIC_VECTOR
      (9 DOWNTO 0);
  SIGNAL LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_rg_data_out : STD_LOGIC_VECTOR
      (3 DOWNTO 0);

  COMPONENT leading_sign_22_0
    PORT (
      mantissa : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
      rtn : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL leading_sign_22_0_rg_mantissa : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL leading_sign_22_0_rg_rtn : STD_LOGIC_VECTOR (4 DOWNTO 0);

  SIGNAL operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_a : STD_LOGIC_VECTOR (20 DOWNTO
      0);
  SIGNAL operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_s : STD_LOGIC_VECTOR (4 DOWNTO
      0);
  SIGNAL operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_z : STD_LOGIC_VECTOR (20 DOWNTO
      0);

  COMPONENT UNET_IP_batchnorm_relu_run_batch_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      arst_n : IN STD_LOGIC;
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z : IN STD_LOGIC_VECTOR
          (33 DOWNTO 0);
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg : OUT STD_LOGIC_VECTOR
          (27 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL UNET_IP_batchnorm_relu_run_batch_wait_dp_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z
      : STD_LOGIC_VECTOR (33 DOWNTO 0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_wait_dp_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg
      : STD_LOGIC_VECTOR (27 DOWNTO 0);

  COMPONENT UNET_IP_batchnorm_relu_run_batch_run_batch_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      arst_n : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
      main_C_0_tr0 : IN STD_LOGIC;
      LOOP_MEAN_C_0_tr0 : IN STD_LOGIC;
      LOOP_CH_C_5_tr0 : IN STD_LOGIC;
      LOOP_VAR_C_3_tr0 : IN STD_LOGIC;
      LOOP_OUT_C_0_tr0 : IN STD_LOGIC;
      LOOP_CH_C_12_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_fsm_output : STD_LOGIC_VECTOR
      (20 DOWNTO 0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_CH_C_5_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_OUT_C_0_tr0 : STD_LOGIC;

  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

  FUNCTION MUX1HOT_s_1_4_2(input_3 : STD_LOGIC;
  input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
      tmp := sel(3);
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_12_3_2(input_2 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(11 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(11 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_12_4_2(input_3 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(11 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(11 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_18_5_2(input_4 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(4 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(17 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(17 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_18_6_2(input_5 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(17 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(5 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(17 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(17 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
      tmp := (OTHERS=>sel( 5));
      result := result or ( input_5 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_6_3_2(input_2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(5 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_7_3_2(input_2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(6 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(6 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX_s_1_2_2(input_0 : STD_LOGIC;
  input_1 : STD_LOGIC;
  sel : STD_LOGIC)
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_10_4_2(input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(1 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(9 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "00" =>
          result := input_0;
        WHEN "01" =>
          result := input_1;
        WHEN "10" =>
          result := input_2;
        WHEN others =>
          result := input_3;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_11_2_2(input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_12_2_2(input_0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(11 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_13_2_2(input_0 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(12 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_14_2_2(input_0 : STD_LOGIC_VECTOR(13 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(13 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(13 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_15_2_2(input_0 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(14 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_28_2_2(input_0 : STD_LOGIC_VECTOR(27 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(27 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(27 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_2_2_2(input_0 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(1 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_3_2_2(input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(2 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_5_2_2(input_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(4 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_6_4_2(input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(1 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "00" =>
          result := input_0;
        WHEN "01" =>
          result := input_1;
        WHEN "10" =>
          result := input_2;
        WHEN others =>
          result := input_3;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_8_2_2(input_0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(7 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  input_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_output_triosy_obj_ld_cse,
      lz => input_triosy_lz
    );
  output_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_output_triosy_obj_ld_cse,
      lz => output_triosy_lz
    );
  LOOP_OUT_div_5_cmp : work.mgc_comps.mgc_div
    GENERIC MAP(
      width_a => 22,
      width_b => 15,
      signd => 1
      )
    PORT MAP(
      a => LOOP_OUT_div_5_cmp_a,
      b => LOOP_OUT_div_5_cmp_b,
      z => LOOP_OUT_div_5_cmp_z_1
    );
  LOOP_OUT_div_5_cmp_a <= LOOP_OUT_div_5_cmp_a_21_6 & STD_LOGIC_VECTOR'( "000000");
  LOOP_OUT_div_5_cmp_b <= STD_LOGIC_VECTOR(UNSIGNED'( "0") & UNSIGNED(LOOP_OUT_div_5_cmp_b_13_0));
  LOOP_OUT_div_5_cmp_z <= LOOP_OUT_div_5_cmp_z_1;

  LOOP_OUT_div_5_cmp_1 : work.mgc_comps.mgc_div
    GENERIC MAP(
      width_a => 22,
      width_b => 15,
      signd => 1
      )
    PORT MAP(
      a => LOOP_OUT_div_5_cmp_1_a,
      b => LOOP_OUT_div_5_cmp_1_b,
      z => LOOP_OUT_div_5_cmp_1_z_1
    );
  LOOP_OUT_div_5_cmp_1_a <= LOOP_OUT_div_5_cmp_1_a_21_6 & STD_LOGIC_VECTOR'( "000000");
  LOOP_OUT_div_5_cmp_1_b <= STD_LOGIC_VECTOR(UNSIGNED'( "0") & UNSIGNED(LOOP_OUT_div_5_cmp_1_b_13_0));
  LOOP_OUT_div_5_cmp_1_z <= LOOP_OUT_div_5_cmp_1_z_1;

  LOOP_OUT_div_5_cmp_2 : work.mgc_comps.mgc_div
    GENERIC MAP(
      width_a => 22,
      width_b => 15,
      signd => 1
      )
    PORT MAP(
      a => LOOP_OUT_div_5_cmp_2_a,
      b => LOOP_OUT_div_5_cmp_2_b,
      z => LOOP_OUT_div_5_cmp_2_z_1
    );
  LOOP_OUT_div_5_cmp_2_a <= LOOP_OUT_div_5_cmp_2_a_21_6 & STD_LOGIC_VECTOR'( "000000");
  LOOP_OUT_div_5_cmp_2_b <= STD_LOGIC_VECTOR(UNSIGNED'( "0") & UNSIGNED(LOOP_OUT_div_5_cmp_2_b_13_0));
  LOOP_OUT_div_5_cmp_2_z <= LOOP_OUT_div_5_cmp_2_z_1;

  LOOP_OUT_div_5_cmp_3 : work.mgc_comps.mgc_div
    GENERIC MAP(
      width_a => 22,
      width_b => 15,
      signd => 1
      )
    PORT MAP(
      a => LOOP_OUT_div_5_cmp_3_a,
      b => LOOP_OUT_div_5_cmp_3_b,
      z => LOOP_OUT_div_5_cmp_3_z_1
    );
  LOOP_OUT_div_5_cmp_3_a <= LOOP_OUT_div_5_cmp_3_a_21_6 & STD_LOGIC_VECTOR'( "000000");
  LOOP_OUT_div_5_cmp_3_b <= STD_LOGIC_VECTOR(UNSIGNED'( "0") & UNSIGNED(LOOP_OUT_div_5_cmp_3_b_13_0));
  LOOP_OUT_div_5_cmp_3_z <= LOOP_OUT_div_5_cmp_3_z_1;

  LOOP_OUT_div_5_cmp_4 : work.mgc_comps.mgc_div
    GENERIC MAP(
      width_a => 22,
      width_b => 15,
      signd => 1
      )
    PORT MAP(
      a => LOOP_OUT_div_5_cmp_4_a,
      b => LOOP_OUT_div_5_cmp_4_b,
      z => LOOP_OUT_div_5_cmp_4_z_1
    );
  LOOP_OUT_div_5_cmp_4_a <= LOOP_OUT_div_5_cmp_4_a_21_6 & STD_LOGIC_VECTOR'( "000000");
  LOOP_OUT_div_5_cmp_4_b <= STD_LOGIC_VECTOR(UNSIGNED'( "0") & UNSIGNED(LOOP_OUT_div_5_cmp_4_b_13_0));
  LOOP_OUT_div_5_cmp_4_z <= LOOP_OUT_div_5_cmp_4_z_1;

  operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg : work.mgc_shift_comps_v5.mgc_shift_bl_v5
    GENERIC MAP(
      width_a => 25,
      signd_a => 0,
      width_s => 5,
      width_z => 32
      )
    PORT MAP(
      a => operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_a,
      s => operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_s,
      z => operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_z
    );
  operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_a <= (MUX_v_13_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1,
      (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1(24
      DOWNTO 12)), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2))
      & (MUX_v_11_2_2((LOOP_MEAN_mul_itm_1(10 DOWNTO 0)), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1(11
      DOWNTO 1)), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2))
      & ((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1(0))
      AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2);
  operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_s <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2;
  operator_32_8_false_AC_TRN_AC_WRAP_lshift_itm <= operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_z;

  LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_rg : work.unet_ip_batchnorm_relumgc_rom_11_736_5_1_pkg.UNET_IP_batchnorm_relumgc_rom_11_736_5_1
    PORT MAP(
      addr => LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_rg_addr,
      data_out => LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_rg_data_out
    );
  LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_rg_addr <= LOOP_OUT_acc_3_cse_sva_1;
  LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm <= LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_rg_data_out;

  LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_rg : work.unet_ip_batchnorm_relumgc_rom_12_736_4_1_pkg.UNET_IP_batchnorm_relumgc_rom_12_736_4_1
    PORT MAP(
      addr => LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_rg_addr,
      data_out => LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_rg_data_out
    );
  LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_rg_addr <= LOOP_OUT_acc_3_cse_sva_1;
  LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm <= LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_rg_data_out;

  leading_sign_22_0_rg : leading_sign_22_0
    PORT MAP(
      mantissa => leading_sign_22_0_rg_mantissa,
      rtn => leading_sign_22_0_rg_rtn
    );
  leading_sign_22_0_rg_mantissa <= '0' & LOOP_CH_var_21_1_sva;
  leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1 <= leading_sign_22_0_rg_rtn;

  operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg : work.mgc_shift_comps_v5.mgc_shift_l_v5
    GENERIC MAP(
      width_a => 21,
      signd_a => 0,
      width_s => 5,
      width_z => 21
      )
    PORT MAP(
      a => operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_a,
      s => operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_s,
      z => operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_z
    );
  operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_a <= LOOP_CH_var_21_1_sva;
  operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_s <= leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1;
  operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm <= operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg_z;

  UNET_IP_batchnorm_relu_run_batch_wait_dp_inst : UNET_IP_batchnorm_relu_run_batch_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      arst_n => arst_n,
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z => UNET_IP_batchnorm_relu_run_batch_wait_dp_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z,
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg => UNET_IP_batchnorm_relu_run_batch_wait_dp_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg
    );
  UNET_IP_batchnorm_relu_run_batch_wait_dp_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z
      <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z;
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg <= UNET_IP_batchnorm_relu_run_batch_wait_dp_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg;

  UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst : UNET_IP_batchnorm_relu_run_batch_run_batch_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      arst_n => arst_n,
      fsm_output => UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_fsm_output,
      main_C_0_tr0 => exit_LOOP_CH_sva_mx0,
      LOOP_MEAN_C_0_tr0 => nor_4_cse,
      LOOP_CH_C_5_tr0 => UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_CH_C_5_tr0,
      LOOP_VAR_C_3_tr0 => LOOP_MEAN_stage_0,
      LOOP_OUT_C_0_tr0 => UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_OUT_C_0_tr0,
      LOOP_CH_C_12_tr0 => exit_LOOP_CH_sva_mx0
    );
  fsm_output <= UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_fsm_output;
  UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_CH_C_5_tr0 <= NOT LOOP_MEAN_stage_0;
  UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_OUT_C_0_tr0 <= NOT(LOOP_OUT_stage_0
      OR LOOP_MEAN_stage_0_2 OR LOOP_MEAN_stage_0_3 OR LOOP_OUT_stage_0_4 OR LOOP_OUT_stage_0_5
      OR LOOP_OUT_stage_0_6 OR LOOP_OUT_stage_0_7 OR LOOP_OUT_stage_0_8 OR LOOP_OUT_stage_0_9
      OR LOOP_MEAN_stage_0);

  nor_4_cse <= NOT(LOOP_MEAN_stage_0_2 OR LOOP_MEAN_stage_0);
  or_123_ssc <= CONV_SL_1_1(fsm_output(5 DOWNTO 2)/=STD_LOGIC_VECTOR'("0000"));
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a <= reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd
      & reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 & reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2
      & STD_LOGIC_VECTOR'( "000000");
  LOOP_CH_c_or_cse <= (fsm_output(0)) OR (fsm_output(19));
  and_107_rgt <= and_dcpl_85 AND and_dcpl_94;
  and_108_rgt <= and_dcpl_87 AND and_dcpl_94;
  and_109_rgt <= and_dcpl_89 AND and_dcpl_94;
  and_110_rgt <= and_dcpl_91 AND and_dcpl_94;
  and_111_rgt <= and_dcpl_92 AND and_dcpl_94;
  nor_21_cse <= NOT((fsm_output(19)) OR (fsm_output(0)));
  or_159_cse <= (fsm_output(1)) OR (fsm_output(18));
  LOOP_CH_acc_2_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (NOT channels)) +
      SIGNED'( "00000001"), 8));
  LOOP_CH_acc_3_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & LOOP_CH_c_sva_2)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED('1' & (NOT channels)), 8), 9) + UNSIGNED'(
      "000000001"), 9));
  exit_LOOP_CH_sva_mx0 <= MUX_s_1_2_2((NOT (LOOP_CH_acc_2_nl(7))), (NOT (LOOP_CH_acc_3_nl(8))),
      fsm_output(19));
  LOOP_CH_c_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(LOOP_CH_c_sva(6
      DOWNTO 0)), 7), 8) + UNSIGNED'( "00000001"), 8));
  LOOP_VAR_mul_2_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED((LOOP_OUT_acc_5_itm_1(15))
      & LOOP_VAR_acc_4_cse_sva_14_12 & LOOP_VAR_acc_4_cse_sva_11_0) * SIGNED((LOOP_OUT_acc_5_itm_1(15))
      & LOOP_VAR_acc_4_cse_sva_14_12 & LOOP_VAR_acc_4_cse_sva_11_0)), 28));
  LOOP_CH_var_tmp_33_6_sva_mx0w1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(LOOP_CH_var_tmp_33_6_sva)
      + CONV_UNSIGNED(SIGNED(LOOP_VAR_mul_2_nl), 28), 28));
  LOOP_CH_i_1_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(LOOP_CH_i_1_sva) +
      UNSIGNED'( "0000000000001"), 13));
  LOOP_VAR_acc_4_cse_sva_mx0w1 <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED('1'
      & (NOT LOOP_CH_mean_sva)), 15), 16) + CONV_SIGNED(CONV_SIGNED(SIGNED(input_rsci_q_d
      & STD_LOGIC_VECTOR'( "00")), 14), 16) + SIGNED'( "0000000000000001"), 16));
  LOOP_CH_mean_tmp_19_8_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(LOOP_VAR_acc_4_cse_sva_11_0)
      + UNSIGNED(input_rsci_q_d), 12));
  or_cse <= CONV_SL_1_1(LOOP_OUT_LOOP_OUT_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00"));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1
      <= MUX_v_14_2_2(STD_LOGIC_VECTOR'("00000000000000"), ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1,
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3);
  LOOP_OUT_LOOP_OUT_acc_tmp <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(LOOP_OUT_acc_imod_1(2),
      1), 1), 3) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(LOOP_OUT_acc_imod_1(1 DOWNTO
      0)), 2), 3), 3));
  LOOP_VAR_mul_4 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(LOOP_CH_c_sva(6
      DOWNTO 0)) * UNSIGNED(num_elements_sva)), 15));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp
      <= CONV_SL_1_1(LOOP_CH_var_21_1_sva/=STD_LOGIC_VECTOR'("000000000000000000000"));
  LOOP_OUT_acc_imod_1 <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(LOOP_OUT_acc_idiv_1(2),
      1), 1), 3) + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(LOOP_OUT_acc_idiv_1(1 DOWNTO
      0)), 2), 3), 3));
  LOOP_OUT_acc_idiv_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(LOOP_OUT_div_5cyc)
      + UNSIGNED'( "001"), 3));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl
      <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED'( "1011010100001") *
      UNSIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
      & (LOOP_MEAN_mul_itm_1(10 DOWNTO 0)))), 36));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1
      <= ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl(35
      DOWNTO 11);
  LOOP_OUT_acc_3_cse_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(LOOP_CH_c_sva(6
      DOWNTO 0)), 7), 10) + UNSIGNED(offset), 10));
  LOOP_OUT_acc_10_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & LOOP_CH_i_1_sva)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(NOT num_elements_sva), 13), 14) + UNSIGNED'(
      "00000000000001"), 14));
  LOOP_OUT_acc_10_itm_13_1 <= LOOP_OUT_acc_10_nl(13);
  and_dcpl_45 <= LOOP_OUT_stage_0_4 AND (NOT exit_LOOP_OUT_sva_st_3);
  and_dcpl_46 <= and_dcpl_45 AND (NOT (LOOP_OUT_LOOP_OUT_acc_tmp(2)));
  and_dcpl_49 <= LOOP_OUT_stage_0_5 AND (NOT exit_LOOP_OUT_sva_st_4);
  and_dcpl_50 <= and_dcpl_49 AND (NOT (LOOP_OUT_div_5cyc_st_1(2)));
  or_dcpl_54 <= (NOT LOOP_OUT_stage_0_4) OR exit_LOOP_OUT_sva_st_3;
  or_dcpl_55 <= or_dcpl_54 OR (LOOP_OUT_LOOP_OUT_acc_tmp(2));
  or_dcpl_56 <= or_dcpl_55 OR CONV_SL_1_1(LOOP_OUT_LOOP_OUT_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("11"));
  or_dcpl_58 <= or_dcpl_55 OR CONV_SL_1_1(LOOP_OUT_LOOP_OUT_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("10"));
  or_dcpl_60 <= or_dcpl_55 OR CONV_SL_1_1(LOOP_OUT_LOOP_OUT_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("01"));
  and_dcpl_63 <= NOT(CONV_SL_1_1(LOOP_OUT_LOOP_OUT_acc_tmp(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_65 <= NOT(CONV_SL_1_1(LOOP_OUT_div_5cyc_st_1(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  or_dcpl_62 <= or_dcpl_55 OR or_cse;
  or_dcpl_64 <= or_dcpl_54 OR (NOT (LOOP_OUT_LOOP_OUT_acc_tmp(2))) OR or_cse;
  and_dcpl_77 <= LOOP_MEAN_stage_0_3 AND (NOT ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3);
  and_dcpl_79 <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_84 <= NOT(CONV_SL_1_1(LOOP_OUT_div_5cyc_st_5(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  and_dcpl_85 <= and_dcpl_84 AND (NOT (LOOP_OUT_div_5cyc_st_5(2)));
  and_dcpl_87 <= CONV_SL_1_1(LOOP_OUT_div_5cyc_st_5=STD_LOGIC_VECTOR'("001"));
  and_dcpl_89 <= CONV_SL_1_1(LOOP_OUT_div_5cyc_st_5=STD_LOGIC_VECTOR'("010"));
  and_dcpl_91 <= CONV_SL_1_1(LOOP_OUT_div_5cyc_st_5=STD_LOGIC_VECTOR'("011"));
  and_dcpl_92 <= and_dcpl_84 AND (LOOP_OUT_div_5cyc_st_5(2));
  and_dcpl_94 <= LOOP_OUT_stage_0_9 AND (NOT exit_LOOP_OUT_sva_st_8);
  LOOP_OUT_div_5_cmp_4_b_13_0_mx0c1 <= or_dcpl_56 AND and_dcpl_50 AND CONV_SL_1_1(LOOP_OUT_div_5cyc_st_1(1
      DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  LOOP_OUT_div_5_cmp_3_b_13_0_mx0c1 <= or_dcpl_58 AND and_dcpl_50 AND CONV_SL_1_1(LOOP_OUT_div_5cyc_st_1(1
      DOWNTO 0)=STD_LOGIC_VECTOR'("10"));
  LOOP_OUT_div_5_cmp_2_b_13_0_mx0c1 <= or_dcpl_60 AND and_dcpl_50 AND CONV_SL_1_1(LOOP_OUT_div_5cyc_st_1(1
      DOWNTO 0)=STD_LOGIC_VECTOR'("01"));
  LOOP_OUT_div_5_cmp_1_b_13_0_mx0c1 <= or_dcpl_62 AND and_dcpl_50 AND and_dcpl_65;
  LOOP_OUT_div_5_cmp_b_13_0_mx0c1 <= or_dcpl_64 AND and_dcpl_49 AND (LOOP_OUT_div_5cyc_st_1(2))
      AND and_dcpl_65;
  input_rsci_radr_d <= MUX_v_15_2_2(z_out_1, LOOP_VAR_acc_1_itm, fsm_output(9));
  input_rsci_re_d_pff <= (fsm_output(9)) OR (LOOP_MEAN_stage_0_2 AND (NOT LOOP_OUT_stage_0_4)
      AND (fsm_output(1))) OR (LOOP_MEAN_stage_0_2 AND (NOT exit_LOOP_OUT_sva_st_1)
      AND (fsm_output(18)));
  output_rsci_d_d <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0)
      + CONV_UNSIGNED(CONV_SIGNED(SIGNED(LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2),
      4), 12), 12));
  output_rsci_wadr_d <= reg_LOOP_CH_idx_14_0_sva_8_ftd & reg_LOOP_CH_idx_14_0_sva_8_ftd_1;
  output_rsci_we_d_pff <= LOOP_MEAN_stage_0 AND (NOT exit_LOOP_OUT_sva_st_9) AND
      (fsm_output(18));
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_4_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_4_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
      ELSIF ( ((and_dcpl_46 AND CONV_SL_1_1(LOOP_OUT_LOOP_OUT_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11")))
          OR LOOP_OUT_div_5_cmp_4_b_13_0_mx0c1) = '1' ) THEN
        LOOP_OUT_div_5_cmp_4_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
            mut_1_1_13_0, LOOP_OUT_div_5_cmp_4_b_13_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_4_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_4_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
      ELSIF ( or_dcpl_56 = '0' ) THEN
        LOOP_OUT_div_5_cmp_4_a_21_6 <= LOOP_OUT_acc_5_itm_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_3_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_3_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
      ELSIF ( ((and_dcpl_46 AND CONV_SL_1_1(LOOP_OUT_LOOP_OUT_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10")))
          OR LOOP_OUT_div_5_cmp_3_b_13_0_mx0c1) = '1' ) THEN
        LOOP_OUT_div_5_cmp_3_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
            mut_1_1_13_0, LOOP_OUT_div_5_cmp_3_b_13_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_3_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_3_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
      ELSIF ( or_dcpl_58 = '0' ) THEN
        LOOP_OUT_div_5_cmp_3_a_21_6 <= LOOP_OUT_acc_5_itm_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_2_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_2_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
      ELSIF ( ((and_dcpl_46 AND CONV_SL_1_1(LOOP_OUT_LOOP_OUT_acc_tmp(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01")))
          OR LOOP_OUT_div_5_cmp_2_b_13_0_mx0c1) = '1' ) THEN
        LOOP_OUT_div_5_cmp_2_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
            mut_1_1_13_0, LOOP_OUT_div_5_cmp_2_b_13_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_2_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_2_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
      ELSIF ( or_dcpl_60 = '0' ) THEN
        LOOP_OUT_div_5_cmp_2_a_21_6 <= LOOP_OUT_acc_5_itm_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_1_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_1_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
      ELSIF ( ((and_dcpl_46 AND and_dcpl_63) OR LOOP_OUT_div_5_cmp_1_b_13_0_mx0c1)
          = '1' ) THEN
        LOOP_OUT_div_5_cmp_1_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
            mut_1_1_13_0, LOOP_OUT_div_5_cmp_1_b_13_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_1_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_1_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
      ELSIF ( or_dcpl_62 = '0' ) THEN
        LOOP_OUT_div_5_cmp_1_a_21_6 <= LOOP_OUT_acc_5_itm_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_b_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
      ELSIF ( ((and_dcpl_45 AND (LOOP_OUT_LOOP_OUT_acc_tmp(2)) AND and_dcpl_63) OR
          LOOP_OUT_div_5_cmp_b_13_0_mx0c1) = '1' ) THEN
        LOOP_OUT_div_5_cmp_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
            mut_1_1_13_0, LOOP_OUT_div_5_cmp_b_13_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_5_cmp_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_5_cmp_a_21_6 <= STD_LOGIC_VECTOR'( "0000000000000000");
      ELSIF ( or_dcpl_64 = '0' ) THEN
        LOOP_OUT_div_5_cmp_a_21_6 <= LOOP_OUT_acc_5_itm_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      reg_output_triosy_obj_ld_cse <= '0';
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b <= STD_LOGIC_VECTOR'(
          "0000000000000");
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd <= STD_LOGIC_VECTOR'(
          "00000000000000");
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 <= STD_LOGIC_VECTOR'(
          "000000000000");
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2 <= STD_LOGIC_VECTOR'(
          "00");
      LOOP_MEAN_asn_6_itm_2 <= '0';
      LOOP_MEAN_stage_0_2 <= '0';
      LOOP_MEAN_stage_0_3 <= '0';
      LOOP_MEAN_mul_itm_1 <= STD_LOGIC_VECTOR'( "000000000000000");
      LOOP_MEAN_asn_3_itm_1 <= STD_LOGIC_VECTOR'( "0000000000000");
      LOOP_OUT_stage_0_4 <= '0';
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3
          <= '0';
      LOOP_VAR_acc_4_cse_sva_14_12 <= STD_LOGIC_VECTOR'( "000");
      LOOP_VAR_acc_4_cse_sva_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      LOOP_VAR_acc_1_itm <= STD_LOGIC_VECTOR'( "000000000000000");
      LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2 <= STD_LOGIC_VECTOR'(
          "0000");
      reg_LOOP_CH_idx_14_0_sva_8_ftd <= STD_LOGIC_VECTOR'( "000");
      reg_LOOP_CH_idx_14_0_sva_8_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
      exit_LOOP_OUT_sva_st_9 <= '0';
      LOOP_OUT_div_5cyc_st_5 <= STD_LOGIC_VECTOR'( "000");
      exit_LOOP_OUT_sva_st_8 <= '0';
      LOOP_OUT_div_5cyc_st_4 <= STD_LOGIC_VECTOR'( "000");
      exit_LOOP_OUT_sva_st_7 <= '0';
      LOOP_OUT_div_5cyc_st_3 <= STD_LOGIC_VECTOR'( "000");
      exit_LOOP_OUT_sva_st_6 <= '0';
      LOOP_OUT_div_5cyc_st_2 <= STD_LOGIC_VECTOR'( "000");
      exit_LOOP_OUT_sva_st_5 <= '0';
      mut_1_1_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
      LOOP_OUT_div_5cyc_st_1 <= STD_LOGIC_VECTOR'( "000");
      exit_LOOP_OUT_sva_st_4 <= '0';
      LOOP_OUT_acc_5_itm_1 <= STD_LOGIC_VECTOR'( "0000000000000000");
      LOOP_OUT_div_5cyc <= STD_LOGIC_VECTOR'( "000");
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1
          <= STD_LOGIC_VECTOR'( "00000000000000");
      exit_LOOP_OUT_sva_st_3 <= '0';
      exit_LOOP_OUT_sva_st_2 <= '0';
      LOOP_OUT_mul_itm_1 <= STD_LOGIC_VECTOR'( "000000000000000");
      exit_LOOP_OUT_sva_st_1 <= '0';
      LOOP_OUT_stage_0 <= '0';
      LOOP_OUT_stage_0_5 <= '0';
      LOOP_OUT_stage_0_6 <= '0';
      LOOP_OUT_stage_0_7 <= '0';
      LOOP_OUT_stage_0_8 <= '0';
      LOOP_OUT_stage_0_9 <= '0';
      LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1 <= STD_LOGIC_VECTOR'(
          "00000");
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
          <= STD_LOGIC_VECTOR'( "0000000000000");
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2 <=
          '0';
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2
          <= STD_LOGIC_VECTOR'( "00000");
      LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1 <= STD_LOGIC_VECTOR'(
          "0000");
      LOOP_CH_idx_14_0_sva_7_14_12 <= STD_LOGIC_VECTOR'( "000");
      LOOP_CH_idx_14_0_sva_7_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
          <= STD_LOGIC_VECTOR'( "0000000000");
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1
          <= STD_LOGIC_VECTOR'( "000000000000");
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1
          <= STD_LOGIC_VECTOR'( "000000");
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1
          <= '0';
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1
          <= STD_LOGIC_VECTOR'( "00000");
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1 <=
          '0';
      reg_LOOP_CH_idx_14_0_sva_6_ftd <= STD_LOGIC_VECTOR'( "000");
      reg_LOOP_CH_idx_14_0_sva_6_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
      LOOP_CH_idx_14_0_sva_5_14_12 <= STD_LOGIC_VECTOR'( "000");
      LOOP_CH_idx_14_0_sva_5_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      reg_LOOP_CH_idx_14_0_sva_4_ftd <= STD_LOGIC_VECTOR'( "000");
      reg_LOOP_CH_idx_14_0_sva_4_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
      LOOP_CH_idx_14_0_sva_3_14_12 <= STD_LOGIC_VECTOR'( "000");
      LOOP_CH_idx_14_0_sva_3_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      reg_LOOP_CH_idx_14_0_sva_2_ftd <= STD_LOGIC_VECTOR'( "000");
      reg_LOOP_CH_idx_14_0_sva_2_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_output_triosy_obj_ld_cse <= '0';
        operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b <= STD_LOGIC_VECTOR'(
            "0000000000000");
        reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd <= STD_LOGIC_VECTOR'(
            "00000000000000");
        reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 <= STD_LOGIC_VECTOR'(
            "000000000000");
        reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2 <= STD_LOGIC_VECTOR'(
            "00");
        LOOP_MEAN_asn_6_itm_2 <= '0';
        LOOP_MEAN_stage_0_2 <= '0';
        LOOP_MEAN_stage_0_3 <= '0';
        LOOP_MEAN_mul_itm_1 <= STD_LOGIC_VECTOR'( "000000000000000");
        LOOP_MEAN_asn_3_itm_1 <= STD_LOGIC_VECTOR'( "0000000000000");
        LOOP_OUT_stage_0_4 <= '0';
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3
            <= '0';
        LOOP_VAR_acc_4_cse_sva_14_12 <= STD_LOGIC_VECTOR'( "000");
        LOOP_VAR_acc_4_cse_sva_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
        LOOP_VAR_acc_1_itm <= STD_LOGIC_VECTOR'( "000000000000000");
        LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0 <= STD_LOGIC_VECTOR'(
            "000000000000");
        LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2 <= STD_LOGIC_VECTOR'(
            "0000");
        reg_LOOP_CH_idx_14_0_sva_8_ftd <= STD_LOGIC_VECTOR'( "000");
        reg_LOOP_CH_idx_14_0_sva_8_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
        exit_LOOP_OUT_sva_st_9 <= '0';
        LOOP_OUT_div_5cyc_st_5 <= STD_LOGIC_VECTOR'( "000");
        exit_LOOP_OUT_sva_st_8 <= '0';
        LOOP_OUT_div_5cyc_st_4 <= STD_LOGIC_VECTOR'( "000");
        exit_LOOP_OUT_sva_st_7 <= '0';
        LOOP_OUT_div_5cyc_st_3 <= STD_LOGIC_VECTOR'( "000");
        exit_LOOP_OUT_sva_st_6 <= '0';
        LOOP_OUT_div_5cyc_st_2 <= STD_LOGIC_VECTOR'( "000");
        exit_LOOP_OUT_sva_st_5 <= '0';
        mut_1_1_13_0 <= STD_LOGIC_VECTOR'( "00000000000000");
        LOOP_OUT_div_5cyc_st_1 <= STD_LOGIC_VECTOR'( "000");
        exit_LOOP_OUT_sva_st_4 <= '0';
        LOOP_OUT_acc_5_itm_1 <= STD_LOGIC_VECTOR'( "0000000000000000");
        LOOP_OUT_div_5cyc <= STD_LOGIC_VECTOR'( "000");
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1
            <= STD_LOGIC_VECTOR'( "00000000000000");
        exit_LOOP_OUT_sva_st_3 <= '0';
        exit_LOOP_OUT_sva_st_2 <= '0';
        LOOP_OUT_mul_itm_1 <= STD_LOGIC_VECTOR'( "000000000000000");
        exit_LOOP_OUT_sva_st_1 <= '0';
        LOOP_OUT_stage_0 <= '0';
        LOOP_OUT_stage_0_5 <= '0';
        LOOP_OUT_stage_0_6 <= '0';
        LOOP_OUT_stage_0_7 <= '0';
        LOOP_OUT_stage_0_8 <= '0';
        LOOP_OUT_stage_0_9 <= '0';
        LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1 <= STD_LOGIC_VECTOR'(
            "00000");
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
            <= STD_LOGIC_VECTOR'( "0000000000000");
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2 <=
            '0';
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2
            <= STD_LOGIC_VECTOR'( "00000");
        LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1 <= STD_LOGIC_VECTOR'(
            "0000");
        LOOP_CH_idx_14_0_sva_7_14_12 <= STD_LOGIC_VECTOR'( "000");
        LOOP_CH_idx_14_0_sva_7_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
            <= STD_LOGIC_VECTOR'( "0000000000");
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1
            <= STD_LOGIC_VECTOR'( "000000000000");
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1
            <= STD_LOGIC_VECTOR'( "000000");
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1
            <= '0';
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1
            <= STD_LOGIC_VECTOR'( "00000");
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1 <=
            '0';
        reg_LOOP_CH_idx_14_0_sva_6_ftd <= STD_LOGIC_VECTOR'( "000");
        reg_LOOP_CH_idx_14_0_sva_6_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
        LOOP_CH_idx_14_0_sva_5_14_12 <= STD_LOGIC_VECTOR'( "000");
        LOOP_CH_idx_14_0_sva_5_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
        reg_LOOP_CH_idx_14_0_sva_4_ftd <= STD_LOGIC_VECTOR'( "000");
        reg_LOOP_CH_idx_14_0_sva_4_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
        LOOP_CH_idx_14_0_sva_3_14_12 <= STD_LOGIC_VECTOR'( "000");
        LOOP_CH_idx_14_0_sva_3_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
        reg_LOOP_CH_idx_14_0_sva_2_ftd <= STD_LOGIC_VECTOR'( "000");
        reg_LOOP_CH_idx_14_0_sva_2_ftd_1 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSE
        reg_output_triosy_obj_ld_cse <= NOT(nor_21_cse OR (NOT exit_LOOP_CH_sva_mx0));
        operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b <= num_elements_sva;
        reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_nl
            AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(NOT (fsm_output(1)), 1),14))
            AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(NOT or_123_ssc, 1),14));
        reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 <= MUX1HOT_v_12_4_2(LOOP_VAR_acc_4_cse_sva_11_0,
            LOOP_CH_mean_tmp_19_8_sva_2, (LOOP_CH_var_tmp_33_6_sva(13 DOWNTO 2)),
            (LOOP_CH_var_tmp_33_6_sva_mx0w1(13 DOWNTO 2)), STD_LOGIC_VECTOR'( operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_1_nl
            & operator_20_8_false_AC_TRN_AC_WRAP_13_false_and_5_nl & operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_nl
            & (fsm_output(11))));
        reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2 <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_1_nl
            AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(NOT (fsm_output(1)), 1),2))
            AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(NOT or_123_ssc, 1),2));
        LOOP_MEAN_asn_6_itm_2 <= MUX_s_1_2_2(LOOP_OUT_stage_0_4, ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1,
            fsm_output(18));
        LOOP_MEAN_stage_0_2 <= LOOP_MEAN_mux_3_nl AND (NOT((fsm_output(17)) OR (fsm_output(19))
            OR (fsm_output(0))));
        LOOP_MEAN_stage_0_3 <= LOOP_MEAN_stage_0_2 AND or_159_cse;
        LOOP_MEAN_mul_itm_1 <= z_out(14 DOWNTO 0);
        LOOP_MEAN_asn_3_itm_1 <= LOOP_CH_i_1_sva;
        LOOP_OUT_stage_0_4 <= LOOP_OUT_mux_nl AND or_159_cse;
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3
            <= MUX_s_1_2_2(LOOP_OUT_stage_0_4, LOOP_MEAN_asn_6_itm_2, fsm_output(18));
        LOOP_VAR_acc_4_cse_sva_14_12 <= MUX_v_3_2_2((LOOP_VAR_acc_4_cse_sva_mx0w1(14
            DOWNTO 12)), (z_out_1(14 DOWNTO 12)), fsm_output(18));
        LOOP_VAR_acc_4_cse_sva_11_0 <= MUX1HOT_v_12_3_2(LOOP_CH_mean_tmp_LOOP_CH_mean_tmp_and_nl,
            (LOOP_VAR_acc_4_cse_sva_mx0w1(11 DOWNTO 0)), (z_out_1(11 DOWNTO 0)),
            STD_LOGIC_VECTOR'( or_164_nl & (fsm_output(10)) & (fsm_output(18))));
        LOOP_VAR_acc_1_itm <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(LOOP_VAR_mul_4)
            + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(LOOP_CH_i_1_sva), 13), 15), 15));
        LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0 <= LOOP_OUT_LOOP_OUT_mul_nl(17
            DOWNTO 6);
        LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2 <= LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1;
        reg_LOOP_CH_idx_14_0_sva_8_ftd <= LOOP_CH_idx_14_0_sva_7_14_12;
        reg_LOOP_CH_idx_14_0_sva_8_ftd_1 <= LOOP_CH_idx_14_0_sva_7_11_0;
        exit_LOOP_OUT_sva_st_9 <= exit_LOOP_OUT_sva_st_8;
        LOOP_OUT_div_5cyc_st_5 <= LOOP_OUT_div_5cyc_st_4;
        exit_LOOP_OUT_sva_st_8 <= exit_LOOP_OUT_sva_st_7;
        LOOP_OUT_div_5cyc_st_4 <= LOOP_OUT_div_5cyc_st_3;
        exit_LOOP_OUT_sva_st_7 <= exit_LOOP_OUT_sva_st_6;
        LOOP_OUT_div_5cyc_st_3 <= LOOP_OUT_div_5cyc_st_2;
        exit_LOOP_OUT_sva_st_6 <= exit_LOOP_OUT_sva_st_5;
        LOOP_OUT_div_5cyc_st_2 <= LOOP_OUT_div_5cyc_st_1;
        exit_LOOP_OUT_sva_st_5 <= exit_LOOP_OUT_sva_st_4;
        mut_1_1_13_0 <= ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1;
        LOOP_OUT_div_5cyc_st_1 <= LOOP_OUT_LOOP_OUT_acc_tmp;
        exit_LOOP_OUT_sva_st_4 <= exit_LOOP_OUT_sva_st_3;
        LOOP_OUT_acc_5_itm_1 <= LOOP_VAR_acc_4_cse_sva_mx0w1;
        LOOP_OUT_div_5cyc <= MUX_v_3_2_2(STD_LOGIC_VECTOR'("000"), LOOP_OUT_mux_10_nl,
            (fsm_output(18)));
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1
            <= operator_32_8_false_AC_TRN_AC_WRAP_lshift_itm(31 DOWNTO 18);
        exit_LOOP_OUT_sva_st_3 <= exit_LOOP_OUT_sva_st_2;
        exit_LOOP_OUT_sva_st_2 <= exit_LOOP_OUT_sva_st_1;
        LOOP_OUT_mul_itm_1 <= LOOP_VAR_mul_4;
        exit_LOOP_OUT_sva_st_1 <= NOT LOOP_OUT_acc_10_itm_13_1;
        LOOP_OUT_stage_0 <= NOT((NOT(LOOP_OUT_stage_0 AND LOOP_OUT_acc_10_itm_13_1))
            AND (fsm_output(18)));
        LOOP_OUT_stage_0_5 <= LOOP_OUT_stage_0_4 AND (fsm_output(18));
        LOOP_OUT_stage_0_6 <= LOOP_OUT_stage_0_5 AND (fsm_output(18));
        LOOP_OUT_stage_0_7 <= LOOP_OUT_stage_0_6 AND (fsm_output(18));
        LOOP_OUT_stage_0_8 <= LOOP_OUT_stage_0_7 AND (fsm_output(18));
        LOOP_OUT_stage_0_9 <= LOOP_OUT_stage_0_8 AND (fsm_output(18));
        LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1 <= LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm;
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
            <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(z_out(19
            DOWNTO 11)), 9), 13) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED('1' & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
            & '1'), 12), 13), 13));
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2 <=
            ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1;
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2
            <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1;
        LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1 <= LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm;
        LOOP_CH_idx_14_0_sva_7_14_12 <= reg_LOOP_CH_idx_14_0_sva_6_ftd;
        LOOP_CH_idx_14_0_sva_7_11_0 <= reg_LOOP_CH_idx_14_0_sva_6_ftd_1;
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
            <= MUX_v_10_4_2(STD_LOGIC_VECTOR'( "0110101001"), STD_LOGIC_VECTOR'(
            "1001010100"), STD_LOGIC_VECTOR'( "1011101110"), STD_LOGIC_VECTOR'( "1101111100"),
            operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm(20 DOWNTO 19));
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1
            <= operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm(18 DOWNTO 7);
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1
            <= MUX_v_6_4_2(STD_LOGIC_VECTOR'( "101011"), STD_LOGIC_VECTOR'( "011010"),
            STD_LOGIC_VECTOR'( "001110"), STD_LOGIC_VECTOR'( "000100"), operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm(20
            DOWNTO 19));
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1
            <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp;
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1
            <= MUX_v_5_2_2(STD_LOGIC_VECTOR'("00000"), STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl),
            5)), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp);
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1 <=
            (NOT (leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1(0))) AND
            ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp;
        reg_LOOP_CH_idx_14_0_sva_6_ftd <= LOOP_CH_idx_14_0_sva_5_14_12;
        reg_LOOP_CH_idx_14_0_sva_6_ftd_1 <= LOOP_CH_idx_14_0_sva_5_11_0;
        LOOP_CH_idx_14_0_sva_5_14_12 <= reg_LOOP_CH_idx_14_0_sva_4_ftd;
        LOOP_CH_idx_14_0_sva_5_11_0 <= reg_LOOP_CH_idx_14_0_sva_4_ftd_1;
        reg_LOOP_CH_idx_14_0_sva_4_ftd <= LOOP_CH_idx_14_0_sva_3_14_12;
        reg_LOOP_CH_idx_14_0_sva_4_ftd_1 <= LOOP_CH_idx_14_0_sva_3_11_0;
        LOOP_CH_idx_14_0_sva_3_14_12 <= reg_LOOP_CH_idx_14_0_sva_2_ftd;
        LOOP_CH_idx_14_0_sva_3_11_0 <= reg_LOOP_CH_idx_14_0_sva_2_ftd_1;
        reg_LOOP_CH_idx_14_0_sva_2_ftd <= LOOP_VAR_acc_4_cse_sva_14_12;
        reg_LOOP_CH_idx_14_0_sva_2_ftd_1 <= LOOP_VAR_acc_4_cse_sva_11_0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      num_elements_sva <= STD_LOGIC_VECTOR'( "0000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        num_elements_sva <= STD_LOGIC_VECTOR'( "0000000000000");
      ELSIF ( ((fsm_output(20)) OR (fsm_output(0))) = '1' ) THEN
        num_elements_sva <= z_out(12 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_CH_c_sva <= STD_LOGIC_VECTOR'( "00000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_CH_c_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( LOOP_CH_c_or_cse = '1' ) THEN
        LOOP_CH_c_sva <= MUX_v_8_2_2(STD_LOGIC_VECTOR'("00000000"), LOOP_CH_c_sva_2,
            (fsm_output(19)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_OUT_div_tmp_duc_17_0 <= STD_LOGIC_VECTOR'( "000000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_OUT_div_tmp_duc_17_0 <= STD_LOGIC_VECTOR'( "000000000000000000");
      ELSIF ( ((fsm_output(18)) AND (and_107_rgt OR and_108_rgt OR and_109_rgt OR
          and_110_rgt OR and_111_rgt)) = '1' ) THEN
        LOOP_OUT_div_tmp_duc_17_0 <= MUX1HOT_v_18_5_2((LOOP_OUT_div_5_cmp_1_z(17
            DOWNTO 0)), (LOOP_OUT_div_5_cmp_2_z(17 DOWNTO 0)), (LOOP_OUT_div_5_cmp_3_z(17
            DOWNTO 0)), (LOOP_OUT_div_5_cmp_4_z(17 DOWNTO 0)), (LOOP_OUT_div_5_cmp_z(17
            DOWNTO 0)), STD_LOGIC_VECTOR'( and_107_rgt & and_108_rgt & and_109_rgt
            & and_110_rgt & and_111_rgt));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_CH_var_tmp_33_6_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_CH_var_tmp_33_6_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000");
      ELSIF ( ((fsm_output(11)) OR LOOP_CH_c_or_cse) = '1' ) THEN
        LOOP_CH_var_tmp_33_6_sva <= MUX_v_28_2_2(STD_LOGIC_VECTOR'("0000000000000000000000000000"),
            LOOP_CH_var_tmp_33_6_sva_mx0w1, (fsm_output(11)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_MEAN_stage_0 <= '0';
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_MEAN_stage_0 <= '0';
      ELSIF ( (LOOP_CH_c_or_cse OR (fsm_output(1)) OR (fsm_output(2)) OR (fsm_output(8))
          OR (fsm_output(17)) OR (fsm_output(18))) = '1' ) THEN
        LOOP_MEAN_stage_0 <= NOT((NOT(LOOP_MEAN_mux1h_8_nl OR LOOP_CH_c_or_cse))
            OR (fsm_output(17)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_CH_i_1_sva <= STD_LOGIC_VECTOR'( "0000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_CH_i_1_sva <= STD_LOGIC_VECTOR'( "0000000000000");
      ELSIF ( (NOT(CONV_SL_1_1(fsm_output(11 DOWNTO 9)/=STD_LOGIC_VECTOR'("000"))))
          = '1' ) THEN
        LOOP_CH_i_1_sva <= MUX_v_13_2_2(STD_LOGIC_VECTOR'("0000000000000"), LOOP_CH_i_1_sva_2,
            nor_29_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_CH_mean_sva <= STD_LOGIC_VECTOR'( "00000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_CH_mean_sva <= STD_LOGIC_VECTOR'( "00000000000000");
      ELSIF ( (NOT((NOT((fsm_output(5)) OR (fsm_output(6)) OR (fsm_output(20))))
          AND and_dcpl_79 AND (NOT((fsm_output(2)) OR (fsm_output(7)) OR (fsm_output(1))))
          AND nor_21_cse)) = '1' ) THEN
        LOOP_CH_mean_sva <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg(13
            DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, arst_n)
  BEGIN
    IF ( arst_n = '0' ) THEN
      LOOP_CH_var_21_1_sva <= STD_LOGIC_VECTOR'( "000000000000000000000");
    ELSIF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        LOOP_CH_var_21_1_sva <= STD_LOGIC_VECTOR'( "000000000000000000000");
      ELSIF ( (fsm_output(18)) = '0' ) THEN
        LOOP_CH_var_21_1_sva <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg(27
            DOWNTO 7);
      END IF;
    END IF;
  END PROCESS;
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_nl <= MUX_v_14_2_2((LOOP_CH_var_tmp_33_6_sva(27
      DOWNTO 14)), (LOOP_CH_var_tmp_33_6_sva_mx0w1(27 DOWNTO 14)), fsm_output(11));
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_1_nl <= ((NOT and_dcpl_77) AND (fsm_output(1)))
      OR or_123_ssc;
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_and_5_nl <= and_dcpl_77 AND (fsm_output(1));
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_nl <= (fsm_output(7)) OR (fsm_output(15))
      OR (fsm_output(14)) OR (fsm_output(13)) OR (fsm_output(12));
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_1_nl <= MUX_v_2_2_2((LOOP_CH_var_tmp_33_6_sva(1
      DOWNTO 0)), (LOOP_CH_var_tmp_33_6_sva_mx0w1(1 DOWNTO 0)), fsm_output(11));
  LOOP_MEAN_mux_3_nl <= MUX_s_1_2_2(LOOP_MEAN_stage_0, LOOP_OUT_stage_0, fsm_output(18));
  LOOP_OUT_mux_nl <= MUX_s_1_2_2((NOT LOOP_OUT_acc_10_itm_13_1), LOOP_MEAN_stage_0_3,
      fsm_output(18));
  and_159_nl <= (nor_4_cse OR (NOT LOOP_MEAN_asn_6_itm_2)) AND and_dcpl_77 AND (fsm_output(1));
  LOOP_CH_mean_tmp_mux_1_nl <= MUX_v_12_2_2(LOOP_VAR_acc_4_cse_sva_11_0, LOOP_CH_mean_tmp_19_8_sva_2,
      and_159_nl);
  LOOP_CH_mean_tmp_nand_nl <= NOT(and_dcpl_79 AND CONV_SL_1_1(fsm_output(2 DOWNTO
      1)=STD_LOGIC_VECTOR'("00")));
  LOOP_CH_mean_tmp_LOOP_CH_mean_tmp_and_nl <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"),
      LOOP_CH_mean_tmp_mux_1_nl, LOOP_CH_mean_tmp_nand_nl);
  or_164_nl <= (fsm_output(4)) OR (fsm_output(3)) OR (fsm_output(2)) OR (fsm_output(1))
      OR (fsm_output(19)) OR (fsm_output(0));
  and_105_nl <= (CONV_SL_1_1(LOOP_OUT_div_5cyc_st_5(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")))
      AND (LOOP_OUT_div_5cyc_st_5(2));
  LOOP_OUT_mux1h_6_nl <= MUX1HOT_v_18_6_2((LOOP_OUT_div_5_cmp_1_z(17 DOWNTO 0)),
      (LOOP_OUT_div_5_cmp_2_z(17 DOWNTO 0)), (LOOP_OUT_div_5_cmp_3_z(17 DOWNTO 0)),
      (LOOP_OUT_div_5_cmp_4_z(17 DOWNTO 0)), (LOOP_OUT_div_5_cmp_z(17 DOWNTO 0)),
      LOOP_OUT_div_tmp_duc_17_0, STD_LOGIC_VECTOR'( and_dcpl_85 & and_dcpl_87 & and_dcpl_89
      & and_dcpl_91 & and_dcpl_92 & and_105_nl));
  LOOP_OUT_LOOP_OUT_mul_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(SIGNED'( CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1),
      5), 6) * SIGNED(LOOP_OUT_mux1h_6_nl)), 18));
  LOOP_OUT_mux_10_nl <= MUX_v_3_2_2(LOOP_OUT_LOOP_OUT_acc_tmp, LOOP_OUT_div_5cyc,
      or_dcpl_54);
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1'
      & (NOT (leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1(4 DOWNTO 1))))
      + UNSIGNED'( "01001"), 5));
  LOOP_OUT_LOOP_OUT_and_nl <= LOOP_MEAN_stage_0 AND LOOP_OUT_acc_10_itm_13_1;
  LOOP_VAR_acc_7_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & (NOT num_elements_sva))
      + UNSIGNED'( "00000000000001"), 14));
  LOOP_VAR_acc_8_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & LOOP_CH_i_1_sva_2)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(NOT num_elements_sva), 13), 14) + UNSIGNED'(
      "00000000000001"), 14));
  LOOP_MEAN_mux1h_8_nl <= MUX1HOT_s_1_4_2(LOOP_OUT_LOOP_OUT_and_nl, (LOOP_VAR_acc_7_nl(13)),
      (NOT (LOOP_VAR_acc_8_nl(13))), LOOP_OUT_stage_0_9, STD_LOGIC_VECTOR'( (fsm_output(1))
      & (fsm_output(2)) & (fsm_output(8)) & (fsm_output(18))));
  nor_29_nl <= NOT((fsm_output(17)) OR (fsm_output(7)) OR LOOP_CH_c_or_cse);
  num_elements_num_elements_or_1_nl <= ((LOOP_CH_c_sva(7)) AND (NOT (fsm_output(0))))
      OR (fsm_output(18));
  num_elements_mux_2_nl <= MUX_s_1_2_2((width(6)), (LOOP_CH_c_sva(6)), fsm_output(1));
  num_elements_num_elements_and_3_nl <= num_elements_mux_2_nl AND (NOT (fsm_output(18)));
  num_elements_mux1h_6_nl <= MUX1HOT_v_6_3_2((width(5 DOWNTO 0)), (LOOP_CH_c_sva(5
      DOWNTO 0)), ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1,
      STD_LOGIC_VECTOR'( (fsm_output(0)) & (fsm_output(1)) & (fsm_output(18))));
  num_elements_num_elements_and_4_nl <= (num_elements_sva(12)) AND (NOT((fsm_output(0))
      OR (fsm_output(18))));
  num_elements_mux_3_nl <= MUX_v_5_2_2((num_elements_sva(11 DOWNTO 7)), (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1(11
      DOWNTO 7)), fsm_output(18));
  not_150_nl <= NOT (fsm_output(0));
  num_elements_num_elements_and_5_nl <= MUX_v_5_2_2(STD_LOGIC_VECTOR'("00000"), num_elements_mux_3_nl,
      not_150_nl);
  num_elements_mux1h_7_nl <= MUX1HOT_v_7_3_2(height, (num_elements_sva(6 DOWNTO 0)),
      (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1(6
      DOWNTO 0)), STD_LOGIC_VECTOR'( (fsm_output(0)) & (fsm_output(1)) & (fsm_output(18))));
  z_out <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(num_elements_num_elements_or_1_nl
      & num_elements_num_elements_and_3_nl & num_elements_mux1h_6_nl) * UNSIGNED(num_elements_num_elements_and_4_nl
      & num_elements_num_elements_and_5_nl & num_elements_mux1h_7_nl)), 20));
  LOOP_OUT_mux_18_nl <= MUX_v_15_2_2(LOOP_OUT_mul_itm_1, LOOP_MEAN_mul_itm_1, fsm_output(1));
  z_out_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(LOOP_OUT_mux_18_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(LOOP_MEAN_asn_3_itm_1),
      13), 15), 15));
END v3;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_batchnorm_relu
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.mgc_io_sync_pkg_v2.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;


ENTITY UNET_IP_batchnorm_relu IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    arst_n : IN STD_LOGIC;
    input_rsc_radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    input_rsc_re : OUT STD_LOGIC;
    input_rsc_q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    input_rsc_clken : OUT STD_LOGIC;
    input_triosy_lz : OUT STD_LOGIC;
    output_rsc_wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    output_rsc_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    output_rsc_we : OUT STD_LOGIC;
    output_rsc_clken : OUT STD_LOGIC;
    output_triosy_lz : OUT STD_LOGIC;
    channels : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    height : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    width : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
    offset : IN STD_LOGIC_VECTOR (9 DOWNTO 0)
  );
END UNET_IP_batchnorm_relu;

ARCHITECTURE v3 OF UNET_IP_batchnorm_relu IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';

  -- Interconnect Declarations
  SIGNAL input_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL input_rsci_radr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL output_rsci_d_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL output_rsci_wadr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a : STD_LOGIC_VECTOR
      (33 DOWNTO 0);
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b : STD_LOGIC_VECTOR
      (12 DOWNTO 0);
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z : STD_LOGIC_VECTOR
      (33 DOWNTO 0);
  SIGNAL input_rsci_re_d_iff : STD_LOGIC;
  SIGNAL output_rsci_we_d_iff : STD_LOGIC;

  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_1 : STD_LOGIC_VECTOR
      (33 DOWNTO 0);
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b_1 : STD_LOGIC_VECTOR
      (12 DOWNTO 0);
  SIGNAL operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_1 : STD_LOGIC_VECTOR
      (33 DOWNTO 0);

  COMPONENT UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen
    PORT(
      clken : OUT STD_LOGIC;
      q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      clken_d : IN STD_LOGIC;
      q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
      re_d : IN STD_LOGIC;
      readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL input_rsci_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL input_rsci_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL input_rsci_q_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL input_rsci_radr_d_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);

  COMPONENT UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen
    PORT(
      clken : OUT STD_LOGIC;
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      clken_d : IN STD_LOGIC;
      d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
      we_d : IN STD_LOGIC;
      writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL output_rsci_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL output_rsci_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL output_rsci_d_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL output_rsci_wadr_d_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);

  COMPONENT UNET_IP_batchnorm_relu_run_batch
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      arst_n : IN STD_LOGIC;
      input_triosy_lz : OUT STD_LOGIC;
      output_triosy_lz : OUT STD_LOGIC;
      channels : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      height : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      width : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      offset : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      input_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      input_rsci_radr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      output_rsci_d_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      output_rsci_wadr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a : OUT STD_LOGIC_VECTOR
          (33 DOWNTO 0);
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b : OUT STD_LOGIC_VECTOR
          (12 DOWNTO 0);
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z : IN STD_LOGIC_VECTOR
          (33 DOWNTO 0);
      input_rsci_re_d_pff : OUT STD_LOGIC;
      output_rsci_we_d_pff : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_channels : STD_LOGIC_VECTOR (6 DOWNTO
      0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_height : STD_LOGIC_VECTOR (6 DOWNTO
      0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_width : STD_LOGIC_VECTOR (6 DOWNTO
      0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_offset : STD_LOGIC_VECTOR (9 DOWNTO
      0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_input_rsci_q_d : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_input_rsci_radr_d : STD_LOGIC_VECTOR
      (14 DOWNTO 0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_output_rsci_d_d : STD_LOGIC_VECTOR
      (11 DOWNTO 0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_output_rsci_wadr_d : STD_LOGIC_VECTOR
      (14 DOWNTO 0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a
      : STD_LOGIC_VECTOR (33 DOWNTO 0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b
      : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z
      : STD_LOGIC_VECTOR (33 DOWNTO 0);

BEGIN
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp : work.mgc_comps.mgc_div
    GENERIC MAP(
      width_a => 34,
      width_b => 13,
      signd => 0
      )
    PORT MAP(
      a => operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_1,
      b => operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b_1,
      z => operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_1
    );
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_1 <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a;
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b_1 <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b;
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_1;

  input_rsci : UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen
    PORT MAP(
      clken => input_rsc_clken,
      q => input_rsci_q,
      re => input_rsc_re,
      radr => input_rsci_radr,
      clken_d => '1',
      q_d => input_rsci_q_d_1,
      radr_d => input_rsci_radr_d_1,
      re_d => input_rsci_re_d_iff,
      readA_r_ram_ir_internal_RMASK_B_d => input_rsci_re_d_iff
    );
  input_rsci_q <= input_rsc_q;
  input_rsc_radr <= input_rsci_radr;
  input_rsci_q_d <= input_rsci_q_d_1;
  input_rsci_radr_d_1 <= input_rsci_radr_d;

  output_rsci : UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen
    PORT MAP(
      clken => output_rsc_clken,
      we => output_rsc_we,
      d => output_rsci_d,
      wadr => output_rsci_wadr,
      clken_d => '1',
      d_d => output_rsci_d_d_1,
      wadr_d => output_rsci_wadr_d_1,
      we_d => output_rsci_we_d_iff,
      writeA_w_ram_ir_internal_WMASK_B_d => output_rsci_we_d_iff
    );
  output_rsc_d <= output_rsci_d;
  output_rsc_wadr <= output_rsci_wadr;
  output_rsci_d_d_1 <= output_rsci_d_d;
  output_rsci_wadr_d_1 <= output_rsci_wadr_d;

  UNET_IP_batchnorm_relu_run_batch_inst : UNET_IP_batchnorm_relu_run_batch
    PORT MAP(
      clk => clk,
      rst => rst,
      arst_n => arst_n,
      input_triosy_lz => input_triosy_lz,
      output_triosy_lz => output_triosy_lz,
      channels => UNET_IP_batchnorm_relu_run_batch_inst_channels,
      height => UNET_IP_batchnorm_relu_run_batch_inst_height,
      width => UNET_IP_batchnorm_relu_run_batch_inst_width,
      offset => UNET_IP_batchnorm_relu_run_batch_inst_offset,
      input_rsci_q_d => UNET_IP_batchnorm_relu_run_batch_inst_input_rsci_q_d,
      input_rsci_radr_d => UNET_IP_batchnorm_relu_run_batch_inst_input_rsci_radr_d,
      output_rsci_d_d => UNET_IP_batchnorm_relu_run_batch_inst_output_rsci_d_d,
      output_rsci_wadr_d => UNET_IP_batchnorm_relu_run_batch_inst_output_rsci_wadr_d,
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a => UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a,
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b => UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b,
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z => UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z,
      input_rsci_re_d_pff => input_rsci_re_d_iff,
      output_rsci_we_d_pff => output_rsci_we_d_iff
    );
  UNET_IP_batchnorm_relu_run_batch_inst_channels <= channels;
  UNET_IP_batchnorm_relu_run_batch_inst_height <= height;
  UNET_IP_batchnorm_relu_run_batch_inst_width <= width;
  UNET_IP_batchnorm_relu_run_batch_inst_offset <= offset;
  UNET_IP_batchnorm_relu_run_batch_inst_input_rsci_q_d <= input_rsci_q_d;
  input_rsci_radr_d <= UNET_IP_batchnorm_relu_run_batch_inst_input_rsci_radr_d;
  output_rsci_d_d <= UNET_IP_batchnorm_relu_run_batch_inst_output_rsci_d_d;
  output_rsci_wadr_d <= UNET_IP_batchnorm_relu_run_batch_inst_output_rsci_wadr_d;
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a <= UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a;
  operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b <= UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b;
  UNET_IP_batchnorm_relu_run_batch_inst_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z
      <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z;

END v3;



