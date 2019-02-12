require 'byebug'
module Slideable
  HORIZONTAL_DIRS = [[0,1],[0,-1],[1,0],[-1,0]]
  DIAGONAL_DIRS = [[1,1], [1,-1], [-1,1], [-1,-1]]

  def horizontal_dirs 
    make_moves(HORIZONTAL_DIRS)
  end 

  def diagonal_dirs 
    make_moves(DIAGONAL_DIRS)
  end

  def moves 
    move_dirs
  end

  # loop logic
  def make_moves(constant)
    pos_moves = []
    next_pos = pos 
    constant.each do |dir|
      while grow_unblocked_moves_in_dir(dir, next_pos)
        next_pos = grow_unblocked_moves_in_dir(dir, next_pos)
        pos_moves << next_pos
        if enemy_piece?(next_pos)
          break
        end 
      end 
      next_pos = pos 
      next
    end 
    pos_moves 
  end 


  private 

  def move_dirs 
    #raise an exception
    raise 'define a #move_dirs method!!'
  end

  def grow_unblocked_moves_in_dir(delta, pos)
    new_pos = [delta[0] + pos[0], delta[1] + pos[1]]
    return false unless board.valid_pos?(new_pos) 
    return false if board[new_pos].color == self.color
    new_pos
  end


end