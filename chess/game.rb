#there will be entryfile
require_relative "player"

class Game
  attr_reader :board, :display, :players 

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = [Player.new(:white, @display), Player.new(:black, @display)]
  end 

  #until checkmate
  #p1 turn #first turn ever
  #move piece on board
  #take_turn (switch players)

  def play 
    until self.game_over?
      self.display.loop_render
      move = take_turn #returns tuple of startpos, endpos from player via taketurn
      board.move_piece(move)
      switch_players
    end 
  end 

  def take_turn 
    current_player.prompt 
  end

  def switch_players
    self.players.rotate!
  end

  def current_player
    self.players.first
  end


  def game_over?
    self.board.checkmate?(:white) || self.board.checkmate?(:black)
  end 
end