with MicroBit.Types; use MicroBit.Types;
with MicroBit.Time; use MicroBit.Time;
with PID;
with HAL; use HAL;
with HAL.Time; use HAL.Time;
with MicroBit.Ultrasonic;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with MicroBit.Console; use MicroBit.Console;
with utils; use utils;
use MicroBit;

package body Controller is
   
   task body Read_Distance_Sensors_Front is
      package distance_sensor_right is new Ultrasonic;
      package distance_sensor_left is new Ultrasonic;
      
   begin
      -- Read_Distance_Sensors_Front code
      -- Return distance
      
      distance_right := distance_sensor_right.Read;
      
   end Read_Distance_Sensors_Front;
   
   task body Motor_Control is
      package DistancePID is new PID (Kp => -50,
                                   Ki => 0,
                                   Kd => 0);
   begin
      -- Motor_Control code
      -- Input distance
      motor_LB_pwm := DistancePID.regulate(distance_threshold, distance, time) + TurnPID.regulate(0, diff_distance, time);
       Drive()
      -- Output PWM
   end Motor_Control;
   
   
   task body Stop is
   begin
      -- Stop code
   end Stop;
   
   
   
begin
   -- Controller code
end Controller;

   

end Controller;
