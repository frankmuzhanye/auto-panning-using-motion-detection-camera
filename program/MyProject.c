// demonstrate status on portd b7:4
sbit RA_Dir at TRISD.B0;
sbit RB_Dir at TRISD.B1;
sbit RC_Dir at TRISC.B3;
sbit RA at PORTD.B0;
sbit RB at PORTD.B1;
sbit RC at PORTC.B3;

sbit L1 at PORTE.B0;
sbit L2 at PORTE.B1;
sbit L3 at PORTE.B2;

sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;


void InterruptInit(void);
void servoRotate(int);
void LightControl(void);
void SpeedControl(int);
void pan(int);
void WorkingMode(void);
void IdleMode(void);

// global variables
 int i;
 int position=-90;
 char num[16];
 int speed=5;
 unsigned short flag_mode=0;


 void SpeedControl(int speed){
 int count;
 for(count=0;count<=speed;count++){
 Delay_ms(1);
 ////position=angle;
IntToStr(speed,num);
Lcd_Out(1,14,num);
 }
 }

void LightControl(){


if(position<=0){
L1=1;
}
if(position>-45&&position<=45){
L2=1;
}
if(position>0){
L3=1;
}


}
void servoRotate(int angle){

for(position;position<angle;position++){
CCPR2L = 31*position/45+187.5;               // (set duty cycle)
T2CON |= (1<<2)|(1<<1);              // enabling timer 2, prescalar 16
SpeedControl(5-speed);
LightControl();
////position=angle;
IntToStr(position,num);
Lcd_Out(1,14,num);
}

for(position;position>angle;position--){
CCPR2L =  31*position/45+187.5;              // (set duty cycle)
T2CON |= (1<<2)|(1<<1);              // enabling timer 2, prescalar 16
SpeedControl(5-speed);
LightControl();
////position=angle;
IntToStr(position,num);
Lcd_Out(1,14,num);
}


}

void pan(int x){
int initial;
int limit;
switch(x){
case 0x0B:servoRotate(-90);servoRotate(0);break;
case 0x0E:servoRotate(0);servoRotate(90);break;
}}

void WorkingMode(){
    speed=ADC_Read(RA0)*5/1023;
    IntToStr(speed,num);
    Lcd_Out(2,14,num);

switch(PORTB/16){

  case 0x09:servoRotate(-90);break;
  case 0x0A:servoRotate(0);break;
  case 0x0C:servoRotate(90);break;
  case 0x0F:pan(0x0B);pan(0x0E);break;
  case 0x0D:pan(0x0B);pan(0x0E);break;

  default:pan(PORTB/16);
  break;}
  }

void IdleMode(){
int angle;
i=ADC_Read(RA0)*50/1023;
angle=(i)*180/50-90;
servoRotate(angle);
}

void main(void){
Lcd_Init();
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_Out(1,1,"Hello and Welcome");
Delay_ms(1000);
Lcd_Cmd(_LCD_CLEAR);
TRISC.RC1 = 0;
TRISA=0x0f;
// make portd as output
TRISE=0;


CCP2CON |= (1<<2)|(1<<3);            //  select for PWM mode
T2CON |= (1<<2)|(1<<1);              // enabling timer 2, prescalar 16

Lcd_Out(1,1,"Position");
Lcd_Out(2,1,"Speed");

RA_Dir=0;RB_Dir=0;RC_Dir=0;
//LightControl Option

// portd init to zero
RA=0;RC=0;RC=0;
//PORTB.BO init

// interrupt enable and init
InterruptInit();


while(1)
{
// best approach to use interrupt flag in
// continous loop, to avoid ISR overloading
// because its optimized to stay minimum time
// in interrupt service routine
if(flag_mode==1){
WorkingMode();   }

else{

IdleMode();
}

Delay_ms(100);
  }
}

void interrupt(void){
if(INTCON.RBIF == 1)
{
// RB Port Change Interrupt Disable
INTCON.RBIE = 0;
//read RB4to7 status and update according flags
RA = PORTB.B4;
RB = PORTB.B5;
RC = PORTB.B6;
flag_mode = PORTB.B7;



// must be clear flag
INTCON.RBIF = 0;
// RB Port Change Interrupt Enable
INTCON.RBIE = 1;

}


}
void InterruptInit(void){
// Global Interrupt Enable
INTCON.GIE = 1;
// RB Port Change Interrupt Enable
INTCON.PEIE = 0;
// RB Port Change Interrupt Enable
INTCON.RBIE = 1;
// RB Port Change Interrupt Flag
INTCON.RBIF = 0;
// Interrupt Edge Select bit
// 1 = rising edge
// 0 = falling edge
//OPTION_REG.INTEDG = 0;
}