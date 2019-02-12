class Bishop < Piece
  include Slideable

  def symbol
    color == :white ? " \u2657 ".colorize(:white) : " \u265d ".colorize(:black)
  end

  protected
  def move_dirs
    diagonal_dirs
  end
end