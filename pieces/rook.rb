class Rook < SlidingPiece

  def initialize(color,board)
    super(color,board,false,true)
  end

  def to_s
    @color == :w ? "♖" : "♜"
  end

end
