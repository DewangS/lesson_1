#This program provides calculator functionality
# Author : Dewang Shahu
# Date : 25th Feb 2015

#require 'pry'

def disp_msg(msg_in)
    puts "=>  #{msg_in}"
end

begin 

#declare variables
flag = false
answer = 'n'

#loop until user enters a valid numeric value for the first parameter
begin
    disp_msg("Please enter first number")
    num1 = gets.chomp
    #check if the user input for the 1st parameter is numeric
    if /^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$/.match(num1) == nil
      disp_msg("**** Error : Please enter a numeric value for the first input ***")
      next
    else
      flag = true
    end 
end while !flag

flag=false   #reset the flag

#loop until user enters a valid numeric value for the first parameter
begin
  disp_msg("Please enter second number")
  num2 = gets.chomp

  #check if the user input for the 2nd parameter is numeric
  if /^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$/.match(num2) == nil
    disp_msg("**** Error : Please enter a numeric value for the second input ***")
    next
  else
    flag = true
  end
end while !flag

#reset the flag to false
flag = false

#loop until user selects a valid operation
begin
  disp_msg("Please select the operation 1) Add 2) Subtract 3) Multiply 4) Devide ")
  operator = gets.chomp

  case operator
    when '1'
      result = num1.to_f + num2.to_f
      flag = true
    when '2'
      result = num1.to_f - num2.to_f
      flag = true
    when '3'
      result = num1.to_f * num2.to_f
      flag = true
    when '4'
      result = num1.to_f / num2.to_f
      flag = true
    else
      disp_msg("**** Please select a valid operation.")
  end
end while !flag

disp_msg("=> Result is #{result}")

disp_msg("Do you want to exit the calculator?(y/n)")
answer = gets.chomp

end while answer != 'y'