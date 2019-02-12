class Knight < Piece 
include Stepable 

  def symbol 
    color == :white ? " \u2658 ".colorize(:white) : " \u265e ".colorize(:black)
  end
  
  protected
  def move_diffs
    [[-2,1], [-1,2], [1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1]]
  end 

end 