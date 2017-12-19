require 'spec_helper'

RSpec.describe BowlingHelper, type: :helper do
  before(:each) do
    @game = double(Bowling)
  end

  describe '#score_cells' do
    it 'returns current score' do
      frame = [{score: 1}, {score: 2}, {score: 3}]
      allow(@game).to receive(:frame).and_return(frame)
      expect(helper.score_cells).to eq('<td>1</td><td>2</td><td>3</td>')
    end
  end

  describe '#frame_cells' do
    it 'Returns frame cells' do
      allow(@game).to receive(:frame_number).and_return(3)
      expect(helper.frame_cells).to eq('<td>#1</td><td>#2</td><td>#3</td>')
    end
  end

  describe '#try1_cells' do
    it 'Returns frame cells' do
      frame = [{try1: 5}, {try1: 6}, {try1: 7}]
      allow(@game).to receive(:frame).and_return(frame)
      expect(helper.try1_cells).to eq('<td>5</td><td>6</td><td>7</td>')
    end
  end

  describe '#try2_cells' do
    it 'Returns frame cells' do
      frame = [{try2: 5}, {try2: 6}, {try2: 7}]
      allow(@game).to receive(:frame).and_return(frame)
      expect(helper.try2_cells).to eq('<td>5</td><td>6</td><td>7</td>')
    end
  end
end
