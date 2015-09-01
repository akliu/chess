class Piece
  attr_reader :value, :position, :board

  def initialize(position, board)
    @value = " P "
    @position = position
    @board = board
  end

  def update_pos(pos)
    @position = pos
  end

end


class Empty_Piece
  attr_reader :value

  def initialize
    @value = "   "
  end

end

class SlidingPiece < Piece
  def moves
    possible_moves = []
    x_cur, y_cur = position
    move_dirs.each do |vector|
      x_next = vector[0] + x_cur
      y_next = vector[1] + y_cur
      possible_pos = [x_next, y_next]

      while board.in_bounds?(possible_pos)
        possible_moves << possible_pos.dup
        possible_pos = [possible_pos[0] += vector[0],
                                possible_pos[1] += vector[1]]
      end
    end
    possible_moves
  end
end

class SteppingPiece < Piece
  
end

class Rook < SlidingPiece
  def initialize(position, board)
    super(position , board)
    @value = " R "
  end
  def  move_dirs
    [[0,1], [1,0], [0,-1], [-1,0]]
  end
end


class Bishop < SlidingPiece
  def initialize(position, board)
    super(position , board)
    @value = " B "
  end

  def move_dirs
    [[-1,1], [1,1], [1,-1], [-1,-1]]
  end
end

class Queen < SlidingPiece
  def initialize(position, board)
    super(position , board)
    @value = " Q "
  end

  def move_dirs
    [[0,1], [1,0], [0,-1], [-1,0], [-1,1], [1,1], [1,-1], [-1,-1]]
  end
end
