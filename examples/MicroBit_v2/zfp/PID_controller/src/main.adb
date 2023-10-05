with Controller;


procedure Main is
begin
   loop
      null;
   end loop;
end Main;





   begin

   end Read_Distance_Sensors_Front;





   motor_pwm_value : UInt12;
   pid_value_right : Integer;
   distance_right : Distance_cm;
   target : Distance_cm := 20;
   motor_delay_ms : UInt64 := 0;
   min_pwm : Integer := -4095;
   max_pwm : Integer := 4095;
   time_right : Time_Ms;
   time_left : Time_Ms;

begin

   distance_sensor_right.Setup(MB_P0, MB_P1);
   distance_sensor_left.Setup(MB_P2, MB_P3);


   loop

      distance_right := distance_sensor_right.Read;
      distance_left := distance_sensor_left.Read;
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
