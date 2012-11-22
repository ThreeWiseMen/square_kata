# Square, "snake" style solution

Coordinate = Struct.new(:x, :y)

class Cursor
	# Lookups would be nicer in a hash, but arrays guarantee order
	DIRECTIONS = [ :right, :up, :left, :down ]
	VECTORS = [ [1,0], [0,-1], [-1,0], [0,1] ]

	attr_accessor :direction, :coordinate

	def initialize(coordinate)
		self.direction = DIRECTIONS.first
		self.coordinate = coordinate
	end

	def next_coordinate
		move = VECTORS[DIRECTIONS.index(self.direction)]
		Coordinate.new(coordinate.x + move[0], coordinate.y + move[1])
	end

	def turned_coordinate
		move = VECTORS[DIRECTIONS.index(self.next_direction)]
		Coordinate.new(coordinate.x + move[0], coordinate.y + move[1])
	end

	def rotate_direction
		self.direction = next_direction
	end

	def next_direction
		DIRECTIONS[DIRECTIONS.index(self.direction) + 1] || DIRECTIONS.first
	end

	def advance
		self.coordinate = next_coordinate
	end
end

class Grid 
  attr_accessor :size, :cursor, :origin, :counter, :data_storage

  def initialize(size)
    self.size = size
    calculate_origin
    self.cursor = Cursor.new(origin)
    self.counter = 1
    self.data_storage = Array.new(size)
    (1..size).each do |number|
    	self.data_storage[number-1] = Array.new(size) { 0 }
    end 
  end

  def calculate_origin
  	if size % 2 == 0
			x = (size / 2) - 1
			y = size / 2
	  else
		  x = size / 2
		  y = size / 2
	  end
  	self.origin = Coordinate.new(x, y)
  end

  def data(coordinate)
  	self.data_storage[coordinate.y][coordinate.x]
  end

  def cursor_at_edge
  	self.cursor.direction == :right && self.cursor.coordinate.x == size-1 \
  	|| self.cursor.direction == :up && self.cursor.coordinate.y == 0 \
  	|| self.cursor.direction == :down && self.cursor.coordinate.y == size-1 \
  	|| self.cursor.direction == :left && self.cursor.coordinate.x == 0
  end

  def cursor_can_turn
  	self.data(self.cursor.turned_coordinate) == 0
  end

  def advance_cursor
  	self.data_storage[cursor.coordinate.y][cursor.coordinate.x] = self.counter
  	self.counter += 1
  	self.cursor.advance
  	self.cursor.rotate_direction if cursor_at_edge || cursor_can_turn
  end

  def finished
  	self.counter > self.size * self.size
  end

  def fill
  	until self.finished
  		self.advance_cursor
  	end
  end

  def to_s
  	puts self.data_storage.inspect
  end
end
