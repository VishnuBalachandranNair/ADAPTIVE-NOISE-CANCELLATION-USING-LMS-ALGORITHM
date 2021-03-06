library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Approx_multi is
  generic ( n : integer :=  16;m : integer :=  8 );
    port (A,B :in std_logic_vector (n-1 downto 0);
          y : out std_logic_vector ((2*n)-1 downto 0));
end Approx_multi;

architecture Behavioral of Approx_multi is

component mux_2 is
  generic ( m : integer :=  8 );
    port (A,B :in std_logic_vector (m-1 downto 0);
          sel:in std_logic;
          y : out std_logic_vector (m-1 downto 0));
end component;

component OR_n_m is
  generic ( n : integer :=  16;m : integer :=  8 );
     port (A :in std_logic_vector (n-1 downto m);
           y : out std_logic);
  end component;
  
  component mux_3 is
  generic ( n : integer :=  16;m : integer :=  8 );
    port (z:in std_logic_vector ((2*m)-1 downto 0);
          c,s:in std_logic;
          y : out std_logic_vector ((2*n)-1 downto 0));
   end component;
   
    
    component booth_8 is
        port(i1:in std_logic_vector(7 downto 0);
             i2:in std_logic_vector(7 downto 0);
              output:out std_logic_vector(15 downto 0)
              );
      end component;
   
   signal sel_A,sel_B,s,c:std_logic:='0';
   signal ab,bb:std_logic_vector(m-1 downto 0);
   signal z:std_logic_vector((2*m)-1 downto 0);
begin
  M1:Or_n_m port map(A(n-1 downto m),sel_A);
  M2:Or_n_m port map(B(n-1 downto m),sel_B);
  M3:mux_2 port map(A(m-1 downto 0),A(n-1 downto n-m),sel_A,ab);
  M4:mux_2 port map(B(m-1 downto 0),B(n-1 downto n-m),sel_B,bb);
  s<=sel_A xor sel_b;
  c<=sel_A and sel_b;
  M5:booth_8 port map(ab,bb,z);
  M6:mux_3 port map(z,c,s,y);
end;

