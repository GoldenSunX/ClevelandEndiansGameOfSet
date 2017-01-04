#Created (David Sinchok 9/14): Card class that represesnts each individual card.
#Update (Cole Albers, 9/15): Added the description method.
#Update (Cole Albers, 9/20): Updated Documentation.

class Card
  attr_accessor :number, :symbol, :shading, :color

  #Created (Cole Albers, 9/20): Initialize the Card
  #Input A number, symbol, shading, and color (all optional)
  #Returns A Card Object
  def initialize(number = nil, symbol = nil, shading = nil, color = nil)
    @number = number
    @symbol = symbol
    @shading = shading
    @color = color
  end

	#Created (Cole Albers, 9/15)
	#Returns The number, symbol, color, and shading of the card as a string.
	def description
    "#{@number}, #{@symbol}, #{@color}, #{@shading}"
  end


end
