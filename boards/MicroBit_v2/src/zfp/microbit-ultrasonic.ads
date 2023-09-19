with nRF.GPIO; use nRF.GPIO;

package MicroBit.Ultrasonic is

   type Distance_cm is range 0 .. 400; -- if < 2 it is invalid
   
   function Read return Distance_cm;
   
   
   procedure Setup (trigger_pin : GPIO_Point; echo_pin : GPIO_Point);
     
private
   procedure SendTriggerPulse;
   
   function WaitForEcho return Integer;
   
   function ConvertEchoToDistance (echo_time_us : Integer) return Distance_cm; 
   
end MicroBit.Ultrasonic;
