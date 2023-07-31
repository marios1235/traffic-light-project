#line 1 "C:/Users/mario/OneDrive/Desktop/Embedded/code/Traffic/Traffic.c"






char segment[] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22,0x23};
int counter=0;
int i,j,enl ;
void interrupt()
{
 if (intf_bit == 1)
 {
 intf_bit =0;


 }
if (counter ==0)
{
  portd.B3  =1;
  portd.B2  = 1;

}
if (counter ==1)
{
  portd.B3  =0;
  portd.B2  = 0;
  portd.B4  =1;
  portd.B1  =1;
 delay_ms(3000);
  portd.B4  =0;
  portd.B1  =0;

}
if (counter ==2)
{
  portd.B0  =1;
  portd.B5  =1;

}
if (counter ==3)
{
  portd.B0  =0;
  portd.B5  =0;

  portd.B4  =1;
  portd.B1  =1;

 delay_ms(3000);

  portd.B4  =0;
  portd.B1  =0;
}
counter++;
if (counter ==4)
{
 counter =0;
}





}
void main() {
adcon1 = 7;

trisd = 0;
portd = 0;

trisc = 0;
portc = 0;

trisb = 1;
portb =255 ;

trisa.B4 = 1;
porta.B4 = 1;

inte_bit = 0;
gie_bit = 0;
INTEDG_bit = 0;
loop:
while(porta.B4 == 1)
{
 inte_bit = 0;
 portb = 255;
 portd = 0;
 for (i = 23 ; i>=0 ; i--)
 {
 if (porta.B4 ==0)
 break;
 portc = segment[i];
 if (i == 23)
 {
  portd.B3  = 1;
  portd.B2  = 1;
 }

 if (i == 3)
 {

  portd.B2  = 0;
  portd.B1  =1;
 }
 if (i ==0)
 {
  portd.B3  = 0;
  portd.B4  = 1;
  portd.B1  = 0;
  portd.B2  = 0;
  portd.B0  = 1;
 }

 delay_ms(1000);
 }
 for (j = 15 ; j>=0;j--)
 {

 portc = segment[j];
 if (porta.B4 ==0)
 break;


 if (j ==12)
 {

  portd.B4  = 0;
  portd.B5  = 1;



 }

 if (j == 0)
 {
  portd.B5  = 0;
  portd.B0  = 0;

  portd.B1  = 1;
  portd.B4  = 1;
 for (enl = 3 ; enl>=0;enl--)
 {
 portc = segment[enl];
 if (enl == 0)
 {
  portd.B1  = 0;
  portd.B4  = 0;
  portd.B3  = 1;
  portd.B2  = 1;
 }
 delay_ms(1000);


 }
 portc = segment[23];


 }


 delay_ms(1000);
 }

}
if (porta.B4 ==0) {
 portb = 0;
 portd = 0;
 inte_bit = 1;
 gie_bit =1;
 while(porta.B4 ==0);

}
goto loop;










}
