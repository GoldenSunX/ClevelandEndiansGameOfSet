#Created (Sam Yinger 9/17): Spec used to test the Board class.
#Update (Cole Albers, 9/20): Standardized Code.

require 'deck'
require 'card'
require 'set_board'

describe Board do

  before(:each) do
    @deck = Deck.new
    @board = Board.new @deck
  end

  context 'with valid input' do

    it 'should initialize a Board of size 18 with Cards when the new method is called' do
      expect(@board.size).to eq 18
    end

    it 'should initialize a Board of size 18 with nils when the clear_board method is called' do
      @board.clear_board
      empty, index = true, 0
      while index < 18
       empty = false unless @board.array_of_cards[index] == nil
       index += 1
      end
      expect(empty).to be true
    end

    it 'should initialize a Board of size 18 with 12 unique Cards when the new method is called' do
      card_spots = Array.new
      index=0
      while index < 12
        card_spots[index] = @board.array_of_cards[index]
        index+=1
      end
      expect(card_spots.uniq.size).to eq 12
    end

    it 'should restock empty spots on the Board when restock_cards is called' do
      @board.array_of_cards[2], @board.array_of_cards[6], @board.array_of_cards[7], set_added = nil, nil, nil, true
      @board.restock_cards @deck
      set_added = false if @board.array_of_cards[2] == nil or @board.array_of_cards[6] == nil or @board.array_of_cards[7] == nil
      expect(set_added).to be true
    end

    it 'should adds 3 unique Cards to the Board when 12 Cards are present when restock_cards is called' do
      set_added = true
      @board.restock_cards @deck
      set_added = false if @board.array_of_cards[12] == nil or @board.array_of_cards[13] == nil or @board.array_of_cards[14] == nil
      expect(set_added).to be true
    end

    it 'should add 3 unique Cards to the Board when 15 Cards are present when restock_cards is called' do
      set_added = true
      @board.restock_cards @deck
      @board.restock_cards @deck
      set_added = false if @board.array_of_cards[15] == nil or @board.array_of_cards[16] == nil or @board.array_of_cards[17] == nil
      expect(set_added).to be true
    end

    it 'should tell whether the Board of 3 unique Cards has a set when set_exists is called' do
      card1 = Card.new 'diamond', 1, 'red', 'solid'
      card2 = Card.new 'diamond', 1, 'green', 'solid'
      card3 = Card.new 'diamond', 1, 'blue', 'solid'
      @board.clear_board
      @board.array_of_cards[0], @board.array_of_cards[1], @board.array_of_cards[2] = card1, card2, card3
      @board.number_of_cards = 3
      expect(@board.set_exists).to be true
    end

    it 'should tell whether the Board of 3 non-unique Cards has a set when set_exists is called' do
      card1 = Card.new 'squiggle', 1, 'green', 'solid'
      card2 = Card.new 'diamond', 1, 'green', 'solid'
      card3 = Card.new 'diamond', 1, 'blue', 'solid'
      @board.clear_board
      @board.array_of_cards[0], @board.array_of_cards[1], @board.array_of_cards[2] = card1, card2, card3
      @board.number_of_cards = 3
      expect(@board.set_exists).to be false
    end

      it 'should tell whether the Board of 6 non-unique Cards has a set when set_exists is called' do
        card1 = Card.new 'squiggle', 1, 'green', 'solid'
        card2 = Card.new 'diamond', 1, 'green', 'solid'
        card3 = Card.new 'diamond', 1, 'blue', 'solid'
        @board.clear_board
        @board.array_of_cards[0], @board.array_of_cards[3] = card1, card1
        @board.array_of_cards[1], @board.array_of_cards[4] = card2, card2
        @board.array_of_cards[2], @board.array_of_cards[5] = card3, card3
        @board.number_of_cards = 6
        expect(@board.set_exists).to be false
      end

    it 'should tell whether the Board of 9 unique Cards has a set when set_exists is called' do
      card1 = Card.new 'squiggle', 1, 'green', 'solid'
      card2 = Card.new 'diamond', 1, 'green', 'solid'
      card3 = Card.new 'diamond', 1, 'blue', 'solid'
      card4 = Card.new 'diamond', 1, 'red', 'solid'
      card5 = Card.new 'diamond', 2, 'red', 'solid'
      card6 = Card.new 'diamond', 3, 'red', 'solid'
      @board.clear_board
      @board.array_of_cards[0], @board.array_of_cards[3] = card1, card1
      @board.array_of_cards[1], @board.array_of_cards[4] = card2, card2
      @board.array_of_cards[2], @board.array_of_cards[5] = card3, card3
      @board.array_of_cards[6], @board.array_of_cards[7], @board.array_of_cards[8] = card4, card5, card6
      @board.number_of_cards = 9
      expect(@board.set_exists).to be true
    end

    it 'should print out the first card in a set when card_set_hint is called' do
      card1 = Card.new 'diamond', 1, 'red', 'solid'
      card2 = Card.new 'diamond', 1, 'green', 'solid'
      card3 = Card.new 'diamond', 1, 'blue', 'solid'
      @board.clear_board
      @board.array_of_cards[0], @board.array_of_cards[1], @board.array_of_cards[2] = card1, card2, card3
      @board.number_of_cards = 3
      @board.set_exists
      hint_card = 'This card is part of a set: ' + card1.description + "\n"
      expect(@board.card_set_hint).to eq hint_card
    end

    it 'should not restock the Cards on the Board of size 12 when restock_cards is called' do
      @board.restock_cards @deck
      card_a = @board.get_card 1
      card_b = @board.get_card 13
      card_c = @board.get_card 10
      @board.remove_set card_a, card_b, card_c
      @board.restock_cards @deck unless @board.number_of_cards >= 12
      expect(@board.number_of_cards).to eq 12
    end

    it 'should not restock the Cards on the Board of size 15 when restock_cards is called' do
      @board.restock_cards @deck
      @board.restock_cards @deck
      card_a = @board.get_card 1
      card_b = @board.get_card 13
      card_c = @board.get_card 10
      @board.remove_set card_a, card_b, card_c
      @board.restock_cards @deck unless @board.number_of_cards >= 12
      expect(@board.number_of_cards).to eq 15
    end
  end
end
