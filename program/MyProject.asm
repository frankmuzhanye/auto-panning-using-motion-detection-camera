
_SpeedControl:

;MyProject.c,44 :: 		void SpeedControl(int speed){
;MyProject.c,46 :: 		for(count=0;count<=speed;count++){
	CLRF       SpeedControl_count_L0+0
	CLRF       SpeedControl_count_L0+1
L_SpeedControl0:
	MOVLW      128
	XORWF      FARG_SpeedControl_speed+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      SpeedControl_count_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SpeedControl36
	MOVF       SpeedControl_count_L0+0, 0
	SUBWF      FARG_SpeedControl_speed+0, 0
L__SpeedControl36:
	BTFSS      STATUS+0, 0
	GOTO       L_SpeedControl1
;MyProject.c,47 :: 		Delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_SpeedControl3:
	DECFSZ     R13+0, 1
	GOTO       L_SpeedControl3
	DECFSZ     R12+0, 1
	GOTO       L_SpeedControl3
	NOP
	NOP
;MyProject.c,49 :: 		IntToStr(speed,num);
	MOVF       FARG_SpeedControl_speed+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_SpeedControl_speed+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _num+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,50 :: 		Lcd_Out(1,14,num);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _num+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,46 :: 		for(count=0;count<=speed;count++){
	INCF       SpeedControl_count_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       SpeedControl_count_L0+1, 1
;MyProject.c,51 :: 		}
	GOTO       L_SpeedControl0
L_SpeedControl1:
;MyProject.c,52 :: 		}
L_end_SpeedControl:
	RETURN
; end of _SpeedControl

_LightControl:

;MyProject.c,54 :: 		void LightControl(){
;MyProject.c,57 :: 		if(position<=0){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _position+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LightControl38
	MOVF       _position+0, 0
	SUBLW      0
L__LightControl38:
	BTFSS      STATUS+0, 0
	GOTO       L_LightControl4
;MyProject.c,58 :: 		L1=1;
	BSF        PORTE+0, 0
;MyProject.c,59 :: 		}
L_LightControl4:
;MyProject.c,60 :: 		if(position>-45&&position<=45){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _position+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LightControl39
	MOVF       _position+0, 0
	SUBLW      211
L__LightControl39:
	BTFSC      STATUS+0, 0
	GOTO       L_LightControl7
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _position+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LightControl40
	MOVF       _position+0, 0
	SUBLW      45
L__LightControl40:
	BTFSS      STATUS+0, 0
	GOTO       L_LightControl7
L__LightControl34:
;MyProject.c,61 :: 		L2=1;
	BSF        PORTE+0, 1
;MyProject.c,62 :: 		}
L_LightControl7:
;MyProject.c,63 :: 		if(position>0){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _position+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LightControl41
	MOVF       _position+0, 0
	SUBLW      0
L__LightControl41:
	BTFSC      STATUS+0, 0
	GOTO       L_LightControl8
;MyProject.c,64 :: 		L3=1;
	BSF        PORTE+0, 2
;MyProject.c,65 :: 		}
L_LightControl8:
;MyProject.c,68 :: 		}
L_end_LightControl:
	RETURN
; end of _LightControl

_servoRotate:

;MyProject.c,69 :: 		void servoRotate(int angle){
;MyProject.c,71 :: 		for(position;position<angle;position++){
L_servoRotate9:
	MOVLW      128
	XORWF      _position+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_servoRotate_angle+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__servoRotate43
	MOVF       FARG_servoRotate_angle+0, 0
	SUBWF      _position+0, 0
L__servoRotate43:
	BTFSC      STATUS+0, 0
	GOTO       L_servoRotate10
;MyProject.c,72 :: 		CCPR2L = 31*position/45+187.5;               // (set duty cycle)
	MOVLW      31
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       _position+0, 0
	MOVWF      R4+0
	MOVF       _position+1, 0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      45
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      128
	MOVWF      R4+1
	MOVLW      59
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      CCPR2L+0
;MyProject.c,73 :: 		T2CON |= (1<<2)|(1<<1);              // enabling timer 2, prescalar 16
	MOVLW      6
	IORWF      T2CON+0, 1
;MyProject.c,74 :: 		SpeedControl(5-speed);
	MOVF       _speed+0, 0
	SUBLW      5
	MOVWF      FARG_SpeedControl_speed+0
	MOVF       _speed+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_SpeedControl_speed+1
	SUBWF      FARG_SpeedControl_speed+1, 1
	CALL       _SpeedControl+0
;MyProject.c,75 :: 		LightControl();
	CALL       _LightControl+0
;MyProject.c,77 :: 		IntToStr(position,num);
	MOVF       _position+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _position+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _num+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,78 :: 		Lcd_Out(1,14,num);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _num+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,71 :: 		for(position;position<angle;position++){
	INCF       _position+0, 1
	BTFSC      STATUS+0, 2
	INCF       _position+1, 1
;MyProject.c,79 :: 		}
	GOTO       L_servoRotate9
L_servoRotate10:
;MyProject.c,81 :: 		for(position;position>angle;position--){
L_servoRotate12:
	MOVLW      128
	XORWF      FARG_servoRotate_angle+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _position+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__servoRotate44
	MOVF       _position+0, 0
	SUBWF      FARG_servoRotate_angle+0, 0
L__servoRotate44:
	BTFSC      STATUS+0, 0
	GOTO       L_servoRotate13
;MyProject.c,82 :: 		CCPR2L =  31*position/45+187.5;              // (set duty cycle)
	MOVLW      31
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       _position+0, 0
	MOVWF      R4+0
	MOVF       _position+1, 0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      45
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      128
	MOVWF      R4+1
	MOVLW      59
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      CCPR2L+0
;MyProject.c,83 :: 		T2CON |= (1<<2)|(1<<1);              // enabling timer 2, prescalar 16
	MOVLW      6
	IORWF      T2CON+0, 1
;MyProject.c,84 :: 		SpeedControl(5-speed);
	MOVF       _speed+0, 0
	SUBLW      5
	MOVWF      FARG_SpeedControl_speed+0
	MOVF       _speed+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_SpeedControl_speed+1
	SUBWF      FARG_SpeedControl_speed+1, 1
	CALL       _SpeedControl+0
;MyProject.c,85 :: 		LightControl();
	CALL       _LightControl+0
;MyProject.c,87 :: 		IntToStr(position,num);
	MOVF       _position+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _position+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _num+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,88 :: 		Lcd_Out(1,14,num);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _num+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,81 :: 		for(position;position>angle;position--){
	MOVLW      1
	SUBWF      _position+0, 1
	BTFSS      STATUS+0, 0
	DECF       _position+1, 1
;MyProject.c,89 :: 		}
	GOTO       L_servoRotate12
L_servoRotate13:
;MyProject.c,92 :: 		}
L_end_servoRotate:
	RETURN
; end of _servoRotate

_pan:

;MyProject.c,94 :: 		void pan(int x){
;MyProject.c,97 :: 		switch(x){
	GOTO       L_pan15
;MyProject.c,98 :: 		case 0x0B:servoRotate(-90);servoRotate(0);break;
L_pan17:
	MOVLW      166
	MOVWF      FARG_servoRotate_angle+0
	MOVLW      255
	MOVWF      FARG_servoRotate_angle+1
	CALL       _servoRotate+0
	CLRF       FARG_servoRotate_angle+0
	CLRF       FARG_servoRotate_angle+1
	CALL       _servoRotate+0
	GOTO       L_pan16
;MyProject.c,99 :: 		case 0x0E:servoRotate(0);servoRotate(90);break;
L_pan18:
	CLRF       FARG_servoRotate_angle+0
	CLRF       FARG_servoRotate_angle+1
	CALL       _servoRotate+0
	MOVLW      90
	MOVWF      FARG_servoRotate_angle+0
	MOVLW      0
	MOVWF      FARG_servoRotate_angle+1
	CALL       _servoRotate+0
	GOTO       L_pan16
;MyProject.c,100 :: 		}}
L_pan15:
	MOVLW      0
	XORWF      FARG_pan_x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pan46
	MOVLW      11
	XORWF      FARG_pan_x+0, 0
L__pan46:
	BTFSC      STATUS+0, 2
	GOTO       L_pan17
	MOVLW      0
	XORWF      FARG_pan_x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pan47
	MOVLW      14
	XORWF      FARG_pan_x+0, 0
L__pan47:
	BTFSC      STATUS+0, 2
	GOTO       L_pan18
L_pan16:
L_end_pan:
	RETURN
; end of _pan

_WorkingMode:

;MyProject.c,102 :: 		void WorkingMode(){
;MyProject.c,103 :: 		speed=ADC_Read(RA0)*5/1023;
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVLW      5
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _speed+0
	MOVF       R0+1, 0
	MOVWF      _speed+1
;MyProject.c,104 :: 		IntToStr(speed,num);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _num+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,105 :: 		Lcd_Out(2,14,num);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _num+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,107 :: 		switch(PORTB/16){
	MOVF       PORTB+0, 0
	MOVWF      FLOC__WorkingMode+0
	RRF        FLOC__WorkingMode+0, 1
	BCF        FLOC__WorkingMode+0, 7
	RRF        FLOC__WorkingMode+0, 1
	BCF        FLOC__WorkingMode+0, 7
	RRF        FLOC__WorkingMode+0, 1
	BCF        FLOC__WorkingMode+0, 7
	RRF        FLOC__WorkingMode+0, 1
	BCF        FLOC__WorkingMode+0, 7
	GOTO       L_WorkingMode19
;MyProject.c,109 :: 		case 0x09:servoRotate(-90);break;
L_WorkingMode21:
	MOVLW      166
	MOVWF      FARG_servoRotate_angle+0
	MOVLW      255
	MOVWF      FARG_servoRotate_angle+1
	CALL       _servoRotate+0
	GOTO       L_WorkingMode20
;MyProject.c,110 :: 		case 0x0A:servoRotate(0);break;
L_WorkingMode22:
	CLRF       FARG_servoRotate_angle+0
	CLRF       FARG_servoRotate_angle+1
	CALL       _servoRotate+0
	GOTO       L_WorkingMode20
;MyProject.c,111 :: 		case 0x0C:servoRotate(90);break;
L_WorkingMode23:
	MOVLW      90
	MOVWF      FARG_servoRotate_angle+0
	MOVLW      0
	MOVWF      FARG_servoRotate_angle+1
	CALL       _servoRotate+0
	GOTO       L_WorkingMode20
;MyProject.c,112 :: 		case 0x0F:pan(0x0B);pan(0x0E);break;
L_WorkingMode24:
	MOVLW      11
	MOVWF      FARG_pan_x+0
	MOVLW      0
	MOVWF      FARG_pan_x+1
	CALL       _pan+0
	MOVLW      14
	MOVWF      FARG_pan_x+0
	MOVLW      0
	MOVWF      FARG_pan_x+1
	CALL       _pan+0
	GOTO       L_WorkingMode20
;MyProject.c,113 :: 		case 0x0D:pan(0x0B);pan(0x0E);break;
L_WorkingMode25:
	MOVLW      11
	MOVWF      FARG_pan_x+0
	MOVLW      0
	MOVWF      FARG_pan_x+1
	CALL       _pan+0
	MOVLW      14
	MOVWF      FARG_pan_x+0
	MOVLW      0
	MOVWF      FARG_pan_x+1
	CALL       _pan+0
	GOTO       L_WorkingMode20
;MyProject.c,115 :: 		default:pan(PORTB/16);
L_WorkingMode26:
	MOVLW      4
	MOVWF      R0+0
	MOVF       PORTB+0, 0
	MOVWF      FARG_pan_x+0
	CLRF       FARG_pan_x+1
	MOVF       R0+0, 0
L__WorkingMode49:
	BTFSC      STATUS+0, 2
	GOTO       L__WorkingMode50
	RRF        FARG_pan_x+0, 1
	BCF        FARG_pan_x+0, 7
	ADDLW      255
	GOTO       L__WorkingMode49
L__WorkingMode50:
	MOVLW      0
	MOVWF      FARG_pan_x+1
	CALL       _pan+0
;MyProject.c,116 :: 		break;}
	GOTO       L_WorkingMode20
L_WorkingMode19:
	MOVF       FLOC__WorkingMode+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_WorkingMode21
	MOVF       FLOC__WorkingMode+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_WorkingMode22
	MOVF       FLOC__WorkingMode+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_WorkingMode23
	MOVF       FLOC__WorkingMode+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_WorkingMode24
	MOVF       FLOC__WorkingMode+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_WorkingMode25
	GOTO       L_WorkingMode26
L_WorkingMode20:
;MyProject.c,117 :: 		}
L_end_WorkingMode:
	RETURN
; end of _WorkingMode

_IdleMode:

;MyProject.c,119 :: 		void IdleMode(){
;MyProject.c,121 :: 		i=ADC_Read(RA0)*50/1023;
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVLW      50
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _i+0
	MOVF       R0+1, 0
	MOVWF      _i+1
;MyProject.c,122 :: 		angle=(i)*180/50-90;
	MOVLW      180
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      50
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVLW      90
	SUBWF      R0+0, 0
	MOVWF      FARG_servoRotate_angle+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      FARG_servoRotate_angle+1
;MyProject.c,123 :: 		servoRotate(angle);
	CALL       _servoRotate+0
;MyProject.c,124 :: 		}
L_end_IdleMode:
	RETURN
; end of _IdleMode

_main:

;MyProject.c,126 :: 		void main(void){
;MyProject.c,127 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,128 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,129 :: 		Lcd_Out(1,1,"Hello and Welcome");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,130 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	DECFSZ     R11+0, 1
	GOTO       L_main27
	NOP
	NOP
;MyProject.c,131 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,132 :: 		TRISC.RC1 = 0;
	BCF        TRISC+0, 1
;MyProject.c,133 :: 		TRISA=0x0f;
	MOVLW      15
	MOVWF      TRISA+0
;MyProject.c,135 :: 		TRISE=0;
	CLRF       TRISE+0
;MyProject.c,138 :: 		CCP2CON |= (1<<2)|(1<<3);            //  select for PWM mode
	MOVLW      12
	IORWF      CCP2CON+0, 1
;MyProject.c,139 :: 		T2CON |= (1<<2)|(1<<1);              // enabling timer 2, prescalar 16
	MOVLW      6
	IORWF      T2CON+0, 1
;MyProject.c,141 :: 		Lcd_Out(1,1,"Position");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,142 :: 		Lcd_Out(2,1,"Speed");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,144 :: 		RA_Dir=0;RB_Dir=0;RC_Dir=0;
	BCF        TRISD+0, 0
	BCF        TRISD+0, 1
	BCF        TRISC+0, 3
;MyProject.c,148 :: 		RA=0;RC=0;RC=0;
	BCF        PORTD+0, 0
	BCF        PORTC+0, 3
	BCF        PORTC+0, 3
;MyProject.c,152 :: 		InterruptInit();
	CALL       _InterruptInit+0
;MyProject.c,155 :: 		while(1)
L_main28:
;MyProject.c,161 :: 		if(flag_mode==1){
	MOVF       _flag_mode+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main30
;MyProject.c,162 :: 		WorkingMode();   }
	CALL       _WorkingMode+0
	GOTO       L_main31
L_main30:
;MyProject.c,166 :: 		IdleMode();
	CALL       _IdleMode+0
;MyProject.c,167 :: 		}
L_main31:
;MyProject.c,169 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
	NOP
;MyProject.c,170 :: 		}
	GOTO       L_main28
;MyProject.c,171 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,173 :: 		void interrupt(void){
;MyProject.c,174 :: 		if(INTCON.RBIF == 1)
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt33
;MyProject.c,177 :: 		INTCON.RBIE = 0;
	BCF        INTCON+0, 3
;MyProject.c,179 :: 		RA = PORTB.B4;
	BTFSC      PORTB+0, 4
	GOTO       L__interrupt55
	BCF        PORTD+0, 0
	GOTO       L__interrupt56
L__interrupt55:
	BSF        PORTD+0, 0
L__interrupt56:
;MyProject.c,180 :: 		RB = PORTB.B5;
	BTFSC      PORTB+0, 5
	GOTO       L__interrupt57
	BCF        PORTD+0, 1
	GOTO       L__interrupt58
L__interrupt57:
	BSF        PORTD+0, 1
L__interrupt58:
;MyProject.c,181 :: 		RC = PORTB.B6;
	BTFSC      PORTB+0, 6
	GOTO       L__interrupt59
	BCF        PORTC+0, 3
	GOTO       L__interrupt60
L__interrupt59:
	BSF        PORTC+0, 3
L__interrupt60:
;MyProject.c,182 :: 		flag_mode = PORTB.B7;
	MOVLW      0
	BTFSC      PORTB+0, 7
	MOVLW      1
	MOVWF      _flag_mode+0
;MyProject.c,187 :: 		INTCON.RBIF = 0;
	BCF        INTCON+0, 0
;MyProject.c,189 :: 		INTCON.RBIE = 1;
	BSF        INTCON+0, 3
;MyProject.c,191 :: 		}
L_interrupt33:
;MyProject.c,194 :: 		}
L_end_interrupt:
L__interrupt54:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_InterruptInit:

;MyProject.c,195 :: 		void InterruptInit(void){
;MyProject.c,197 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;MyProject.c,199 :: 		INTCON.PEIE = 0;
	BCF        INTCON+0, 6
;MyProject.c,201 :: 		INTCON.RBIE = 1;
	BSF        INTCON+0, 3
;MyProject.c,203 :: 		INTCON.RBIF = 0;
	BCF        INTCON+0, 0
;MyProject.c,208 :: 		}
L_end_InterruptInit:
	RETURN
; end of _InterruptInit
