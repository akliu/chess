class Player
  include Cursorable

  attr_reader :display, :board

  def initialize(name, display, board)
    @name = name
    @display = display
    @board = board
  end

  def get_move
    move = nil
    until move
      move = display.get_input
      display.render
      #end_pos = display.get_input
      #move = [start_pos, end_pos]
    end
    move
  end

end
