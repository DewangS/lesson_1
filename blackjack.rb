# Black Jack console game in Ruby
# Author :  Dewang Shahu 
# Date    : 1st March 2015
#
require 'pry'

CARDS = [2,3,4,5,6,7,8,9,10,'J','Q','K','A']
CARD_TYPE = ['S','C','H','D']
CARD_TYPE_SYMBOLS = {'S' => '\u2660', 'C' => '\u2663', 'H' => '\u2665', 'D' => '\u2666'}
PLAYER_CHOICE = ['hit','stay']

#methods to calculate card totals
def card_totals(selected_cards)
  total_value = 0
  selected_cards.each do |card|
    card_value = card[0]
    if card_value.to_i > 0
        total_value += card_value.to_i
    elsif ['J', 'Q', 'K'].include?(card_value)
        total_value += 10
    elsif card_value == "A" && total_value > 10
        total_value += 1
    elsif card_value == "A" && total_value < 10
        total_value += 11
    end
  end
  total_value
end

#methods to draw cards
def draw_cards(selected_cards, card_owner)
  system "clear"
  puts "#{card_owner}'s Cards ..."
  selected_cards.each do |selected_card|
    puts "\u250C" + "\u2501"+ "\u2501"+ "\u2501" + "\u2501" + "\u2501"+ "\u2511"
    puts "\u2502" + "     " + "\u2502"
    puts "\u2502" + "     " + "\u2502"
    if selected_card[0].to_s.size > 1
      puts "\u2502" + "  " + selected_card[0].to_s + " " + "\u2502"
    else
      puts "\u2502" + "  " + selected_card[0].to_s + "  " + "\u2502"
    end
    case selected_card[1]
      when 'S'
            puts "\u2502  \u2660  \u2502"  
      when 'C'
            puts "\u2502  \u2663  \u2502"
      when 'H'
            puts "\u2502  \u2665  \u2502"  
      when 'D'
            puts "\u2502  \u2666  \u2502" 
    end
    puts "\u2502" + "     " + "\u2502"
    puts "\u2502" + "     " + "\u2502"
    puts "\u2514" + "\u2501"+ "\u2501"+ "\u2501" + "\u2501" + "\u2501"+ "\u251A"
  end
end

#methods to analyse the totals and determine the result
def game_over(player_total, dealer_total, player_cards, dealer_cards, player_deposit_amount, bet_amount, draw_dealer_cards)
  if dealer_total == player_total
    puts "It's a tie"    
    player_deposit_amount += bet_amount
  elsif player_total > 21 
    puts "You've busted. Sorry, the dealer wins this game"
    player_deposit_amount -= bet_amount
  elsif dealer_total > 21
    puts "Dealer busted. You won the game"
    player_deposit_amount += (bet_amount*2)
  elsif dealer_total > player_total 
    puts "Sorry, the dealer wins this time"
    player_deposit_amount -= bet_amount
  elsif player_total > dealer_total
    puts "Congratulations ...you won"
    player_deposit_amount += (bet_amount*2)
  end 
  if draw_dealer_cards
    draw_cards(dealer_cards, "Dealer")
  end
  player_deposit_amount
end

#To prompt user if he wishes to play another round
def play_another_round
  puts "Do you want to play another round?"
  another_round = gets.chomp.downcase
  while !['yes','no'].include?(another_round)
    puts "Do you want to play another round?"
    another_round = gets.chomp.downcase
  end
  another_round
end

#To accept the bet amount from the player
def get_bet_amount(player_deposit_amount)
  bet_amount = 0
  puts "How much would you like to bet?"
  bet_amount = gets.chomp.to_i
  
  while  player_deposit_amount < bet_amount || bet_amount <= 0 
    if player_deposit_amount < bet_amount
        puts "You only have max $#{player_deposit_amount} available to bet. Please enter smaller or equal bet amount"
      else
        puts "Please eneter a valid bet amount > 0"
    end
    puts "How much would you like to bet?"
    bet_amount = gets.chomp.to_i
  end
  bet_amount
end

def get_hit_or_stay(player_name, player_total)
  puts "\n#{player_name}.. your card total is #{player_total}. Do you want to hit or stay?"
  hit_or_stay = gets.chomp.downcase
  while !PLAYER_CHOICE.include?(hit_or_stay)
    puts "Please enter hit or stay"
    hit_or_stay = gets.chomp.downcase
  end
  hit_or_stay
end

#main logic

  player_name = ""
  player_total = 0
  dealer_total = 0
  another_round = "yes"
  deck = Array.new(52){Array.new(2)}
  player_cards = []
  dealer_cards = []
  player_name = ""
  player_deposit_amount = 0

  system "clear"
  puts "Welcome to Blackjack game. May I have your name please?"
  player_name = gets.chomp
  puts "#{player_name}, How much money would you like to start with?"
  player_deposit_amount = gets.chomp.to_i

  #main loop which lasts till either player decides to abort the game or there are no funds left in player's deposit
  while player_deposit_amount > 0 && another_round == "yes"
    puts "Your remaining deposit amount is $#{player_deposit_amount}."
    bet_amount = get_bet_amount(player_deposit_amount)
    
    while another_round == "yes" 
      
      deck = CARDS.product(CARD_TYPE)
      deck.shuffle!
      player_total = 0
      dealer_total = 0
      player_cards = []
      dealer_cards = []
      # draw first card for the dealer and the player
      dealer_cards.push(deck.shift)
      player_cards.push(deck.shift)

      # draw second card for the dealer and the player
      dealer_cards.push(deck.shift) 
      player_cards.push(deck.shift)
      draw_cards(player_cards, "Player")

      player_total = card_totals(player_cards)
      dealer_total = card_totals(dealer_cards)
      
      if player_total >= 21
        puts "\n#{player_name}'s card total is #{player_total}"
        player_deposit_amount = game_over(player_total,dealer_total,player_cards,dealer_cards,player_deposit_amount,bet_amount,true)
        break
      else
        hit_or_stay = get_hit_or_stay(player_name, player_total)
        while hit_or_stay == 'hit' do
          player_cards << deck.shift
          player_total = card_totals(player_cards)
          draw_cards(player_cards, "Player")
          if player_total >= 21 
            player_deposit_amount = game_over(player_total,dealer_total,player_cards,dealer_cards,player_deposit_amount,bet_amount,true)
            break
          else
            hit_or_stay = get_hit_or_stay(player_name,player_total)
          end   
        end

        if player_total >= 21 
          break
        end

        if hit_or_stay == 'stay'
          if dealer_total >= 21
             player_deposit_amount = game_over(player_total,dealer_total,player_cards,dealer_cards,player_deposit_amount,bet_amount,true)
             break
          end

          while dealer_total < 17
            dealer_cards << deck.shift
            dealer_total = card_totals(dealer_cards)
            draw_cards(dealer_cards, "Dealer")
            if dealer_total >= 21
              player_deposit_amount = game_over(player_total,dealer_total,player_cards,dealer_cards,player_deposit_amount,bet_amount,false)
              break
            end
          end
          if dealer_total >= 21
            break
          end
        end
        if dealer_total >= 17 && dealer_total < 21 && hit_or_stay == 'stay'
          player_deposit_amount = game_over(player_total,dealer_total,player_cards,dealer_cards,player_deposit_amount,bet_amount,true)
          break        
        end
      end
    end
    if player_deposit_amount > 0
      another_round = play_another_round
      next
    else
      puts "\nSorry you don't have any money left in your deposit."
      break
    end
  end
  puts "Thanks for playing with us."
  
