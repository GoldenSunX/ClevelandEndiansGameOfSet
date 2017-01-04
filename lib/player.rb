=begin
Created (Andrew Fox 2016-09-18): Class to group player attributes together.
=end
class Player

  attr_accessor :score, :player_number, :player_key

  #Created (Andrew Fox 2016-09-18): new method for creating the object with default values.
  def initialize(score = 0, player_number = 0, player_key = "1")
    @score = score
    @player_number = player_number
    @player_key = player_key
  end
end