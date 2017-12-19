class Bowling < ApplicationRecord
  attr_reader :error_message, :frame_number, :frame, :try1, :try2

  FRAMES = 10
  PINS   = 10

  def initialize(params, frame)
    @frame = frame.nil? ? [nil] : frame
    @try1 = params[:try1].to_i if params[:try1]
    @try2 = params[:try2].to_i if params[:try2]
    frame_number
  end

  def frame_number
    @frame_number ||= valid? ? frame.size : frame.size - 1
  end

  def calculate
    @frame[frame_number] = {spare: spare?, strike: strike?, score: calc_frame_score, try1: @try1, try2: @try2}
  end

  def total
    @frame.inject(0){|rez, item| item ? rez + item[:score] : rez }
  end

  def over?
    frame_number >= FRAMES + (frame_number == FRAMES && (strike? || spare?)  ? 1 : 0)
  end

  def strike?
    @try1 == PINS
  end

  def spare?
    @try1 + @try2 == PINS
  end

  def valid?
    @valid ||= begin
      @error_message = ''
      if !@try1 || !check_range(@try1)
        @error_message = 'Wrong input of pins: try 1'
        return
      end

      if (!strike? && !@try2) || !check_range(@try2)
        @error_message = 'Wrong input of pins : try 2'
        return
      end
      if !strike? && !check_range(@try1 + @try2)
        @error_message = 'Wrong sum of pins'
        return
      end
      true
    end
  end

  private

  def calc_frame_score
    prev_frame = frame[frame_number - 1]
    if prev_frame && (prev_frame[:strike] || prev_frame[:spare])
      frame[frame_number - 1][:score] = PINS + @try1 + (prev_frame[:strike] ? @try2 : 0)
    end
    @try1 + @try2
  end

  def check_range(num)
    (0..PINS) === num
  end
end
