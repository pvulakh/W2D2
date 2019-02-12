class Player 
  attr_reader :color, :display
  def initialize(color, display)
    @color, @display = color, display 
  end

  def prompt
    puts "Choose which piece to move !"
    start_pos = display.cursor.get_input
    puts "Move to where ?"
    end_pos = display.cursor.get_input
    [start_pos, end_pos]
  end

end 