#define ledredwest portd.B0
#define ledyellowwest portd.B1
#define ledgreenwest portd.B2
#define ledredsouth portd.B3
#define ledyellowsouth portd.B4
#define ledgreensouth portd.B5
char segment[] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22,0x23};
int counter=0;
int i,j,enl ;
void interrupt()
{
   if (intf_bit == 1) //flag is on when interrupt is done
   {
      intf_bit =0;
      
      
   }
if (counter ==0) //first toggle
{
   ledredsouth =1;
   ledgreenwest = 1;

}
if (counter ==1) //second toggle
{
    ledredsouth =0;
    ledgreenwest = 0;
    ledyellowsouth =1;
    ledyellowwest =1;
    delay_ms(3000);
    ledyellowsouth =0;
    ledyellowwest =0;

}
if (counter ==2)  //third toggle
{
   ledredwest =1;
   ledgreensouth =1;

}
if (counter ==3)   //forth toggle
{
   ledredwest =0;
   ledgreensouth =0;
   
   ledyellowsouth =1;
    ledyellowwest =1;
    
    delay_ms(3000);
    
    ledyellowsouth =0;
    ledyellowwest =0;
}
counter++;
if (counter ==4)  //return to original after 4 toggles
{
    counter =0;   //return the counter to original
}





}
void main() {
adcon1 = 7;

trisd = 0;    //define leds port as outputs
portd = 0;    //define leds are off at first

trisc = 0;    //port c as output for 7 segments
portc = 0;    // 7 segments shows 0 at the first

trisb = 1;    //first pin of portb is input
portb =255 ;  //portb is all 1's for turning on 7 segments

trisa.B4 = 1;   //porta pin 4 is input
porta.B4 = 1; //default value is 1 power is on

inte_bit = 0;   //enable interrupt is disabled at first
gie_bit = 0;    //gerneral interrupt is disabled
INTEDG_bit = 0;  //inturrupt at falling edges
loop:    //from this choosing the state (auto/manual)
while(porta.B4 == 1)//when port RA4 is 1 (automatic)
{
         inte_bit = 0;
         portb = 255;    //turn on all 7 segments
         portd = 0;      // leds are off at first
         for (i = 23 ; i>=0 ; i--) //23 sec for red south
         {
              if (porta.B4 ==0) //if switch is changed
                 break;  //automatic changed to manual
              portc = segment[i];
              if (i == 23)
              {
              ledredsouth = 1;  //led on for 23 sec for red south
              ledgreenwest = 1; //green west has 20 sec from 23 sec
              }
              
              if (i == 3)
              {

                 ledgreenwest = 0; //after 15 sec greenwest is off
                 ledyellowwest =1;  //yellow is on
              }
              if (i ==0)
              {
                  ledredsouth = 0;  //red south is off after 23 sec
                  ledyellowsouth = 1;//yellowsouth is on
                  ledyellowwest = 0;//same time yellow west is off
                  ledgreenwest = 0; //same time green west is on
                  ledredwest = 1;  //after 23 sec the redwest is on
              }

                delay_ms(1000);//delay 1 second for 23 seconds
          }
          for (j = 15 ; j>=0;j--) //15 sec for red west
          {

             portc = segment[j];
             if (porta.B4 ==0)
                break;

             
             if (j ==12) //after 3 seconds from the period
             {
             
                 ledyellowsouth = 0;//after 3 sec yellowsouth is off
                 ledgreensouth = 1; //same time greensouth is on

                  

             }
             
             if (j == 0) //15 seconds(redwest)12 seconds(greensouth)
             {
                  ledgreensouth = 0;//after 12 seconds greensouth off
                  ledredwest = 0;  //red west is off after 15 sec

                  ledyellowwest = 1; //after 15 sec for both of them
                  ledyellowsouth = 1; //yellow leds is on for 3 sec
                  for (enl = 3 ; enl>=0;enl--)
                  {
                      portc = segment[enl]; //3 sec on 7 segment
                      if (enl == 0)       //after 3 sec
                      {
                      ledyellowwest = 0; //both yellow are off
                      ledyellowsouth = 0;
                      ledredsouth = 1; //return to first condition
                      ledgreenwest = 1;
                        }
                        delay_ms(1000); //delay for 3 sec yellow loop

                  
                  }
                  portc = segment[23]; //7 segment to 23 sec again

             
             }
             
                  
            delay_ms(1000);  //delay of 15 seconds for loop
          }
          
}
if (porta.B4 ==0) { //when port RA4 is 0 manual
  portb = 0;       //7 segments are off
  portd = 0;        //leds are off
  inte_bit = 1;
  gie_bit =1;
  while(porta.B4 ==0); //hold until changing to auto again

}
goto loop;  //return to loop label










}