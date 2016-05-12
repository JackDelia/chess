require "byebug"
require_relative "manifest"

class Board
  def initialize(fill = true)
    @grid = Array.new(8){Array.new(8) {EmptySpace.new}}
    @grid = starting_board if fill
  end


  def starting_board
    @grid[0][0] = Rook.new(:b,self)
    @grid[0][1] = Knight.new(:b,self)
    @grid[0][2] = Bishop.new(:b,self)
    @grid[0][3] = King.new(:b,self)
    @grid[0][4] = Queen.new(:b,self)
    @grid[0][7] = Rook.new(:b,self)
    @grid[0][6] = Knight.new(:b,self)
    @grid[0][5] = Bishop.new(:b,self)

    @grid[7][0] = Rook.new(:w,self)
    @grid[7][1] = Knight.new(:w,self)
    @grid[7][2] = Bishop.new(:w,self)
    @grid[7][3] = King.new(:w,self)
    @grid[7][4] = Queen.new(:w,self)
    @grid[7][7] = Rook.new(:w,self)
    @grid[7][6] = Knight.new(:w,self)
    @grid[7][5] = Bishop.new(:w,self)


    # 8.times do |col|
    #   @grid[1][col] = Pawn.new(:b,self)
    #   @grid[6][col] = Pawn.new(:w,self)
    # end
    @grid
  end

  def move(start, end_pos)
    start_x , start_y = start
    end_x   , end_y   = end_pos

    moving_piece = @grid[start_x][start_y]

    if valid_move?(moving_piece, start, end_pos) &&
        !moving_piece.is_a?(EmptySpace)

      @grid[end_x][end_y] = moving_piece
      moving_piece.move_to(end_pos)
      @grid[start_x][start_y] = EmptySpace.new

    else
      raise "Invalid Move, try Again"
    end
  end

  def valid_move?(piece, start, end_pos)
    piece.moves(start).include?(end_pos)
  end

  def in_check?(color)
    king_pos = find_king(color)
    @grid.each_with_index do |row,row_index|
      row.each_with_index do |col,col_index|
                return true if !col.empty? && col.color != color &&
                    col.moves([row_index,col_index]).include?(king_pos)
      end
    end
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)
    @grid.each_with_index do |row,row_index|
      row.each_with_index do |piece,col_index|
        unless piece.valid_moves([row_index,col_index]).empty? || piece.color != color
          return false
        end
      end
    end
    true
  end

  #TODO: AD

  def find_king(color)
    @grid.each_index do |row|
      row.times do |col|
        if self[[row,col]].color == color && self[[row,col]].is_a?(King)
          return [row,col]
        end
      end
    end
  end

  def dup
    dup_board = Board.new(false)

    @grid.each_with_index do |row,row_index|
      row.each_with_index do |col,col_index|
        dup_board[[row_index,col_index]] = col
      end
    end
    dup_board
  end

  def []=(pos,piece)
    x,y = pos
    @grid[x][y] = piece
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def color(pos)
    self[pos].color
  end

  def empty?(pos)
    self[pos].empty?
  end

  def self.on_board?(pos)
    x,y = pos
    x.between?(0,7) && y.between?(0,7)
  end

end
