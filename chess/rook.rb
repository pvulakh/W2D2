require_relative "piece"

class Rook < Piece 
  include Slideable

  def symbol
    color == :white ? " \u2656 ".colorize(:white) : " \u265c ".colorize(:black)
  end

  protected
  def move_dirs
    horizontal_dirs
  end
end