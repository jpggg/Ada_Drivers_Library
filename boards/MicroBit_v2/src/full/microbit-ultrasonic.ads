with nRF.GPIO; use nRF.GPIO;
-- with Microbit.Types; use MicroBit.Types;
generic
 
package MicroBit.Ultrasonic is

   function Read return Float;
   
   procedure Setup (trigger_pin : GPIO_Point; echo_pin : GPIO_Point);

private
   procedure SendTriggerPulse;
   
   function WaitForEcho return Integer;
   
   function ConvertEchoToDistance (echo_time_us : Integer) return Float; 
   
end MicroBit.Ultrasonic;
