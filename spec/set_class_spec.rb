#Created (Adam Fox, 9/16): Spec to test the Set_Class class.
#Updated (Cole Alebrs, 9/20): Tersed and Cleaned Up Code.

require 'card'
require 'set_class'
require 'deck'

describe Set_class  do

  context 'with valid input' do

    it 'should return true when is_set and good_set are called' do
      card1 = Card.new 1, 'diamond', 'red', 'solid'
      card2 = Card.new 2, 'diamond', 'red', 'solid'
      card3 = Card.new 3, 'diamond', 'red', 'solid'
      test_set = Set_class.new card1, card2, card3
      expect(test_set.is_set?).to be true
      expect(test_set.good_set).to be true
    end

    it 'should return true when is_set and good_set are called' do
      card1 = Card.new 1, 'diamond', 'red', 'solid'
      card2 = Card.new 2, 'oval', 'green', 'empty'
      card3 = Card.new 3, 'squiggle', 'blue', 'lines'
      test_set = Set_class.new card1, card2, card3
      expect(test_set.is_set?).to be true
      expect(test_set.good_set).to be true
    end

    it 'should return true when is_set and good_set are called' do
      card1 = Card.new 1, 'diamond', 'red', 'solid'
      card2 = Card.new 1, 'oval', 'red', 'solid'
      card3 = Card.new 1, 'squiggled', 'red', 'solid'
      test_set = Set_class.new card1, card2, card3
      expect(test_set.is_set?).to be true
      expect(test_set.good_set).to be true
    end

    it 'should return true when is_set and good_set are called' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='diamond'
      card2.number = 1
      card2.color='green'
      card2.shading ='solid'
      card3.symbol='diamond'
      card3.number = 1
      card3.color='blue'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      expect(test_set.is_set?).to eq true
      expect(test_set.good_set).to eq true
    end

    #all unique shading, all other attributes identical
    it 'should return true' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='diamond'
      card2.number = 1
      card2.color='red'
      card2.shading ='empty'
      card3.symbol='diamond'
      card3.number = 1
      card3.color='red'
      card3.shading ='lines'
      test_set = Set_class.new(card1,card2,card3)
      expect(test_set.is_set?).to eq true
      expect(test_set.good_set).to eq true
    end

    #two attributes unique, two attributes identical
    it 'should return true' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='oval'
      card2.number = 2
      card2.color='red'
      card2.shading ='solid'
      card3.symbol='squiggle'
      card3.number = 3
      card3.color='red'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      expect(test_set.is_set?).to eq true
      expect(test_set.good_set).to eq true
    end

    #three attributes unique, on attribute identical
    it 'should return true' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='oval'
      card2.number = 2
      card2.color='green'
      card2.shading ='solid'
      card3.symbol='squiggle'
      card3.number = 3
      card3.color='blue'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      expect(test_set.is_set?).to eq true
      expect(test_set.good_set).to eq true
    end

    #numbers aren't unique or identical
    it 'should return false' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='diamond'
      card2.number = 2
      card2.color='red'
      card2.shading ='solid'
      card3.symbol='diamond'
      card3.number = 2
      card3.color='red'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      expect(test_set.is_set?).to eq false
      expect(test_set.good_set).to eq false
    end

    #numbers and symbols aren't unique or identical
    it 'should return false' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='diamond'
      card2.number = 2
      card2.color='red'
      card2.shading ='solid'
      card3.symbol='oval'
      card3.number = 2
      card3.color='red'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      expect(test_set.is_set?).to eq false
      expect(test_set.good_set).to eq false
    end

    #numbers,symbols, and colors aren't unique or identical
    it 'should return false' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='diamond'
      card2.number = 2
      card2.color='blue'
      card2.shading ='solid'
      card3.symbol='diamond'
      card3.number = 2
      card3.color='red'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      expect(test_set.is_set?).to eq false
      expect(test_set.good_set).to eq false
    end

    #all attributes aren't unique or identical
    it 'should return false' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='empty'
      card2.symbol='oval'
      card2.number = 2
      card2.color='red'
      card2.shading ='solid'
      card3.symbol='diamond'
      card3.number = 2
      card3.color='green'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      expect(test_set.is_set?).to eq false
      expect(test_set.good_set).to eq false
    end

    #calling clear on three complete cards
    it 'should return nil for all cards' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='oval'
      card2.number = 2
      card2.color='green'
      card2.shading ='solid'
      card3.symbol='squiggle'
      card3.number = 3
      card3.color='blue'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      test_set.clear
      expect(test_set.card1).to eq nil
      expect(test_set.card2).to eq nil
      expect(test_set.card3).to eq nil
    end

    #calling clear on two complete cards and one empty card
    it 'should return nil for all cards' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card2.symbol='oval'
      card2.number = 2
      card2.color='green'
      card2.shading ='solid'
      card3.symbol='squiggle'
      card3.number = 3
      card3.color='blue'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      test_set.clear
      expect(test_set.card1).to eq nil
      expect(test_set.card2).to eq nil
      expect(test_set.card3).to eq nil
    end

    #calling clear on one complete card and two empty cards
    it 'should return nil for all cards' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card3.symbol='squiggle'
      card3.number = 3
      card3.color='blue'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      test_set.clear
      expect(test_set.card1).to eq nil
      expect(test_set.card2).to eq nil
      expect(test_set.card3).to eq nil
    end

    #calling clear on three empty cards
    it 'should return nil for all cards' do
      card1,card2,card3=Card.new,Card.new,Card.new
      test_set = Set_class.new(card1,card2,card3)
      test_set.clear
      expect(test_set.card1).to eq nil
      expect(test_set.card2).to eq nil
      expect(test_set.card3).to eq nil
    end

    #clears cards then adds content to one
    it 'should return nil for all cards' do
      card1,card2,card3=Card.new,Card.new,Card.new
      card1.symbol='diamond'
      card1.number = 1
      card1.color='red'
      card1.shading ='solid'
      card2.symbol='oval'
      card2.number = 2
      card2.color='green'
      card2.shading ='solid'
      card3.symbol='squiggle'
      card3.number = 3
      card3.color='blue'
      card3.shading ='solid'
      test_set = Set_class.new(card1,card2,card3)
      test_set.clear
      new_card = Card.new
      new_card.symbol='diamond'
      new_card.number = 1
      new_card.color='red'
      new_card.shading ='solid'
      test_set.card1 = new_card
      expect(test_set.card1.color).to eq 'red'
      expect(test_set.card2).to eq nil
      expect(test_set.card3).to eq nil
    end
  end

  #Created (David Sinchok 9/18): Checks every combination of sets in a new Deck and counts valids sets.
  it 'calls #.is_set? on every combination of cards in a deck' do
    deck = Deck.new
    deckarray = deck.as_array
    count = 0

    (0..79).each do |i|
      card1 = deckarray[i]
      (i+1..79).each do |j|
        card2 = deckarray[j]
        (j+1..80).each do |k|
          card3 = deckarray[k]

          potential_set = Set_class.new(card1,card2,card3)
          count += 1 if potential_set.is_set?
        end
      end

    end
    expect(count).to eq 1080
  end
end