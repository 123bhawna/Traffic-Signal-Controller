library ieee;
use ieee.std_logic_1164.all;

entity traffic_signal_controller IS

port ( CLK : in std_logic;
		 SENSOR1,SENSOR2,RSTN : in std_logic;
		 NR,NY,NG,SR,SY,SG,ER,EY,EG,WR,WY,WG : out std_logic);
end traffic_signal_controller;
		
ARCHITECTURE BEHAVE OF traffic_signal_controller IS 

TYPE STATE_TYPE IS(START_NORTH,north,STOP_NORTH,WEST_NEXT,START_WEST,WEST,STOP_WEST,NORTH_NEXT);
SIGNAL Q,QPLUS : STATE_TYPE;
SIGNAL COUNT_3_SEC : iNTEGER RANGE 0 to 5 :=0;
sIGNAL cOUNT_30_SEC : INTEGER RANGE 0 TO 31 :=0; 
SIGNAL TEMP : STD_logic_VECTOR(1 DOWNTO 0);

BEGIN
TEMP(0)<=sENSOR1;
TEMP(1)<=SENSOR2;



PROCESS(CLK,RSTN)
	BEGIN
	IF RSTN='0' THEN
		Q<=START_NORTH;
		
	
	ELSIF(clK'EVENT AND CLK='1') THEN
		Q<=QPLUS;
	
		IF COUNT_3_SEC>=3 THEN
		COUNT_3_SEC <= 0;
		
		ELSE
		COUNT_3_SEC <= COUNT_3_SEC+1;
		END IF;
		
		IF COUNT_30_SEC>=30 THEN
		COUNT_30_SEC <= 0;
		
		ELSE
		COUNT_30_SEC <= COUNT_30_SEC+1;
		END IF;
		
	
		END IF;
	END PROCESS;
	
	
PROCESS(Q,RSTN,COUNT_3_SEC,cOUNT_30_SEC)
	BEGIN
	
	CASE Q IS

	WHEN START_NORTH=>
	
		IF TEMP="01" THEN
			QPLUS<=START_WEST;
			
		ELSIF coUNT_3_SEC<3 THEN
			QPLUS<=START_NORTH;
		ELSE
			QPLUS<=NORTH;

		END IF;
		
		NR<='0'; 
		NY<='1';
		NG<='0'; 
		WR<='1';
		WY<='0';
		WG<='0';
		
		SR<='0'; 
		SY<='1';
		SG<='0'; 
		ER<='1';
		EY<='0';
		EG<='0';
		
	WHEN NORTH=>
	
		IF TEMP="01" THEN
			QPLUS<=START_WEST;

		ELSIF COUNT_30_SEC<30 THEN
			QPLUS<=NORTH;
		ELSE
			QPLUS<=STOP_NORTH;

		END IF;
		
		NR<='0'; 
		NY<='0';
		NG<='1'; 
		WR<='1';
		WY<='0';
		WG<='0';
		
		SR<='0'; 
		SY<='0';
		SG<='1'; 
		ER<='1';
		EY<='0';
		EG<='0';
		
		WHEN STOP_NORTH=>
	
		IF TEMP="10" THEN
			QPLUS<=START_NORTH;
			
		ELSIF COUNT_3_SEC<3 THEN
			QPLUS<=STOP_NORTH;
		ELSE
			QPLUS<=WEST_NEXT;

		END IF;
		
		NR<='0'; 
		NY<='1';
		NG<='0'; 
		WR<='1';
		WY<='0';
		WG<='0';
		
		SR<='0'; 
		SY<='1';
		SG<='0'; 
		ER<='1';
		EY<='0';
		EG<='0';
		
		
		WHEN WEST_NEXT=>
	
		IF TEMP="10" THEN
			QPLUS<=START_NORTH;
			
		ELSIF COUNT_3_SEC<3 THEN
			QPLUS<=WEST_NEXT;
		ELSE
			QPLUS<=START_WEST;

		END IF;
		
		NR<='1'; 
		NY<='0';
		NG<='0'; 
		WR<='1';
		WY<='0';
		WG<='0';
		
		SR<='1'; 
		SY<='0';
		SG<='0'; 
		ER<='1';
		EY<='0';
		EG<='0';
		
		WHEN START_WEST=>
	
		IF TEMP="10" THEN
			QPLUS<=START_NORTH;
			
		ELSIF COUNT_3_SEC<3 THEN
			QPLUS<=START_WEST;
		ELSE
			QPLUS<=WEST;
			
		END IF;
		
		NR<='1'; 
		NY<='0';
		NG<='0'; 
		WR<='0';
		WY<='1';
		WG<='0';
		
		SR<='1'; 
		SY<='0';
		SG<='0'; 
		ER<='0';
		EY<='1';
		EG<='0';
		
		WHEN WEST=>
	
		IF TEMP="10" THEN
			QPLUS<=START_NORTH;
			
		ELSIF COUNT_30_SEC<30 THEN
			QPLUS<=WEST;
		ELSE
			QPLUS<=STOP_WEST;

		END IF;
		
		NR<='1'; 
		NY<='0';
		NG<='0'; 
		WR<='0';
		WY<='0';
		WG<='1';
		
		SR<='1'; 
		SY<='0';
		SG<='0'; 
		ER<='0';
		EY<='0';
		EG<='1';
		
		WHEN STOP_WEST=>
		IF TEMP="10" THEN
			QPLUS<=START_NORTH;
			
		ELSIF COUNT_3_SEC<3 THEN
			QPLUS<=STOP_WEST;
		ELSE
			QPLUS<=NORTH_NEXT;

		END IF;
		
		NR<='1'; 
		NY<='0';
		NG<='0'; 
		WR<='0';
		WY<='1';
		WG<='0';
		
		
		SR<='1'; 
		SY<='0';
		SG<='0'; 
		ER<='0';
		EY<='1';
		EG<='0';
		
		
		WHEN NORTH_NEXT=>
	
		IF TEMP="10" THEN
			QPLUS<=START_NORTH;
			
		ELSIF COUNT_3_SEC<3 THEN
			QPLUS<=NORTH_NEXT;
		ELSE
			QPLUS<=START_NORTH;

		END IF;
		
		NR<='1'; 
		NY<='0';
		NG<='0'; 
		WR<='1';
		WY<='0';
		WG<='0';
		
		SR<='1'; 
		SY<='0';
		SG<='0'; 
		ER<='1';
		EY<='0';
		EG<='0';
		
		
		WHEN OTHERS =>
			QPLUS<=START_NORTH;

		NR<='0'; 
		NY<='1';
		NG<='0'; 
		WR<='1';
		WY<='0';
		WG<='0';
			
		SR<='0'; 
		SY<='1';
		SG<='0'; 
		ER<='1';
		EY<='0';
		EG<='0';
			
		END CASE;
	END PROCESS;
END BEHAVE;
