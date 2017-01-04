#Created (Andrew Fox, 9/18): Spec for testing the GameUtils class.
#Update (Cole Albers, 9/20): Standardized Documentation and fixed minor bug.

require 'game_utils'
require 'test_utils'
require 'player'
require 'core_extensions'
String.include CoreExtensions::String

describe GameUtils, "#get_valid_option_number" do

  context "with 1 as min and 2 as max" do
    it "returns the valid input value of 1 and prints no errors" do
      allow(STDIN).to receive(:gets) { "1\n" }
      output = TestUtils.get_standard_output { GameUtils.get_valid_option_number 1, 2 }
      expect(output).to eq ""
      allow(STDIN).to receive(:gets) { "1\n" }
      expect(GameUtils.get_valid_option_number 1, 2).to eq 1
    end

    it "returns the valid input value of 2 and prints no errors" do
      allow(STDIN).to receive(:gets) { "2\n" }
      output = TestUtils.get_standard_output { GameUtils.get_valid_option_number 1, 2 }
      expect(output).to eq ""
      allow(STDIN).to receive(:gets) { "2\n" }
      expect(GameUtils.get_valid_option_number 1, 2).to eq 2
    end
  end

  context "with 0 as min and 25 as max" do
    it "returns the valid input of 0 and prints no errors" do
      allow(STDIN).to receive(:gets) { "0\n" }
      output = TestUtils.get_standard_output { GameUtils.get_valid_option_number 0, 25 }
      expect(output).to eq ""
      allow(STDIN).to receive(:gets) { "0\n" }
      expect(GameUtils.get_valid_option_number 0, 25).to eq 0
    end
  end

  context "with 0 as min and 5 as max" do
    it "prints the invalid input message and continues until a valid input is received" do
      allow(STDIN).to receive(:gets).and_return("6\n", "2\n")
      output = TestUtils.get_standard_output { GameUtils.get_valid_option_number 0, 5 }
      expect(output).to eq "Invalid input, please try again: "
      allow(STDIN).to receive(:gets).and_return("6\n", "2\n")
      expect(GameUtils.get_valid_option_number 0, 5).to eq 2
    end

    it "prints the invalid input message twice and then returns the final valid input" do
      allow(STDIN).to receive(:gets).and_return("4.6\n", "-1\n", "2\n")
      output = TestUtils.get_standard_output { GameUtils.get_valid_option_number 0, 5 }
      expect(output).to eq "Invalid input, please try again: Invalid input, please try again: "
      allow(STDIN).to receive(:gets).and_return("4.6\n", "-1\n", "2\n")
      expect(GameUtils.get_valid_option_number 0, 5).to eq 2
    end
  end
end

describe GameUtils, "#get_valid_player_key" do
  context "with 1 player" do
    players = Array.new
    deck = Deck.new
    board = Board.new deck
    pos = 0
    while pos < 1
      players[pos] = Player.new
      players[pos].score = 0
      players[pos].player_number = pos + 1
      if pos == 0
        players[pos].player_key = '1'
      else
        players[pos].player_key = '0'
      end
      pos += 1
    end

    it " is given a value of '1\n' and should return the first player" do
      allow(STDIN).to receive(:gets).and_return("1\n")
      expect(GameUtils.get_valid_player_key players, board).to eq players[0]
    end

    it " is given a value of '0\n' and '1\n' and should return the first player after failing once." do
      allow(STDIN).to receive(:gets).and_return("0\n", "1\n")
      expect(GameUtils.get_valid_player_key players, board).to eq players[0]
    end
  end

  context "with 2 players" do
    players = Array.new
    deck = Deck.new
    board = Board.new deck

    pos = 0
    while pos < 2
      players[pos] = Player.new
      players[pos].score = 0
      players[pos].player_number = pos + 1
      if pos == 0
        players[pos].player_key = '1'
      else
        players[pos].player_key = '0'
      end
      pos += 1
    end

    it " is given a value of '1\n' and should return the first player" do
      allow(STDIN).to receive(:gets).and_return("1\n")
      expect(GameUtils.get_valid_player_key players, board).to eq players[0]
    end

    it " is given a value of '0\n' and should return the second player" do
      allow(STDIN).to receive(:gets).and_return("0\n", "1\n")
      expect(GameUtils.get_valid_player_key players, board).to eq players[1]
    end

    it " is given a value of '4\n' and '0\n' should return the second player" do
      allow(STDIN).to receive(:gets).and_return("4\n", "0\n")
      expect(GameUtils.get_valid_player_key players, board).to eq players[1]
    end
  end
end

describe GameUtils, "#get_valid_yes_no" do
  context "with invalid input" do
    it " with '7\n' and 'n\n' as input should fail then return false" do
      allow(STDIN).to receive(:gets).and_return("7\n", "n\n")
      expect(GameUtils.get_valid_yes_no).to eq false
    end

    it " with '7\n' and 'y\n' as input should fail then return true" do
      allow(STDIN).to receive(:gets).and_return("7\n", "y\n")
      expect(GameUtils.get_valid_yes_no).to eq true
    end
  end

  context "with valid input" do
    it " with 'n\n' as input should return false" do
      allow(STDIN).to receive(:gets).and_return("n\n")
      expect(GameUtils.get_valid_yes_no).to eq false
    end

    it " with 'y\n' as input should return true" do
      allow(STDIN).to receive(:gets).and_return("y\n")
      expect(GameUtils.get_valid_yes_no).to eq true
    end

    it " with 'N\n' as input should return false" do
      allow(STDIN).to receive(:gets).and_return("N\n")
      expect(GameUtils.get_valid_yes_no).to eq false
    end

    it " with 'Y\n' as input should return true" do
      allow(STDIN).to receive(:gets).and_return("Y\n")
      expect(GameUtils.get_valid_yes_no).to eq true
    end
  end
end
