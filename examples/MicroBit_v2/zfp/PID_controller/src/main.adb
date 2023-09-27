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


procedure Main is

   package distance_sensor is new Ultrasonic;

   package MotorPID is new PID (Kp => -500,
                                Ki => 0,
                                Kd => 0);

   motor_pwm_value : UInt12;
   pid_value : Integer;
   distance : Distance_cm;
   target : Distance_cm := 30;
   motor_delay_ms : UInt64 := 0;
   min_pwm : Integer := -4095;
   max_pwm : Integer := 4095;
   time : Time_Ms;

begin

   distance_sensor.Setup(MB_P0, MB_P1);


   loop

      distance := distance_sensor.Read;
      Put_Line("Front" & Distance_cm'Image(distance));

      time := Tick_Period;
      pid_value := MotorPid.regulate(target, distance, time);
      pid_value := clamp(min_pwm, max_pwm, pid_value);
      Put_Line("pid_value" & Integer'Image(pid_value));

      if (distance < target) then
         motor_pwm_value := UInt12(-pid_value);
         Drive(Backward,(motor_pwm_value, motor_pwm_value, motor_pwm_value, motor_pwm_value));
         Delay_Ms(motor_delay_ms);
      else
         motor_pwm_value := UInt12(pid_value);
         Drive(Forward,(motor_pwm_value, motor_pwm_value, motor_pwm_value, motor_pwm_value));
         Delay_Ms(motor_delay_ms);
      end if;
   end loop;
end Main;
