class Queen < SlidingPiece

  def initialize(color,board)
    super(color,board,true,true)
  end

  def to_s
    @color == :w ? "♕" : "♛"
  end

end
