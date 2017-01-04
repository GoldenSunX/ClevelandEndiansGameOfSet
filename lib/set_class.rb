#Created (Adam Prater, 2016-09-14): Class that contains what the user thinks is a set and contains method to verify
#Updated (David Sinchok, 2016-09-20): Standardized documentation
#Purpose: create a Set_class object passing in the cards the player selected
#Requires: card1,card2,card3 != nil to use methods

require_relative 'card'

class Set_class

  attr_accessor  :card1, :card2, :card3, :good_set

  #Created by adam prater, 9/15/16
  #initializes three cards that may or may not make up a set
  def initialize(card1 = nil, card2 = nil, card3 = nil)
    @card1 = card1
    @card2 = card2
    @card3 = card3
    @good_set
  end

  #Created by adam prater, 9/15/16
  #verifies appropriate attribute combination to be a set
  # @param [string] attr1
  # @param [string] attr2
  # @param [string] attr3
  # @return [boolean]
  def correct_combination?(attr1, attr2, attr3)
    result = false
    if attr1 == attr2 && attr2 == attr3
      result = true
    elsif attr1 != attr2 && attr2 != attr3 && attr1 != attr3
      result = true
    end
    return result
  end

  #only allow correct_combination? to call
  private :correct_combination?

  #Created by adam prater, 9/15/16
  #Updated (Cole Albers, 9/19): Fixed minor bug
  #calls correct_combination? to check for valid sets, returns true or false
  # @return [boolean]
  def is_set?
    result = true
    result = false unless correct_combination?@card1.color,@card2.color,@card3.color
    result = false unless correct_combination?@card1.number,@card2.number,@card3.number
    result = false unless correct_combination?@card1.symbol,@card2.symbol,@card3.symbol
    result = false unless correct_combination?@card1.shading,@card2.shading,@card3.shading
    @good_set = result
    result
  end

  #Created by adam prater, 9/15/16
  #sets all cards equal to nil
  def clear
    @card1 = nil
    @card2 = nil
    @card3 = nil
  end
end
