class Pawn < Piece

  def symbol
    color == :white ? " \u2659 ".colorize(:white) : " \u265f ".colorize(:black)
  end

  def moves 
    move_dirs 
  end 
  
  def move_dirs 
    pos_moves = []

    forward_steps.each do |delta| 
      new_pos = check_delta(delta, pos)
      break unless new_pos
      pos_moves << new_pos
    end 

    side_attacks.each do |delta|
      new_pos = check_attack_delta(delta, pos)
      pos_moves << new_pos if new_pos 
    end
    pos_moves
  end


  private 

  def at_start_row?
    if color == :black 
      pos[0] == 1 
    else  
      pos[0] == 6
    end 
  end 

  def forward_dir 
    if color == :black
      1 
    else  
      -1 
    end 
  end 

  def forward_steps 
    if at_start_row? 
      [[forward_dir, 0], [forward_dir*2, 0]]
    else  
      [[forward_dir, 0]]
    end 
  end 

  def side_attacks 
    [[forward_dir, -1], [forward_dir, 1]]
  end 

   def check_delta(delta, pos)
    new_pos = [delta[0] + pos[0], delta[1] + pos[1]]
    return false unless board.valid_pos?(new_pos) 
    return false if board[new_pos].color != nil
    new_pos
  end

  def check_attack_delta(delta, pos)
    new_pos = [delta[0] + pos[0], delta[1] + pos[1]]
    return false unless board.valid_pos?(new_pos)
    return false unless enemy_piece?(new_pos)
    new_pos 
  end 

end