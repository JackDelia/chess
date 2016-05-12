class Knight < SteppingPiece

  DELTA = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]

  def initialize(color,board)
    super(color,board,DELTA)
  end

  def to_s
    @color == :w ? "♘" : "♞"
  end

end
