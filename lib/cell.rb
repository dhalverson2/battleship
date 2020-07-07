class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @empty = true
  end

  def empty?
   @ship == nil
  end
end
