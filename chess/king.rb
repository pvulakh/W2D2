require "colorize"
class King < Piece 
include Stepable 
  
  def symbol 
    color == :white ? " \u2654 ".colorize(:white) : " \u265A ".colorize(:black)
  end

  protected
  def move_diffs
    [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1], [-1,1], [-1,-1]]
  end 

end 