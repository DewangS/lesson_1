# This is a classic Paper Rock Scissors game
#	Author	: Dewang Shahu
#	Date	: 25 Feb 2015

#loop until user selects to quit the game
def display_message(winning_choice)
  if winning_choice == 'p'
      puts "Paper wraps Rock."
    elsif winning_choice == 'r'
      puts "Rock smashes Scissors"
    else
      puts "Scissors cuts Paper"
  end      
end


puts "Play Paper Rock Scissors!"
CHOICES = {'p' => 'Paper', 's' => 'Scissors', 'r' => 'Rock'}

another_round = 'Y'

begin
  begin
    puts "Choose one (p/r/s)"
    player_choice = gets.chomp.downcase
    if CHOICES.keys.include?(player_choice) == false
        puts "*** Invalid choice... Please enter p/r/s and try again.. ***"
    end
  end until CHOICES.keys.include?(player_choice)
  
  comupter_choice = CHOICES.keys.sample

  if player_choice == comupter_choice 
            puts "It's a tie!"
     elsif (player_choice == 'p' && comupter_choice=='r') || (player_choice == 'r' && comupter_choice == 's') || (player_choice == 's' && comupter_choice == 'p')
            display_message(player_choice)
            puts "You won!!"
      else
            display_message(comupter_choice)
            puts "Computer won"
   end         
  
  puts "Play again?(Y/N)"
  another_round = gets.chomp.upcase
    
end while another_round == 'Y'
