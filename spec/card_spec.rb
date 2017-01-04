#Created (Cole Albers, 9/15): Spec used to test the Card class.
#Update (Cole Albers, 9/20): Tersed and Cleaned Up Code.

require 'card'

describe Card do

  before(:each) do
    @card = Card.new
  end

  context 'with valid input' do

    it 'should create a Card when new is called' do
      expect(@card).to be_instance_of Card
    end

    it 'should set the number, symbol, color, shading on the Card when attr_accessor is called' do
      @card.number = 1
      @card.symbol = 'diamond'
      @card.color = 'red'
      @card.shading = 'empty'
      expect(@card.number).to eq 1
      expect(@card.symbol).to eq 'diamond'
      expect(@card.color).to eq 'red'
      expect(@card.shading).to eq 'empty'
    end

    it 'should output a description of the Card when description is called' do
      @card.number = 1
      @card.symbol = 'diamond'
      @card.color = 'red'
      @card.shading = 'empty'
      expect(@card.description).to eq '1, diamond, red, empty'
    end
  end
end

