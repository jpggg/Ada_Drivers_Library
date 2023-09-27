with MicroBit.Types; use MicroBit.Types;
with MicroBit.Time; use MicroBit.Time;
with HAL; use HAL;
generic
   
   Kp : Integer;
   Ki : Integer;
   Kd : Integer;
   
package PID is
   
   m_Kp : Integer := Kp;
   m_Ki : Integer := Ki;
   m_Kd : Integer := Kd;
   
   function regulate(target : in Distance_cm; actual : in Distance_cm; time : in Time_Ms) return Integer;
   
private
   
   m_prev_error : Integer := 0;
   m_prev_time : Time_Ms := 0;
   
end PID;
