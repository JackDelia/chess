class Pawn < Piece

  def initialize(color,board)
    @first_move = true
    @pos = nil
    super(color,board)
  end

  def move_to(pos)
    @first_move = false
    @pos = pos
  end

  def attack_pos(pos)
    x,y = pos
    if @color == :b
      moves = [ [x+1,y+1], [x+1,y-1] ]
    else
      moves = [ [x-1,y-1], [x-1,y+1] ]
    end
    moves.select{ |move| Board.on_board?(move) && @board.color(move) != @color}
  end

  def moves(pos)
    moves = []
    moves += attack_pos(pos)
    x , y = pos

    move_up_once = @color == :b ? [x+1,y] : [x-1,y]
    moves << move_up_once if @board.empty?(move_up_once)

    move_up_twice = @color == :b ? [x+2,y] : [x-2,y]
    moves << move_up_twice if @board.empty?(move_up_once) && @first_move
    moves
  end

  def to_s
    @color == :w ? "♙" : "♟"
  end

end
