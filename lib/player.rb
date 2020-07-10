class Player

  attr_reader :type
  def initialize(type)
    @type = type
    @board = Board.new
  end


end
