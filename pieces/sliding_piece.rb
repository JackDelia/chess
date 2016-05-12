class SlidingPiece < Piece
  def initialize(color, board, diagonal,linear)
    @diagonal = diagonal
    @linear = linear
    super(color,board)
  end

  def moves(pos)
    moves = []
    moves += moves_linear(pos) if @linear
    moves += moves_diagonal(pos) if @diagonal
    moves
  end

  def moves_linear(pos)
    moves = []
    moves += moves_direction(pos,[1,0])
    moves += moves_direction(pos, [-1,0])
    moves += moves_direction(pos, [0,1])
    moves += moves_direction(pos, [0,-1])
    moves
  end

  def moves_diagonal(pos)
    moves = []
    moves += moves_direction(pos,[1,1])
    moves += moves_direction(pos, [-1,1])
    moves += moves_direction(pos, [1,-1])
    moves += moves_direction(pos, [-1,-1])
    moves
  end

  private
  def moves_direction(pos, delta)
    moves = []
    dx,dy = delta
    x,y = pos

    x += dx
    y += dy

    while Board.on_board?([x,y]) &&
          @board[[x,y]].is_a?(EmptySpace)

      moves << [x,y]

      x += dx
      y += dy
    end

    if Board.on_board?([x,y])
      unless @board[[x,y]].color == @color
        moves << [x,y]
      end
    end
    moves
  end

end
