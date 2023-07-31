
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Traffic.c,10 :: 		void interrupt()
;Traffic.c,12 :: 		if (intf_bit == 1) //flag is on when interrupt is done
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;Traffic.c,14 :: 		intf_bit =0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Traffic.c,17 :: 		}
L_interrupt0:
;Traffic.c,18 :: 		if (counter ==0) //first toggle
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt35
	MOVLW      0
	XORWF      _counter+0, 0
L__interrupt35:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;Traffic.c,20 :: 		ledredsouth =1;
	BSF        PORTD+0, 3
;Traffic.c,21 :: 		ledgreenwest = 1;
	BSF        PORTD+0, 2
;Traffic.c,23 :: 		}
L_interrupt1:
;Traffic.c,24 :: 		if (counter ==1) //second toggle
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt36
	MOVLW      1
	XORWF      _counter+0, 0
L__interrupt36:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;Traffic.c,26 :: 		ledredsouth =0;
	BCF        PORTD+0, 3
;Traffic.c,27 :: 		ledgreenwest = 0;
	BCF        PORTD+0, 2
;Traffic.c,28 :: 		ledyellowsouth =1;
	BSF        PORTD+0, 4
;Traffic.c,29 :: 		ledyellowwest =1;
	BSF        PORTD+0, 1
;Traffic.c,30 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_interrupt3:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt3
	DECFSZ     R12+0, 1
	GOTO       L_interrupt3
	DECFSZ     R11+0, 1
	GOTO       L_interrupt3
	NOP
;Traffic.c,31 :: 		ledyellowsouth =0;
	BCF        PORTD+0, 4
;Traffic.c,32 :: 		ledyellowwest =0;
	BCF        PORTD+0, 1
;Traffic.c,34 :: 		}
L_interrupt2:
;Traffic.c,35 :: 		if (counter ==2)  //third toggle
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt37
	MOVLW      2
	XORWF      _counter+0, 0
L__interrupt37:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;Traffic.c,37 :: 		ledredwest =1;
	BSF        PORTD+0, 0
;Traffic.c,38 :: 		ledgreensouth =1;
	BSF        PORTD+0, 5
;Traffic.c,40 :: 		}
L_interrupt4:
;Traffic.c,41 :: 		if (counter ==3)   //forth toggle
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt38
	MOVLW      3
	XORWF      _counter+0, 0
L__interrupt38:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
;Traffic.c,43 :: 		ledredwest =0;
	BCF        PORTD+0, 0
;Traffic.c,44 :: 		ledgreensouth =0;
	BCF        PORTD+0, 5
;Traffic.c,46 :: 		ledyellowsouth =1;
	BSF        PORTD+0, 4
;Traffic.c,47 :: 		ledyellowwest =1;
	BSF        PORTD+0, 1
;Traffic.c,49 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_interrupt6:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt6
	DECFSZ     R12+0, 1
	GOTO       L_interrupt6
	DECFSZ     R11+0, 1
	GOTO       L_interrupt6
	NOP
;Traffic.c,51 :: 		ledyellowsouth =0;
	BCF        PORTD+0, 4
;Traffic.c,52 :: 		ledyellowwest =0;
	BCF        PORTD+0, 1
;Traffic.c,53 :: 		}
L_interrupt5:
;Traffic.c,54 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Traffic.c,55 :: 		if (counter ==4)  //return to original after 4 toggles
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt39
	MOVLW      4
	XORWF      _counter+0, 0
L__interrupt39:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
;Traffic.c,57 :: 		counter =0;   //return the counter to original
	CLRF       _counter+0
	CLRF       _counter+1
;Traffic.c,58 :: 		}
L_interrupt7:
;Traffic.c,64 :: 		}
L_end_interrupt:
L__interrupt34:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Traffic.c,65 :: 		void main() {
;Traffic.c,66 :: 		adcon1 = 7;
	MOVLW      7
	MOVWF      ADCON1+0
;Traffic.c,68 :: 		trisd = 0;    //define leds port as outputs
	CLRF       TRISD+0
;Traffic.c,69 :: 		portd = 0;    //define leds are off at first
	CLRF       PORTD+0
;Traffic.c,71 :: 		trisc = 0;    //port c as output for 7 segments
	CLRF       TRISC+0
;Traffic.c,72 :: 		portc = 0;    // 7 segments shows 0 at the first
	CLRF       PORTC+0
;Traffic.c,74 :: 		trisb = 1;    //first pin of portb is input
	MOVLW      1
	MOVWF      TRISB+0
;Traffic.c,75 :: 		portb =255 ;  //portb is all 1's for turning on 7 segments
	MOVLW      255
	MOVWF      PORTB+0
;Traffic.c,77 :: 		trisa.B4 = 1;   //porta pin 4 is input
	BSF        TRISA+0, 4
;Traffic.c,78 :: 		porta.B4 = 1; //default value is 1 power is on
	BSF        PORTA+0, 4
;Traffic.c,80 :: 		inte_bit = 0;   //enable interrupt is disabled at first
	BCF        INTE_bit+0, BitPos(INTE_bit+0)
;Traffic.c,81 :: 		gie_bit = 0;    //gerneral interrupt is disabled
	BCF        GIE_bit+0, BitPos(GIE_bit+0)
;Traffic.c,82 :: 		INTEDG_bit = 0;  //inturrupt at falling edges
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;Traffic.c,83 :: 		loop:    //from this choosing the state (auto/manual)
___main_loop:
;Traffic.c,84 :: 		while(porta.B4 == 1)//when port RA4 is 1 (automatic)
L_main8:
	BTFSS      PORTA+0, 4
	GOTO       L_main9
;Traffic.c,86 :: 		inte_bit = 0;
	BCF        INTE_bit+0, BitPos(INTE_bit+0)
;Traffic.c,87 :: 		portb = 255;    //turn on all 7 segments
	MOVLW      255
	MOVWF      PORTB+0
;Traffic.c,88 :: 		portd = 0;      // leds are off at first
	CLRF       PORTD+0
;Traffic.c,89 :: 		for (i = 23 ; i>=0 ; i--) //23 sec for red south
	MOVLW      23
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main10:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main41
	MOVLW      0
	SUBWF      _i+0, 0
L__main41:
	BTFSS      STATUS+0, 0
	GOTO       L_main11
;Traffic.c,91 :: 		if (porta.B4 ==0) //if switch is changed
	BTFSC      PORTA+0, 4
	GOTO       L_main13
;Traffic.c,92 :: 		break;  //automatic changed to manual
	GOTO       L_main11
L_main13:
;Traffic.c,93 :: 		portc = segment[i];
	MOVF       _i+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic.c,94 :: 		if (i == 23)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main42
	MOVLW      23
	XORWF      _i+0, 0
L__main42:
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;Traffic.c,96 :: 		ledredsouth = 1;  //led on for 23 sec for red south
	BSF        PORTD+0, 3
;Traffic.c,97 :: 		ledgreenwest = 1; //green west has 20 sec from 23 sec
	BSF        PORTD+0, 2
;Traffic.c,98 :: 		}
L_main14:
;Traffic.c,100 :: 		if (i == 3)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main43
	MOVLW      3
	XORWF      _i+0, 0
L__main43:
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;Traffic.c,103 :: 		ledgreenwest = 0; //after 15 sec greenwest is off
	BCF        PORTD+0, 2
;Traffic.c,104 :: 		ledyellowwest =1;  //yellow is on
	BSF        PORTD+0, 1
;Traffic.c,105 :: 		}
L_main15:
;Traffic.c,106 :: 		if (i ==0)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVLW      0
	XORWF      _i+0, 0
L__main44:
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;Traffic.c,108 :: 		ledredsouth = 0;  //red south is off after 23 sec
	BCF        PORTD+0, 3
;Traffic.c,109 :: 		ledyellowsouth = 1;//yellowsouth is on
	BSF        PORTD+0, 4
;Traffic.c,110 :: 		ledyellowwest = 0;//same time yellow west is off
	BCF        PORTD+0, 1
;Traffic.c,111 :: 		ledgreenwest = 0; //same time green west is on
	BCF        PORTD+0, 2
;Traffic.c,112 :: 		ledredwest = 1;  //after 23 sec the redwest is on
	BSF        PORTD+0, 0
;Traffic.c,113 :: 		}
L_main16:
;Traffic.c,115 :: 		delay_ms(1000);//delay 1 second for 23 seconds
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
	NOP
;Traffic.c,89 :: 		for (i = 23 ; i>=0 ; i--) //23 sec for red south
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;Traffic.c,116 :: 		}
	GOTO       L_main10
L_main11:
;Traffic.c,117 :: 		for (j = 15 ; j>=0;j--) //15 sec for red west
	MOVLW      15
	MOVWF      _j+0
	MOVLW      0
	MOVWF      _j+1
L_main18:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVLW      0
	SUBWF      _j+0, 0
L__main45:
	BTFSS      STATUS+0, 0
	GOTO       L_main19
;Traffic.c,120 :: 		portc = segment[j];
	MOVF       _j+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic.c,121 :: 		if (porta.B4 ==0)
	BTFSC      PORTA+0, 4
	GOTO       L_main21
;Traffic.c,122 :: 		break;
	GOTO       L_main19
L_main21:
;Traffic.c,125 :: 		if (j ==12) //after 3 seconds from the period
	MOVLW      0
	XORWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVLW      12
	XORWF      _j+0, 0
L__main46:
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;Traffic.c,128 :: 		ledyellowsouth = 0;//after 3 sec yellowsouth is off
	BCF        PORTD+0, 4
;Traffic.c,129 :: 		ledgreensouth = 1; //same time greensouth is on
	BSF        PORTD+0, 5
;Traffic.c,133 :: 		}
L_main22:
;Traffic.c,135 :: 		if (j == 0) //15 seconds(redwest)12 seconds(greensouth)
	MOVLW      0
	XORWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main47
	MOVLW      0
	XORWF      _j+0, 0
L__main47:
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;Traffic.c,137 :: 		ledgreensouth = 0;//after 12 seconds greensouth off
	BCF        PORTD+0, 5
;Traffic.c,138 :: 		ledredwest = 0;  //red west is off after 15 sec
	BCF        PORTD+0, 0
;Traffic.c,140 :: 		ledyellowwest = 1; //after 15 sec for both of them
	BSF        PORTD+0, 1
;Traffic.c,141 :: 		ledyellowsouth = 1; //yellow leds is on for 3 sec
	BSF        PORTD+0, 4
;Traffic.c,142 :: 		for (enl = 3 ; enl>=0;enl--)
	MOVLW      3
	MOVWF      _enl+0
	MOVLW      0
	MOVWF      _enl+1
L_main24:
	MOVLW      128
	XORWF      _enl+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVLW      0
	SUBWF      _enl+0, 0
L__main48:
	BTFSS      STATUS+0, 0
	GOTO       L_main25
;Traffic.c,144 :: 		portc = segment[enl]; //3 sec on 7 segment
	MOVF       _enl+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic.c,145 :: 		if (enl == 0)       //after 3 sec
	MOVLW      0
	XORWF      _enl+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      0
	XORWF      _enl+0, 0
L__main49:
	BTFSS      STATUS+0, 2
	GOTO       L_main27
;Traffic.c,147 :: 		ledyellowwest = 0; //both yellow are off
	BCF        PORTD+0, 1
;Traffic.c,148 :: 		ledyellowsouth = 0;
	BCF        PORTD+0, 4
;Traffic.c,149 :: 		ledredsouth = 1; //return to first condition
	BSF        PORTD+0, 3
;Traffic.c,150 :: 		ledgreenwest = 1;
	BSF        PORTD+0, 2
;Traffic.c,151 :: 		}
L_main27:
;Traffic.c,152 :: 		delay_ms(1000); //delay for 3 sec yellow loop
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	DECFSZ     R11+0, 1
	GOTO       L_main28
	NOP
	NOP
;Traffic.c,142 :: 		for (enl = 3 ; enl>=0;enl--)
	MOVLW      1
	SUBWF      _enl+0, 1
	BTFSS      STATUS+0, 0
	DECF       _enl+1, 1
;Traffic.c,155 :: 		}
	GOTO       L_main24
L_main25:
;Traffic.c,156 :: 		portc = segment[23]; //7 segment to 23 sec again
	MOVF       _segment+23, 0
	MOVWF      PORTC+0
;Traffic.c,159 :: 		}
L_main23:
;Traffic.c,162 :: 		delay_ms(1000);  //delay of 15 seconds for loop
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	DECFSZ     R11+0, 1
	GOTO       L_main29
	NOP
	NOP
;Traffic.c,117 :: 		for (j = 15 ; j>=0;j--) //15 sec for red west
	MOVLW      1
	SUBWF      _j+0, 1
	BTFSS      STATUS+0, 0
	DECF       _j+1, 1
;Traffic.c,163 :: 		}
	GOTO       L_main18
L_main19:
;Traffic.c,165 :: 		}
	GOTO       L_main8
L_main9:
;Traffic.c,166 :: 		if (porta.B4 ==0) { //when port RA4 is 0 manual
	BTFSC      PORTA+0, 4
	GOTO       L_main30
;Traffic.c,167 :: 		portb = 0;       //7 segments are off
	CLRF       PORTB+0
;Traffic.c,168 :: 		portd = 0;        //leds are off
	CLRF       PORTD+0
;Traffic.c,169 :: 		inte_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;Traffic.c,170 :: 		gie_bit =1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Traffic.c,171 :: 		while(porta.B4 ==0); //hold until changing to auto again
L_main31:
	BTFSC      PORTA+0, 4
	GOTO       L_main32
	GOTO       L_main31
L_main32:
;Traffic.c,173 :: 		}
L_main30:
;Traffic.c,174 :: 		goto loop;  //return to loop label
	GOTO       ___main_loop
;Traffic.c,185 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
