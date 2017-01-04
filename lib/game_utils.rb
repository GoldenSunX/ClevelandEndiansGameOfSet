=begin
Created (Andrew Fox 2016-09-14): Module for utility functions for the application.
Updated (Andrew Fox, 2016-09-18): Added the get_valid_player_key function.
Updated (Andrew Fox, 2016-09-19): Added the get_valid_card_numbers function.
=end
module GameUtils

  #Created (Andrew Fox 2016-09-14): Ensures the user inputs a natural number between min and max. Min must be greater than or equal to 0
  #and max must be greater than or equal to min.
  #Param min: the minimum natural number to accept as user input
  #Param max: the maximum natural number to accept as user input
  #Output: the valid value between min and max input by the user
  def self.get_valid_option_number(min, max)
    valid_input_entered = false

    until valid_input_entered
      user_input = STDIN.gets
      if user_input.is_nn?
        if user_input.to_i >= min && user_input.to_i <= max
          valid_input_entered = true
        else
          print "Invalid input, please try again: "
        end
      else
        print "Invalid input, please try again: "
      end
    end

    user_input.to_i
  end

  #Created (Andrew Fox 2016-09-19): Returns an array of size 3 containing the index of the cards the user has selected.
  #and max must be greater than or equal to min.
  #Param min: the minimum natural number to accept as user input
  #Param max: the maximum natural number to accept as user input
  #Output: An array with the 3 card numbers as the values
  def self.get_valid_card_numbers(min, max)
    valid_input_entered = false
    card_numbers = Array.new
    current_card_number = 0

    print "Enter the number of a card in the set: "
    until valid_input_entered && current_card_number == 3
      user_input = STDIN.gets
      if user_input.is_nn?
        if user_input.to_i >= min && user_input.to_i <= max && card_numbers.index(user_input.to_i - 1) == nil
          valid_input_entered = true
          card_numbers[current_card_number] = user_input.to_i - 1
          current_card_number += 1
          if current_card_number == 1
            print "Enter the number of a second card in the set: "
          elsif current_card_number == 2
            print "Enter the number of the last card in the set: "
          end
        elsif card_numbers.index(user_input.to_i - 1) != nil
          valid_input_entered = false
          print "That card was already entered, please try again: "
        else
          valid_input_entered = false
          print "Invalid input, please try again: "
        end
      else
        print "Invalid input, please try again: "
      end
    end

    card_numbers
  end

  #Created (Andrew Fox 2016-09-18): Ensures the user inputs a valid user key so the program can associate their input with a player object
  #Param players: An array of the players in the game
  #Output: the player object from param players that entered their player key
  def self.get_valid_player_key(players,board)
    valid_input_entered = false

    until valid_input_entered
      user_input = STDIN.gets.chomp
      pos = 0
      if user_input == 'x'
        board.print_hint_array
      end
      while pos < players.size
        if user_input == players[pos].player_key
          valid_input_entered = true
          player = players[pos]
        end
        pos += 1
      end
      unless valid_input_entered
        print "Invalid input, please try again: "
      end
    end

    player
  end

  #Created (Andrew Fox 2016-09-18): the user inputs a yes or no for program control flow
  #Output: either a true or false if the user inputs a y or n respectively
  def self.get_valid_yes_no
    valid_input_entered = false

    until valid_input_entered
      user_input = STDIN.gets.chomp
      if user_input == "Y"  || user_input == "y"
        valid_input_entered = true
        return_value = true
      elsif user_input == "n"|| user_input == "N"
        valid_input_entered = true
        return_value = false
      end
      unless valid_input_entered
        print "Invalid input, please try again: "
      end
    end

    return_value
  end
end