library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Incrementer is 

port(

PC_in,  IR , Z: in std_logic_vector( 15 downto 0);
WE : in std_logic;
PC_out : out std_logic_vector(15 downto 0)

);
end Incrementer;

architecture Incrementer_Arch of Incrementer is 

signal sel : std_logic_vector(1 downto 0 );

signal temp: std_logic_vector(15 downto 0);

begin
storage: process(PC_in,IR,Z,WE,sel,temp) is
begin

sel(0)<=  IR(15) and IR(14);
sel(1)<=  IR(15);

if(WE='1') then
case sel is

when "00" =>

temp <= std_logic_vector( to_unsigned(1+to_integer(unsigned(PC_in)), 16 )) ;

when "10" =>

temp <= std_logic_vector(to_unsigned( to_integer(unsigned(PC_in))+to_integer(signed(IR(8 downto 0))),16 )) ;

when "11" =>

if( Z="0000000000000000") then
temp <= std_logic_vector(to_unsigned( to_integer(unsigned(PC_in))+to_integer(signed(IR(5 downto 0))),16 )) ;
else
temp <= std_logic_vector(to_unsigned(1+to_integer(unsigned(PC_in)), 16 )) ;
end if;


when others =>
temp <= PC_in;


end case;
else temp <= PC_in;
end if;

PC_out <= temp;
end process storage;

end Incrementer_Arch;