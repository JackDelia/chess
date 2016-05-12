require "colorize"

  DELTAS = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  PIECE_NAMES = {
    Rook => :r,
    Knight => :n,
    Bishop => :b,
    King => :k,
    Queen => :q,
    Pawn => :p,
    EmptySpace => " "
  }

class Display
  def initialize
    @cursor = [0,0]
    @selected = nil
  end

  def handle_key(key)
    case key
    when :up, :down, :left, :right
      move_cursor(DELTAS[key])
      return nil
    when :exit
      raise Exception.new("Quit")
    when :enter
      unless selected_piece?
        @selected = @cursor
        return nil
      else
        move = [@selected, @cursor]
        @selected = nil
        move
      end
    end
  end

  def selected_piece?
    !@selected.nil?
  end

  def move_cursor(delta)
    new_pos = [@cursor.first + delta.first, @cursor.last + delta.last]
    @cursor = new_pos if Board.on_board?(new_pos)
  end

  def render(board)
    system("clear")
    print "  "
    (0...8).each {|i| print " #{i} "}
    puts

    8.times do |row|
      white = true unless row%2 == 0
      print "#{row} "
      8.times do |col|
        bg = :red if white
        bg = :blue unless white
        white = !white
        bg = :light_blue if [row,col] == @cursor || [row,col] == @selected
        print " #{board[[row,col]]} ".colorize({background: bg, color: :white})
      end
      puts
    end
  end
end
