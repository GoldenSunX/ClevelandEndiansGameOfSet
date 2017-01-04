#Created (David Sinchok, 9/14): Deck class that creates one of every card, resulting in 81 unique cards.
#Update (Cole Albers, 9/15): Created the add_card and as_array method.
#Update (Andrew Fox, 9/18): Added the clear function.
#Update (Cole Albers, 9/20): Standardized Documentation

require_relative 'card'

class Deck

  #self.cards is an array of all of the cards in the deck
  attr_accessor :cards

  #Created (David Sinchok, 9/14): Creates a Deck and Shuffles it.
  #Returns A Deck.
  def initialize
    @cards = Array.new
    temp_card = Card.new

    #nested for loops create one of every card
    (1..3).each do |i| 
      temp_card.number = i
      (1..3).each do |j|
        temp_card.symbol = 'diamond' if (j == 1)
        temp_card.symbol = 'oval' if (j == 2)
        temp_card.symbol = 'squiggle' if (j == 3)
        (1..3).each do |k|
          temp_card.shading = 'solid' if (k == 1)
          temp_card.shading = 'empty' if (k == 2)
          temp_card.shading = 'lines' if (k == 3)
          (1..3).each do |l|
            temp_card.color = 'red' if (l == 1)
            temp_card.color = 'green' if (l == 2)
            temp_card.color = 'blue' if (l == 3)

            #copies the contents of the card so that 81 aliases are not created
            copy_card = Card.new
            copy_card.number = temp_card.number
            copy_card.symbol = temp_card.symbol
            copy_card.color = temp_card.color
            copy_card.shading = temp_card.shading

            #pushes the copied version of the card
            @cards.push(copy_card)

          end
        end
      end
    end
    @cards = @cards.shuffle
  end

  #Created (David Sinchok, 9/14): Outputs the number of cards in the Deck.
  #Returns A Number.
  def size
    @cards.length
  end

  #Created (David Sinchok, 9/14): Outputs a Card from the Deck.
  #Returns Card Object
  def draw_card
    @cards.pop
  end

	#Created (Cole Albers, 9/15): Take the parameter and adds it to the deck.
  #Input Card Object
	def add_card(new_card)
    @cards.push new_card
  end

	#Created (Cole Albers, 9/15): Returns the deck as an array.
  #Returns An Array
  def as_array
    @cards
  end

  #Created (Andrew Fox, 9/18): Clears the deck
  def clear
    @cards.clear
  end
end
