require './board.rb'
require './player.rb'

class Game
  attr_reader :board, :display, :player

  def initialize
    @board = Board.new

    @display = Display.new(@board)
    @player = Player.new("Test", @display, @board)
  end

  def run
    while true
      begin
        @display.render
        start_pos = @player.get_move
        end_pos = @player.get_move
        move(start_pos, end_pos) if valid_move?(start_pos, end_pos)

      rescue InvalidMoveError => e
        puts e.message
        sleep(3)
        retry
      end
      #p valid_move?(start_pos, end_pos)

    end
  end



  def valid_move?(start_pos, end_pos)
    current_piece = board.get_piece(start_pos)
    p current_piece.moves
    if !current_piece.moves.include?(end_pos)
      raise InvalidMoveError.new("Can't move there")
    end
    true
  end

  def move(start_pos, end_pos)
    board.move(start_pos, end_pos)
  end
end

class InvalidMoveError < StandardError
end



if $PROGRAM_NAME == __FILE__
  g = Game.new
  g.run
end
