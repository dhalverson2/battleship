class Player

  attr_reader :type,
              :board
  def initialize(type)
    @type = type
    @board = Board.new
  end
end
