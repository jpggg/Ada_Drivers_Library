with MicroBit.Time.Highspeed; use MicroBit.Time.Highspeed;
package body MicroBit.Ultrasonic is

   Trigger   : GPIO_Point := MB_P0;
   Echo  : GPIO_Point := MB_P0;
   result : Distance_cm := 0;

   --we use this setup function to prevent a dependency on Microbit.IOS
   procedure Setup (trigger_pin : GPIO_Point;
                    echo_pin : GPIO_Point)
   is
      Conf : GPIO_Configuration;
   begin
      Trigger := trigger_pin;
      Echo := echo_pin;

      Conf.Mode         := Mode_Out;
      Conf.Resistors    := No_Pull;
      Conf.Input_Buffer := Input_Buffer_Connect;
      Conf.Sense        := Sense_Disabled;

      --set trigger pin as output
      Trigger.Configure_IO (Conf);
      Trigger.Clear;

      --set echo pin as input
      Conf.Mode         := Mode_In;
      Echo.Configure_IO (Conf);
      Echo.Clear;
   end Setup;

   function Read return Distance_cm is
      echo_time_us : Integer;
   begin
      SendTriggerPulse; --blocking, but only 10 us
      echo_time_us := WaitForEcho; --blocking!
      result := ConvertEchoToDistance(echo_time_us);

      --Delay needs to be at least 23ms for max range of 400cm. If only interested in shorter ranges, shorter delay can be set
      return result;
   end Read;

   procedure SendTriggerPulse is
   begin
       -- Not 10 us, more about 11.4us (10 us+ required by ultrasonic spec)
      Trigger.Set;
      Delay_Us(10);
      Trigger.Clear;
      end SendTriggerPulse;

   function WaitForEcho return Integer is
      delayCounter :Integer := 0;
   begin
      --wait for echo to start
      while Echo.Set = False  loop
         null;
      end loop;

      --wait for echo to end
      while Echo.Set = True loop
         Delay_Us(58);  --wait for 58 us or 1 cm distance and check again
         delayCounter := delayCounter + 1;
      end loop;

      return delayCounter * 58; --high time in us
   end WaitForEcho;

   function ConvertEchoToDistance (echo_time_us : Integer) return Distance_cm is
    temp_result : Integer;
   begin
      -- Distance formula see: https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf
      temp_result := echo_time_us/ 58;

      if temp_result > 400 then
         temp_result := 400;
      end if;

      if temp_result < 2 then
         temp_result := 0;
      end if;

      return Distance_cm(temp_result);
   end ConvertEchoToDistance;
end MicroBit.Ultrasonic;
