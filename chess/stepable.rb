module Stepable

  def moves 
    move_diffs.map do |diff|
      add(diff, pos) || nil 
    end.compact
  end

  private

  def add(delta, pos)
    new_pos = [delta[0] + pos[0], delta[1] + pos[1]]
    return false unless board.valid_pos?(new_pos) 
    return false if board[new_pos].color == self.color

    new_pos 
  end 
end