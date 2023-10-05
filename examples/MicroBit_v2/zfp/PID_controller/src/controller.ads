with HAL; use HAL;

package Controller is

   task Read_Distance_Sensors_Front with Priority => 3;
   task Motor_Control with Priority => 2;
   task Stop with Priority => 1;
   
   motor_LF_pwm : Integer;
   motor_RF_pwm : Integer;
   motor_LB_pwm : Integer;
   motor_RB_pwm : Integer;
   
   distance_left : Integer;
   distance_right : Integer;
   
   ;

end Controller;
