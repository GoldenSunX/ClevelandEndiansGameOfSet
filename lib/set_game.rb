#Created (Andrew Fox, 2016-09-14): Class that contains the run method for the game, as well as many of its text interface methods.
#Updated (Andrew Fox, 2016-09-19): Added normal_game and print_game_end_information functions
#Updated (Andrew Fox, 2016-09-19): Fixed normal game mode for when the user enters the same card multiple times.
#Updated (Cole Albers, 9/19): Added all functionality for Timed Game Mode

require_relative 'core_extensions'
require_relative 'game_utils'
require_relative 'set_board'
require_relative 'player'
require_relative 'card'
require_relative 'deck'
require 'timeout'

String.include CoreExtensions::String

class SetGame

  #Created (Andrew Fox, 2016-09-14): Acts as the main function of the SetGame program. Prints out the main menu and runs appropriate commands for the user input
  def run
    @players = Array.new
    exit = false

    until exit
      puts "Cleveland Endians' Game of Set"
      puts "\nMain Menu"
      puts "1. Start new game"
      puts "2. Help"
      puts "3. Quit"
      print "Type the option number and hit the enter key: "
      user_input = GameUtils.get_valid_option_number 1, 3

      puts
      if user_input == 1
        get_new_game_information
        if @game_mode == 1
          normal_game
        else
          timed_game
        end
      elsif user_input == 2
        print_game_manual
      elsif user_input == 3
        exit = true
      end
    end
  end

  #Created (Andrew Fox, 2016-09-14): Runs the normal game mode, printing the winner at the end
  def normal_game
    exit = false
    print_game_start_information
    deck = Deck.new
    set_checker = Set_class.new
    game_board = Board.new(deck)
    print "Hit enter when you are ready to play"
    gets
    while (deck.size != 0 || game_board.set_exists) && !exit
      puts
      game_board.print_board
      print "Enter your player key: "
      player = GameUtils.get_valid_player_key @players,game_board
      puts "Player " + player.player_number.to_s + " detected"
      print "Have you found a set? (Y/N): "
      if GameUtils.get_valid_yes_no
        card_numbers = GameUtils.get_valid_card_numbers(1, game_board.number_of_cards)
        card_one = game_board.get_card(card_numbers[0])
        card_two = game_board.get_card(card_numbers[1])
        card_three = game_board.get_card(card_numbers[2])
        set_checker.card1 = card_one
        set_checker.card2 = card_two
        set_checker.card3 = card_three
        if set_checker.is_set?
          player.score += 1
          puts "That's a set! Player " + player.player_number.to_s + "'s score is now: " + player.score.to_s
          game_board.remove_set card_one, card_two, card_three
          unless game_board.number_of_cards >= 12
            game_board.restock_cards deck
          end
          #Returns to beginning of loop after this, printing the new board
        else
          puts "That's not a set!"
        end
        set_checker.clear
      else
        #Determine what the user is trying to do. (Exit, get hint, etc.)
        if game_board.set_exists
          puts "Sets exist on the game board"
          puts "1. Print hint"
          puts "2. Exit game"
          print "Type the option number and hit the enter key: "
          user_input = GameUtils.get_valid_option_number 1, 2

          if user_input == 1
            puts
            game_board.card_set_hint
          else
            exit = true
          end
        else
          puts "Sets do not exist on the game board"
          puts "1. Restock board and continue playing"
          puts "2. Exit game"
          print "Type the option number and hit the enter key: "
          user_input = GameUtils.get_valid_option_number 1, 2

          if user_input == 1
            game_board.restock_cards deck
          else
            exit = true
          end
        end
      end
    end

    #Deck is now empty, print end game information
    print_game_end_information
  end

	#Created (Cole Albers, 9/19): Runs the Timed Game Mode
  def timed_game
    if @number_of_players == 1
      puts "Press Enter to begin"
      gets
      start_timed_game
    else
      print "Player 1: When you are ready, press Enter to begin:"
      gets
      player1_points = start_timed_game
      puts
      print "Player 2: When you are ready, press Enter to begin:"
      gets
      player2_points = start_timed_game
      puts
      if player1_points > player2_points
        puts "Player 1 Wins!"
      elsif player1_points < player2_points
        puts "Player 2 Wins!"
      else
        puts "It was a tie!"
      end
      puts
    end
  end

	#Created (Cole Albers, 9,19): Completes one game of timed mode.
  #Update (Cole Albers, 9/19): Added set_exists and card_set_hint functionality.
  #Update (Cole Albers, 9/20): Added restock_card condition. Added better instructions.
  def start_timed_game
    deck = Deck.new
    board = Board.new(deck)
    puts
    puts "Begin! You have 120 seconds!"
    puts
    board.print_board
    points = 0
    begin
      Timeout::timeout(120) do
        while true
          puts
          puts "Please enter a set (EX: 1 2 3) or 'no set' if you believe there are no sets available."
          input = gets
          num1_good = false
          num2_good = false
          num3_good = false
          checked_set_exists = false
          if input.chomp == "no set"
            checked_set_exists = true
            if board.set_exists
              puts
              puts "Incorrect! A set exists!"
              print "Would you like a hint? (y/n): "
              answer = gets
              puts
              until answer.chomp == "y" or answer.chomp == "n"
                puts "Invalid Input!"
                print "Would you like a hint? (y/n): "
                answer = gets
                puts
              end
              if answer.chomp == "y"
                board.card_set_hint
                puts
              end
            else
              puts
              puts "Correct! Adding three cards to board!"
              puts
              board.restock_cards deck
            end
          else
            numbers = input.split
            if numbers.length == 3
              num1 = numbers[0]
              if num1.is_nn? and num1.to_i <= board.size and num1.to_i >= 1
                c1 = board.get_card((num1.to_i)-1)
                num1_good = true
              end
              num2 = numbers[1]
              if num2.is_nn? and num2.to_i <= board.size and num2.to_i >= 1 and num2.to_i != num1.to_i
                c2 = board.get_card((num2.to_i)-1)
                num2_good = true
              end
              num3 = numbers[2]
              if num3.is_nn? and num3.to_i <= board.size and num3.to_i >= 1 and num3.to_i != num2.to_i and num3.to_i != num1.to_i
                c3 = board.get_card((num3.to_i)-1)
                num3_good = true
              end
            end
          end
          if num1_good and num2_good and num3_good
            possible_set = Set_class.new c1, c2, c3
            if possible_set.is_set?
              puts
              puts "Correct! +1 Point!"
              puts
              points += 1
              board.remove_set c1, c2, c3
              unless board.number_of_cards >= 12
                board.restock_cards deck
              end
            else
              puts
              puts "Incorrect! Not a Set!"
              puts
            end
          else
            unless checked_set_exists
              puts
              puts "Invalid Input!"
              puts
            end
          end
          board.print_board
        end
      end
    rescue Timeout::Error
      puts
      puts "Stop! Your time is up!"
      puts "Number of Sets: #{points.to_s}"
      puts
    end
    points
  end


  #Created (Andrew Fox 2016-09-14): Prompt user for the desired number of players as well as the desired game mode.
  #Updated (Andrew Fox 2016-09-18): Added initialization of players array.
  def get_new_game_information
    print "Enter the desired number of players (2 players max): "
    @number_of_players = GameUtils.get_valid_option_number 1, 2
    print "Enter the desired game mode (1 for a normal game of set, 2 for time trial): "
    @game_mode = GameUtils.get_valid_option_number 1, 2

    pos = 0
    while pos != @number_of_players
      if pos == 0
        @players[pos] = Player.new 0, pos + 1, '1'
      else
        @players[pos] = Player.new 0, pos + 1, '0'
      end
      pos += 1
    end
  end

  #Created (Andrew Fox 2016-09-14): Displays information for the user about their current game session, so the player knows what they are doing before
  # they start
  def print_game_start_information
    if @game_mode == 1
      game_type_string = "a standard game of set"
    else
      game_type_string = "time trial"
    end

    if @number_of_players == 2
      puts "IMPORTANT: Player 1's player key is 1, and player 2's player key is 0."
    else
      puts "IMPORTANT: Player 1's player key is 1."
    end
    puts "The game type you chose is " + game_type_string + ", with " + @number_of_players.to_s + " players.\n"
  end

  #Created (Andrew Fox 09/14): Displays winner information when the game has ended.
  #Updated (Andrew Fox, 09/19): Fixed infinite loop in finding highest score.
  #Updated (Andrew Fox, 09/20): Fixed winner logic.
  def print_game_end_information
    current_player_num = 0
    puts "The game is over!"
    while current_player_num != @number_of_players
      puts "Player " + @players[current_player_num].player_number.to_s + "'s score: " + @players[current_player_num].score.to_s
      current_player_num += 1
    end

    if @number_of_players == 2
      tied = false
      if @players[0].score == @players[1].score
        tied = true
      elsif @players[0].score > @players[1].score
        winner = @players[0]
      else
        winner = @players[1]
      end

      if tied
        puts "The game ended in a tie!"
      else
        puts "The winner is player " + winner.player_number.to_s + "!"
      end
    end
    puts
  end

  #Created (Andrew Fox 09/14): Prints game manual to the screen and prompts the user to return the previous screen.
  def print_game_manual


    puts wrap("Welcome to the Cleveland Endians' Game of Set!

GAME DESCRIPTION (Source: Wikipedia):

Set is a real-time card game designed by Marsha Falco in 1974 and published by Set Enterprises in 1991. The deck consists of 81 cards varying in four features: number (one, two, or three); symbol (diamond, squiggle, oval); shading (solid, striped, or open); and color (red, green, or purple).Each possible combination of features (e.g., a card with three striped green diamonds) appears precisely once in the deck. A set consists of three cards which satisfy all of these conditions:

    -They all have the same number, or they have three different numbers.
    -They all have the same symbol, or they have three different symbols.
    -They all have the same shading, or they have three different shadings.
    -They all have the same color, or they have three different colors.

For example, these three cards form a set:

    -One red striped diamond
    -Two red solid diamonds
    -Three red open diamond

In the standard Set game, the dealer lays out cards on the table until either twelve are laid down or someone sees a set and calls Set! The player who called Set takes the cards in the set and the dealer continues to deal out cards until twelve are on the table. A player who sees a set among the twelve cards calls 'Set' and takes the three cards, and the dealer lays three more cards on the table. (To call out 'set' and not pick one up quickly enough results in a penalty.) It is possible that there is no set among the twelve cards; in this case, the dealer deals out three more cards to make fifteen dealt cards, or eighteen or more, as necessary. This process of dealing by threes and finding sets continues until the deck is exhausted and there are no more sets on the table. At this point, whoever has collected the most sets wins.

STARTING A GAME:

The first screen you encounter will be the main menu. Type in '1' then press 'Enter' if you wish to start a game. The next screen will prompt you for the desired number of players. Type in '1' or '2' corresponding to the number of people that wish to play and press 'Enter'. Next you will be prompted to enter your desired game mode. Type in '1' if you wish to play a normal game (which ends once the deck is empty and there are no possible sets on the board) or type in '2' if you wish to play time trial (which ends after two minutes of game play) and press 'Enter'. Press 'Enter when you are ready to start the game.

1) Normal Mode:

Twelve cards will be listed on the board. Once a player thinks they have found a set, the player should type in their player key (player 1 is '1', player 2 is '0') and press enter. You will be prompted to answer if you hvae found a set, type 'y' and press enter. Next type the corresponding number for the first card in you set and press 'Enter', repeat this step for the second and third card in your set. The game will determine if this is a set and let you know, if it is a set, 1 point will be added to the players score. If no set can be found, type in a player key and press 'Enter'. Next type 'n' and press 'Enter', if a set exists on the board you can receive a hint by typing '1' and pressing 'enter'. This will show you a card that exists in a set on the board. If no set exists on the board, three cards will be added to the board. On the previous screen you may also exit the game early by typing '2' and pressing 'Enter'. Continue playing until the deck is empty and there are no possible sets on the board. At this point the game is over and the player that found the most sets is the winner, if both players found the same amount of sets, the result is a tie.

2) Time Trial:

Twelve cards will be listed on the board. Once you have found a set, type in the card numbers that make up a set in this format: 'number' 'number' 'number' (spaces between three numbers), and press enter. The game will notify you whether or not this is a valid set, and update the player score accordingly. Continue looking for sets and try to find as many as you can before the 2 minutes has elapsed. If no set can be found type 'no set' and press 'Enter'. The game will notify whether or not a set exists on the board. If a set exists, the game will prompt you whether or not you would like a hint. Type 'y' or 'n' and press 'Enter' depending on if you would like a hint. If a set does not exist on the board, three more cards will be added to the board. Once the time is up the game will alert you how many sets you found. If this was two player mode, the game will determine a winner. The game will result in a tie if both players found the same amount of sets.")
    print "Press enter to return to the previous screen: "
    gets
    print "\n"
  end
end

#Added by Adam Prater, 9/20/2016
#Wraps a string based on the width provided.
# @param [string] s
# @param [FixNum] width
# @return [string]
def wrap(s, width=180)
  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
end


#Starts the program by running the run method of the SetGame object.
if __FILE__ == $0
  program = SetGame.new
  program.run
end
