require_relative "piece"
require_relative "nullpiece"
class Board 
  attr_reader :grid 
  
  def initialize  
    @grid = Array.new(8) { [] }
    populate_grid
  end
  


  def move_piece(start_pos, end_pos)
    raise InvalidPosError unless valid_pos?(end_pos)
    raise NoPieceToMoveError if self[start_pos].is_a?(NullPiece)
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    color = self[start_pos].color
    raise MoveIntoCheck unless valid_moves(color)[start_pos].include?(end_pos) #check if end_pos puts us in_check
    self[end_pos].pos = end_pos
  end 

  def valid_pos?(pos)
    row, col = pos 
    row.between?(0, 7) && col.between?(0, 7) 
  end

  def [](pos)
    row, col = pos 
    self.grid[row][col]
  end

  def []=(pos, val)
    row, col = pos 
    self.grid[row][col] = val 
  end 

  def in_check?(color)
    kp = king_pos(color)
    get_moves(opposite_color(color)).include?(kp)
  end

  def checkmate?(color)
    return false unless in_check?(color)
    return false unless valid_moves(color).values.all?(&:empty?)
    true 
  end 

  ## redefine valid_moves such that moves take us out of check

  def valid_moves(color)
    valids = Hash.new { |h,k| h[k] = [] }
    pieces = piece_to_pos(color)
    pieces.each do |start_pos,end_pos|
      end_pos.each do |pos|
        new_board = dup 
        new_board.move_piece(start_pos, pos)
        valids[start_pos] << pos unless new_board.in_check?(color)
      end
    end
    valids 
  end

  private

  def dup
    Marshal.load(Marshal.dump(self))
  end

  def king_pos(color)
    grid.each_with_index do |row, row_idx|
      row.each_index do |col|
        if row[col].is_a?(King) && row[col].color == color
          return [row_idx, col]
        end 
      end 
    end
  end

  def get_moves(color) 
    get_pieces(color).map { |piece| piece.moves }.flatten(1)
  end

  def get_pieces(color)
    grid.flatten.select { |piece| piece.color == color } 
  end 

  def piece_to_pos(color)
    result = Hash.new
    get_pieces(color).each { |piece| result[piece.pos] = piece.moves }
    result 
  end

  def opposite_color(color)
    color == :white ? :black : :white
  end

  def populate_grid 
    grid.each.with_index do |row, idx|
      if idx == 0
        (0..7).each do |col_idx| 
          case col_idx
          when 0, 7
            row[col_idx] = Rook.new(:black, self, [idx, col_idx])
          when 1, 6
            row[col_idx] = Knight.new(:black, self, [idx, col_idx])
          when 2,5
            row[col_idx] = Bishop.new(:black, self, [idx, col_idx])
          when 3
            row[col_idx] = Queen.new(:black, self, [idx, col_idx])
          when 4 
            row[col_idx] = King.new(:black, self, [idx, col_idx])
          end 
        end 
      elsif idx == 1 
        (0..7).each {|col_idx| row[col_idx] = Pawn.new(:black, self, [idx, col_idx])}
      elsif idx == 6
        (0..7).each {|col_idx| row[col_idx] = Pawn.new(:white, self, [idx, col_idx])}
      elsif idx == 7
        (0..7).each do |col_idx| 
          case col_idx
          when 0, 7
            row[col_idx] = Rook.new(:white, self, [idx, col_idx])
          when 1, 6
            row[col_idx] = Knight.new(:white, self, [idx, col_idx])
          when 2,5
            row[col_idx] = Bishop.new(:white, self, [idx, col_idx])
          when 3
            row[col_idx] = Queen.new(:white, self, [idx, col_idx])
          when 4 
            row[col_idx] = King.new(:white, self, [idx, col_idx])
          end 
        end 
      else 
        np = NullPiece.instance  
        8.times { row << np }
      end 
    end 
  end 
end 

class InvalidPosError < StandardError; end 
class NoPieceToMoveError < StandardError; end 
class MoveIntoCheck < StandardError; end




