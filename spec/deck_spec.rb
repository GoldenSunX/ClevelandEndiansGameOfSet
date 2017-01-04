#Created (Cole Albers, 9/15): Spec used to test the Deck class.
#Update (Cole Albers, 9/20): Minimized and Cleaned Up Deck class.

require 'deck'
require 'card'

describe Deck do

  before(:each) do
    @deck = Deck.new
  end

  context 'with valid input' do

    it 'should output a size of 81 when size is called' do
        expect(@deck.size).to eq 81
    end

    it 'should output a Card from the Deck when remove_card is called' do
      expect(@deck.draw_card).to be_an_instance_of Card
    end

    it 'should add a new Card to the Deck when add_card is called' do
      @deck.add_card Card.new
      expect(@deck.size).to eq 82
    end

    it 'should return the Deck as an Array when as_array is called' do
      expect(@deck.as_array).to be_an_instance_of Array
    end

    it 'should output an Array of 81 unique Cards when new is called' do
      array_deck = @deck.as_array
      position = 0
      until position == array_deck.length - 1
        counter = position + 1
        card_desc = array_deck[position].description
        until counter == array_deck.length
          temp_desc = array_deck[counter].description
          expect(card_desc).not_to eq temp_desc
          counter += 1
        end
        position += 1
      end
    end
  end
end
