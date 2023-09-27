package body utils is

   function clamp(min : Integer; max : Integer; value : Integer) return Integer is
   begin
      if (value < min) then
         return min;
      elsif (value > max) then
         return max;
      else
         return value;     
      end if;
   end clamp;
   

end utils;
