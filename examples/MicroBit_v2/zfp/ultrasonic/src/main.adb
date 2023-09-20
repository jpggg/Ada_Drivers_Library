with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Time; use MicroBit.Time;
with MicroBit.Types; use MicroBit.Types;
use MicroBit;

procedure Main is
   package sensor1 is new Ultrasonic;
   package sensor2 is new Ultrasonic;
   package sensor3 is new Ultrasonic;

   Distance : Distance_cm := 0;
begin
   sensor1.Setup(MB_P16, MB_P0);
   sensor2.Setup(MB_P15, MB_P0);
   sensor3.Setup(MB_P14, MB_P0);
   loop
      Put_Line ("");
      Distance := sensor1.Read;
      Put_Line ("Front: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      Distance := sensor2.Read;
      Put_Line ("Left: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      Distance := sensor3.Read;
      Put_Line ("Right: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly

      --NOTE: A delay directly after a read of about 50ms is needed if only 1 sensor
      -- or when multiple, have more than 1 sensor face the same direction
      -- we use a delay here because our Serial port gets flooded otherwise
      Delay_Ms(50);
   end loop;

end Main;



