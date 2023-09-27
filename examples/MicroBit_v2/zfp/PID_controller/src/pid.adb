with HAL; use HAL;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Time; use MicroBit.Time;
with MicroBit.Console; use MicroBit.Console;

package body PID is

   
   
   
   function regulate(target : in Distance_cm; actual : in Distance_cm; time : in Time_Ms) return Integer is
      error : Integer;
      dt : Time_Ms;
      d_error : Integer;
      P : Integer;
      D : Integer;
      result : Integer;
   
   begin
      
      
      dt := time - m_prev_time;
      Put_Line("dt" & Time_Ms'Image(dt));
      error := Integer(target) - Integer(actual);
      Put_Line("error" & Integer'Image(error));
      d_error := error - m_prev_error;
      Put_Line("d_error" & Integer'Image(d_error));
      
      P := Kp * Integer(error);
      Put_Line("P" & Integer'Image(P));
      D := Kd * Integer(d_error) * Integer(dt);
      Put_Line("D" & Integer'Image(D));
      
      result := P + D;
      Put_Line("result" & Integer'Image(result));
      
      return result;
      
   end regulate;
   
   

end PID;
