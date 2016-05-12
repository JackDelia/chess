require_relative 'board'
require_relative 'human_player'

class Game
  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @player2.color = :b
    @current_player = player1
  end

  def take_turn
    input = nil
    while input.nil?
      puts @current_player.name
      @current_player.render(@board)
      input = @current_player.get_input
    end
    if @board.color(input.first) != @current_player.color
      raise "That's not your piece!"
    end
    @board.move(input.first, input.last)
    rescue RuntimeError => e
      puts e.message
      retry
    ensure
    @current_player.render(@board)
    switch_players
  end

  def switch_players
    if @current_player == @player2
      @current_player = @player1
    else
      @current_player = @player2
    end

  end

  def run
    until @board.checkmate?(@current_player.color)
      take_turn
    end
  end
end

if $0 == __FILE__
  display = Display.new
  jack = HumanPlayer.new("Jack",display)
  john = HumanPlayer.new("John",display)
  game = Game.new(jack,john)
  game.run
end
