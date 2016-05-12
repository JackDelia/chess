class Bishop < SlidingPiece

  def initialize(color,board)
    super(color,board,true,false)
  end

  def to_s
    @color == :w ? "♗" : "♝"
  end
end
