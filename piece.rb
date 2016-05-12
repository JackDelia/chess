class Piece
  attr_accessor :color

  def initialize(color, board)
    @color = color
    @board = board
  end

  def move_to(pos)

  end

  def moves(pos)
  end

  def valid_moves(pos)
    moves(pos).reject{|move| moves_into_check(pos,move)}
  end

  def moves_into_check(start,end_pos)
    duped_board = @board.dup
    duped_board.move(start, end_pos)
    duped_board.in_check?(@color)
  end

  def empty?
    false
  end

end
