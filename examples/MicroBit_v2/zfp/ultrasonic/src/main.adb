with MicroBit.Ultrasonic; use Microbit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Time; use MicroBit.Time;
use MicroBit;

procedure Main is
   Distance : Distance_cm := 0;
begin
   Ultrasonic.Setup(MB_P16, MB_P0);

   loop
      Distance := Read;
      Put_Line ("Read" & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      Delay_Ms(50);
   end loop;

end Main;



