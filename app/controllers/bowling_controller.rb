class BowlingController < ApplicationController

  def frame
    @game = Bowling.new(bowl_params, session[:frame])
    if @game.valid?
      @game.calculate
    else
      flash[:error] = @game.error_message
    end
    session[:frame] = @game.over? ? nil : @game.frame
  end

  def new
    session[:frame] = nil
    redirect_to '/bowling'
  end

  private

  def bowl_params
    params.permit(:try1, :try2, :frame_number)
  end
end
