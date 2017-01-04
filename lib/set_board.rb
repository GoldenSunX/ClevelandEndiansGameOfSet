#Created (Sam Yinger 2016-09-18): Board that when initialized contains the cards that are in play and can be matched to make sets.
#Updated (Andrew Fox, 2016-09-18): Added get_card method

require_relative 'card'
require_relative 'deck'
require_relative 'set_class'

class Board

  #Param array_of_cards: an array that represents the board at any given moment
  #Param number_of_cards: represents the number of cards that
  #Param example_set: represents an array of cards that are in a set
  attr_accessor :array_of_cards, :number_of_cards, :example_set

  #Initializes an array of 'cards' that are in play
  def initialize(deck)
    #instance variables for the class set
    @number_of_cards=0
    @example_set=Array.new
    @array_of_cards=Array.new
    clear_board
    while @number_of_cards<12
      @array_of_cards[@number_of_cards]=deck.draw_card
      @number_of_cards+=1
    end
  end

  #Created (Sam Yinger 2016-09-19): Erases the cards on the board and fills all the spots with nil
  #Returns the board with 18 empty spots
  def clear_board
    index=0
    while index<18
      @array_of_cards[index]=nil
      index+=1
    end
    @number_of_cards=0
  end

  #Created (Sam Yinger 2016-09-18): Adds three more cards to the board
  #Returns an array with three more cards to the board array
  #Requires the board to have less than 12 cards or have no set
  def restock_cards(deck)
    index_a=0
    index_b=0
    empty_spots=0
    fill_spot=Array.new
    while index_a < @array_of_cards.length
      if @array_of_cards[index_a]==nil
        empty_spots+=1
        fill_spot[index_b]=index_a
        index_b+=1
      end
      index_a+=1
    end
    if empty_spots>0
      @array_of_cards[fill_spot[0]]=deck.draw_card
      @array_of_cards[fill_spot[1]]=deck.draw_card
      @array_of_cards[fill_spot[2]]=deck.draw_card
      @number_of_cards+=3
    else
      @array_of_cards[@number_of_cards-1]=deck.draw_card
      @number_of_cards+=1
      @array_of_cards[@number_of_cards-1]=deck.draw_card
      @number_of_cards+=1
      @array_of_cards[@number_of_cards-1]=deck.draw_card
      @number_of_cards+=1
    end
  end

  #Created (Sam Yinger 2016-09-18): Gives the player a card that is part of a set
  #Updated: (Andrew Fox, 2016-09-19): Changed to remove each card and put into separate position in returned array.
  #Returns a set of the cards removed that represent a set
  def remove_set (card_a,card_b,card_c)
    removed_set=Array.new
    spot=@array_of_cards.index(card_a)
    @array_of_cards[spot]=nil
    @number_of_cards-=1
    removed_set[0]=card_a
    spot=@array_of_cards.index(card_b)
    @array_of_cards[spot]=nil
    @number_of_cards-=1
    removed_set[1]=card_b
    spot=@array_of_cards.index(card_c)
    @array_of_cards[spot]=nil
    @number_of_cards-=1
    removed_set[2]=card_c
  end

  #Created (Sam Yinger 2016-09-18): Gives the player a card that is part of a set
  #Updated (Andrew Fox 2016-09-18): Fixed to add numbers before card and properly print newline
  #Output prints out the board with one card description per line and gives each line a number
  def print_board
    index=0
    card_no=1
    while index<@array_of_cards.size
      if @array_of_cards[index] != nil
        if index < 9
          print (card_no).to_s + '.  ' + @array_of_cards[index].description + "\n"
        else
          print (card_no).to_s + '. ' + @array_of_cards[index].description + "\n"
        end
        card_no+=1
      end
      index+=1
    end
  end

  #Created (Sam Yinger 9/19): Determines whether a set exists in the given board while populating an array for that set
  #Updated (Andrew Fox 9/20): Fixed case where the card might be nil
  #Returns the boolean of whether a set exists or not
  def set_exists
    index_a=0
    set_existence=false
    while index_a<@number_of_cards
      index_b=index_a+1
      card1=@array_of_cards[index_a]
      while card1 != nil && index_b<@number_of_cards
        index_c=index_b+1
        card2=@array_of_cards[index_b]
        while card2 != nil && index_c<@number_of_cards
          card3=@array_of_cards[index_c]
          if card3 != nil
            set=Set_class.new(card1, card2, card3)
            if set.is_set?
              set_existence=set.is_set?
              @example_set[0],@example_set[1],@example_set[2]=card1,card2,card3
            end
          end
          index_c+=1
        end
        index_b+=1
      end
      index_a+=1
    end
    set_existence
  end

  #Created (Sam Yinger 2016-09-18): Gives the player a card that is part of a set
  #Updated (Andrew Fox 2016-09-18): Fixed newline character not printing properly.
  #Requires set_exists to be called right before this method
  #Output returns the print out of a card that is a part of a single set
  #Returns the string of a card that is a part of a single set
  def card_set_hint
    set_hint='This card is part of a set: ' + @example_set[0].description + "\n"
    print ('This card is part of a set: ' + @example_set[0].description + "\n")
    set_hint
  end

  #Created (Andrew Fox 9/18): Returns the card on the board at index @index
  #Param input: int representing a cards place on the board
  #Returns the card at the spot indicated by the index in the board array
  def get_card(index)
    @array_of_cards[index]
  end

  #Created (Sam Yinger 2016-09-20): Gives the player three cards that are in a set
  #Requires set_exists to be called right before this method
  #Output returns the print out of the set
  #Returns the string of a set that exists
  def print_hint_array

    if self.set_exists
      index=0
      card_no=1
      while index<3
        print (card_no).to_s + ' Hint. ' + @example_set[index].description + "\n"
        card_no+=1
        index+=1
      end
    else
      print "No set\n"
    end
  end

  #Returns the size fo the board
  def size
    @array_of_cards.size
  end
end