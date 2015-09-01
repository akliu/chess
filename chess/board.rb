require './piece.rb'
require './display.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}

    populate_board #initiate white and black pieces
    @grid[0][0] = Rook.new([0,0],self)
    @grid[0][1] = Queen.new([0,1],self)
    @grid[0][2] = Bishop.new([0,2],self)
    @grid[0][3] = King.new([0,3],self)
  end

  def move(start, end_pos)
    x_start,y_start = start
    x_end, y_end = end_pos
    # check if there is a piece at start
    # start is [x,y]
    # if occupied?(start)  *** should go into get_prompt
    # ask piece if this is valid move
      piece = get_piece(start)
    #piece.valid?
      grid[x_end][y_end] = piece
      piece.update_pos(end_pos)
      grid[x_start][y_start] = Empty_Piece.new
  end

  def occupied?(pos)
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
