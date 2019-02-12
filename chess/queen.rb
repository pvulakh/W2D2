require 'byebug'
class Queen < Piece
  include Slideable
  def symbol
    color == :white ? " \u2655 ".colorize(:white) : " \u265b ".colorize(:black)
  end

  protected
  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end