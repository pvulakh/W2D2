require_relative "board"
require_relative "cursor"
require "colorize"
require "colorized_string"
class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board, @cursor = board, Cursor.new([0,0], board)
  end

  def render
    self.board.grid.each_with_index do |row, row_idx|
      render_row = []
      row.each_with_index do |piece, col|
        if self.cursor.cursor_pos == [row_idx, col]
          if self.cursor.selected 
            render_row << piece.symbol.colorize(:background => :green)
          else  
            render_row << piece.symbol.colorize(:background => :red)
          end 
        elsif (row_idx + col).even?
          render_row << piece.symbol.colorize(:background => :light_white)
        else 
          render_row << piece.symbol.colorize(:background => :light_black)
        end
      end 
      puts render_row.join("")
    end 
    nil
  end

  def list_methods
    p ColorizedString.colors 
    p ColorizedString.modes 
  end 

  def loop_render
    until cursor.get_input
      self.render 
      self.cursor.get_input
      system("clear")
    end 
  end 
end 

