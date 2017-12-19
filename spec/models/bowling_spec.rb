require 'spec_helper'

RSpec.describe Bowling, type: :model do
  describe 'valid?' do
    it 'checks try1 range' do
      params = {try1: 11, try2: 0}
      game = Bowling.new(params, nil)
      expect(game.valid?).to be_falsey
      expect(game.error_message).to eq('Wrong input of pins: try 1')
    end

    it 'checks try2 range' do
      params = {try1: 1, try2: 11}
      game = Bowling.new(params, nil)
      expect(game.valid?).to be_falsey
      expect(game.error_message).to eq('Wrong input of pins : try 2')

      params = {try1: 1, try2: 9}
      game = Bowling.new(params, nil)
      expect(game.valid?).to be_truthy
    end

    it 'checks try1 and try2 range' do
      params = {try1: 2, try2: 9}
      game = Bowling.new(params, nil)
      expect(game.valid?).to be_falsey
      expect(game.error_message).to eq('Wrong sum of pins')

      params = {try1: 2, try2: 7}
      game = Bowling.new(params, nil)
      expect(game.valid?).to be_truthy
    end

    it 'checks for strike combination' do
      params = { try1: 10, try2: 0 }
      game = Bowling.new(params, nil)
      expect(game.strike?).to be_truthy

      params = { try1: 5, try2: 5 }
      game = Bowling.new(params, nil)
      expect(game.strike?).to be_falsey
    end

    it 'checks for spare combination' do
      params = { try1: 5, try2: 5 }
      game = Bowling.new(params, nil)
      expect(game.spare?).to be_truthy

      params = { try1: 5, try2: 4 }
      game = Bowling.new(params, nil)
      expect(game.spare?).to be_falsey
    end

    it 'calculate strike' do
      frames = [{spare: false, strike: true, score: 10}]
      params = { try1: 3, try2: 4 }
      game = Bowling.new(params, frames)
      game.calculate
      expect(game.total).to eq(24)
    end

    it 'calculate spare' do
      frames = [{spare: true, strike: false, score: 10}]
      params = { try1: 3, try2: 4 }
      game = Bowling.new(params, frames)
      game.calculate
      expect(game.total).to eq(20)
    end

    it 'finish the game after the last frame' do
      params = { try1: 3, try2: 4 }
      game = Bowling.new(params, nil)
      allow(game).to receive(:frame_number).and_return(10)
      expect(game.over?).to be_truthy

      params = { try1: 3, try2: 4 }
      game = Bowling.new(params, nil)
      allow(game).to receive(:frame_number).and_return(8)
      expect(game.over?).to be_falsey
    end

    it 'calulate the final score' do
      frames = [{score: 8}, {score: 9}, {score: 10}, {score: 10}, {score: 4}, {score: 9}]
      game = Bowling.new({}, frames)
      expect(game.total).to eq(50)
    end
  end
end
