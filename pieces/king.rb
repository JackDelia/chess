class King < SteppingPiece

  DELTA = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]

  def initialize(color,board)
    super(color,board,DELTA)
  end

  def to_s
    @color == :w ? "♔" : "♚"
  end
  
end
