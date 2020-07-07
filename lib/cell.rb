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

  def place_ship(ship)
    @ship = ship
  end
end
