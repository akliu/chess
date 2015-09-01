require './piece.rb'
require './display.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}

    populate_board #initiate white and black pieces
    # @grid[0][0] = Rook.new([0,0],self, :black)
    # @grid[0][1] = Queen.new([0,1],self, :black)
    # @grid[0][2] = Bishop.new([0,2],self, :black)
    # @grid[0][3] = King.new([0,3],self, :black)
    # @grid[0][4] = Knight.new([0,4],self, :black)
    # @grid[0][5] = Pawn.new([0,5],self, :black, false)
    # @grid[7][3] = Pawn.new([7,3],self,:white, false)
  end

  def move(start, end_pos)
    x_start,y_start = start
    x_end, y_end = end_pos
    piece = get_piece(start)

    piece.moved = true if piece.is_a?(Pawn)

    grid[x_end][y_end] = piece
    piece.update_pos(end_pos)
    grid[x_start][y_start] = Empty_Piece.new
  end

  def occupied?(pos)
    p pos
    x,y = pos
    return true if grid[x][y].is_a?(Piece)
    false
  end

  def get_piece(pos)
    x,y = pos
    return grid[x][y]
  end

  def populate_board

    grid.length.times do |row_idx|
      grid.length.times do |col_idx|
        grid[row_idx][col_idx] = Empty_Piece.new()
      end
    end
    grid[0] = generate_start_row(:black)
    grid[1] = generate_pawns(:black)
    grid[6] = generate_pawns(:white)
    grid[7] = generate_start_row(:white)
  end

  def generate_pawns(color)
    pawns = []

    if color == :white
      row = 6
    else
      row = 1
    end

    8.times do |x|
      pawns << Pawn.new([row,x],self, color, false)
    end
    pawns
  end

  def generate_start_row(color)
    row = []
    if color == :white
      row_idx = 7
    else
      row_idx = 0
    end
    row << Rook.new([row_idx,0], self,color)
    row << Knight.new([row_idx,1], self, color)
    row << Bishop.new([row_idx,2], self, color)
    row << Queen.new([row_idx,3], self, color)
    row << King.new([row_idx,4], self, color)
    row << Bishop.new([row_idx,5], self, color)
    row << Knight.new([row_idx,6], self, color)
    row << Rook.new([row_idx,7], self, color)
    p row
    row
  end

  def in_bounds?(pos)
    pos.all? { |coord| (0..7).include?(coord)}
  end

end

if $PROGRAM_NAME == __FILE__
  b = Board.new
  d = Display.new(b)
  d.render
  sleep(5)
  b.move([0,0], [7,7])
  d.render
end
