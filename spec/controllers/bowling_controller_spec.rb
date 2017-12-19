require 'spec_helper'

RSpec.describe BowlingController, type: :controller do

  describe 'GET #new' do
    before(:each) do
      get :new
    end

    it 'redirects to a new game' do
      expect(response).to redirect_to('/bowling')
    end

    it 'resets the frames of the previous game' do
      expect(session[:frame]).to eq(nil)
    end
  end

  describe 'GET #index' do
    it 'renders index page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #frame' do
    let(:game) { double(Bowling) }

    before(:each) do
      expect(Bowling).to receive(:new).and_return(game)
    end

    it 'when frame data is valid' do
      expect(game).to receive(:valid?).and_return(true)
      expect(game).to receive(:calculate).and_return(true)
      expect(game).to receive(:over?).and_return(true)
      post :frame, params: { try1: 5, try2: 4, frame_number: 0 }
    end

    it 'flashes an error message when frame data is not valid' do
      expect(game).to receive(:valid?).and_return(false)
      expect(game).to receive(:error_message).and_return('Error')
      expect(game).to receive(:over?).and_return(true)

      post :frame
      expect(flash[:error]).to eq('Error')
    end
  end
end
