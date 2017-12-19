module BowlingHelper

  def score_cells
    scores = ''
    @game.frame.each{|frame| scores += "<td>#{frame[:score]}</td>" if frame}
    scores
  end

  def try1_cells
    try1 = ''
    @game.frame.each{|frame| try1 += "<td>#{frame[:try1]}</td>" if frame}
    try1
  end

  def try2_cells
    try2 = ''
    @game.frame.each{|frame| try2 += "<td>#{frame[:try2]}</td>" if frame}
    try2
  end

  def frame_cells
    header = ''
    (1..@game.frame_number).each{|frame| header += "<td>##{frame}</td>"}
    header
  end
end
