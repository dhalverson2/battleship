class Board

  attr_reader :cells
  def initialize
    # @cells = create_coordinates
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_ship_coordinates?(coordinates)
    coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
  end

  def valid_coordinate_count?(ship, coordinates)
    ship.length == coordinates.count
  end

  def valid_placement?(ship, coordinates)
    valid_coordinate_count?(ship, coordinates) &&
    consecutive_coordinates?(ship, coordinates) &&
    !overlap?(coordinates) &&
    valid_ship_coordinates?(coordinates)
  end

  def consecutive_coordinates?(ship, coordinates)
    letters = coordinates.map do |coordinate|
      coordinate.ord
    end
    numbers = coordinates.map do |coordinate|
      coordinate[-1].to_i
    end
    if numbers.each_cons(2).map.all? { |a, b| b - a == 1 } && letters.uniq.count == 1
      true
    elsif letters.each_cons(2).map.all? { |a, b| b - a == 1 } && numbers.uniq.count == 1
      true
    else
      false
    end
  end

  def overlap?(coordinates)
    coordinates.any? do |coordinate|
      !@cells[coordinate].empty? if !@cells[coordinate].nil?
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render(reveal = false)
    "  1 2 3 4 \n"\
    "A #{cells["A1"].render(reveal)} #{cells["A2"].render(reveal)} #{cells["A3"].render(reveal)} #{cells["A4"].render(reveal)} \n"\
    "B #{cells["B1"].render(reveal)} #{cells["B2"].render(reveal)} #{cells["B3"].render(reveal)} #{cells["B4"].render(reveal)} \n"\
    "C #{cells["C1"].render(reveal)} #{cells["C2"].render(reveal)} #{cells["C3"].render(reveal)} #{cells["C4"].render(reveal)} \n"\
    "D #{cells["D1"].render(reveal)} #{cells["D2"].render(reveal)} #{cells["D3"].render(reveal)} #{cells["D4"].render(reveal)} \n"
    end
  end
