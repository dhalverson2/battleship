class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @empty = false
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !fired_upon?
      @fired_upon = true
      @ship.hit if !empty?
    end
  end

  def render(reveal = false)
    if fired_upon? && !empty? && @ship.sunk?
      "X"
    elsif fired_upon? && empty?
      "M"
    elsif !fired_upon? && !empty? && reveal == true
      "S"
    elsif fired_upon? && !empty?
      "H"
    else
      "."
    end
  end
end
