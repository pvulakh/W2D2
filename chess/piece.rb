require_relative 'board'
class Piece 
  attr_accessor :pos 
  attr_reader :board, :color
  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos  
  end

  def moves 
    []
  end

  def enemy_piece?(pos)
    !board[pos].is_a?(NullPiece) && board[pos].color != color 
  end

end 

# modules slide & step 
# classes for each individual piece
# moves implemented in module; move_dirs will specify which set of moves

