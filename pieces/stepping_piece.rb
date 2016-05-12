class SteppingPiece < Piece

  def initialize(color,board,deltas)
    @deltas = deltas
    super(color,board)
  end

  def moves(pos)
    x,y = pos
    moves = []
    @deltas.each do |dx,dy|
      new_pos = [x+dx,y+dy]

      new_space = @board[new_pos] if Board.on_board?(new_pos)

      if new_space && 
         (new_space.is_a?(EmptySpace) ||
          new_space.color != @color)

          moves << new_pos
      end
    end

    moves
  end
end
