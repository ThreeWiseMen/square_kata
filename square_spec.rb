require "./square.rb"

describe Cursor do
	it "should default to moving right" do
		coordinate = Coordinate.new(1,1)
		cursor = Cursor.new(coordinate)

		cursor.direction.should == :right
	end

	it "should have a default coordinate of (1,1)" do
		coordinate = Coordinate.new(1,1)
		cursor = Cursor.new(coordinate)

		cursor.coordinate.x.should == 1
		cursor.coordinate.y.should == 1
	end

	it "should rotate counter-clockwise" do
		coordinate = Coordinate.new(1,1)
		cursor = Cursor.new(coordinate)

		cursor.direction.should == :right
		cursor.rotate_direction
		cursor.direction.should == :up
		cursor.rotate_direction
		cursor.direction.should == :left
		cursor.rotate_direction
		cursor.direction.should == :down
	end

	it "should correctly look forward and move according to direction :right" do
		coordinate = Coordinate.new(1,1)
		cursor = Cursor.new(coordinate)

		cursor.next_coordinate.x.should == 2
		cursor.next_coordinate.y.should == 1

		cursor.advance

		cursor.coordinate.x.should == 2
		cursor.coordinate.y.should == 1
	end
end

describe Grid do
	it "should return a origin point of (0,1) with a 2x2 grid" do
	  grid = Grid.new(2)
	  grid.origin.x.should == 0
	  grid.origin.y.should == 1
	end

	it "should return an origin point of (1,2) with a 4x4 grid" do
		grid = Grid.new(4)
		grid.origin.x.should == 1
		grid.origin.y.should == 2
	end

	it "should return an origin point of (1,1) with a 3x3 grid" do
		grid = Grid.new(3)
		grid.origin.x.should == 1
		grid.origin.y.should == 1
	end

	it "should return an origin point of (2,2) with a 5x5 grid" do
		grid = Grid.new(5)
		grid.origin.x.should == 2
		grid.origin.y.should == 2
	end

	it "should return an origin point of (2,3) with a 6x6 grid" do
		grid = Grid.new(6)
		grid.origin.x.should == 2
		grid.origin.y.should == 3
	end

	it "should have a cursor that starts at the origin" do
		grid = Grid.new(2)

		grid.cursor.coordinate.x.should == grid.origin.x
		grid.cursor.coordinate.y.should == grid.origin.y
	end

	it "grid counter should start at 1" do
		grid = Grid.new(2)
		grid.counter.should == 1
	end

	it "should increment the counter when it moves the cursor" do
		grid = Grid.new(2)
		grid.advance_cursor
		grid.counter.should == 2
	end

	it "should stamp 1 at the origin and increment the counter when the cursor moves, and the cursor should rotate around the first corner" do
		grid = Grid.new(2)
		grid.advance_cursor
		grid.data(grid.origin).should == 1
		grid.counter.should == 2
		grid.cursor.direction.should == :up
	end

	it "should fill a grid of 2x2" do
		grid = Grid.new(2)
		grid.fill

		grid.data(Coordinate.new(0,0)).should == 4
		grid.data(Coordinate.new(1,0)).should == 3
		grid.data(Coordinate.new(1,1)).should == 2
		grid.data(Coordinate.new(0,1)).should == 1
	end

	it "should fill a grid of 4x4" do
		grid = Grid.new(4)
		grid.fill

		grid.data(Coordinate.new(0,0)).should == 16
		grid.data(Coordinate.new(1,0)).should == 15
		grid.data(Coordinate.new(2,0)).should == 14
		grid.data(Coordinate.new(3,0)).should == 13
		grid.data(Coordinate.new(3,1)).should == 12
		grid.data(Coordinate.new(3,2)).should == 11
		grid.data(Coordinate.new(3,3)).should == 10
		grid.data(Coordinate.new(2,3)).should == 9
		grid.data(Coordinate.new(1,3)).should == 8
		grid.data(Coordinate.new(0,3)).should == 7
		grid.data(Coordinate.new(0,2)).should == 6
		grid.data(Coordinate.new(0,1)).should == 5
		grid.data(Coordinate.new(1,1)).should == 4
		grid.data(Coordinate.new(2,1)).should == 3
		grid.data(Coordinate.new(2,2)).should == 2
		grid.data(Coordinate.new(1,2)).should == 1
	end

	it "should fill a grid of 3x3" do
		grid = Grid.new(3)
		grid.fill

		grid.data(Coordinate.new(2,2)).should == 9
		grid.data(Coordinate.new(1,2)).should == 8
		grid.data(Coordinate.new(0,2)).should == 7
		grid.data(Coordinate.new(0,1)).should == 6
		grid.data(Coordinate.new(0,0)).should == 5
		grid.data(Coordinate.new(1,0)).should == 4
		grid.data(Coordinate.new(2,0)).should == 3
		grid.data(Coordinate.new(2,1)).should == 2
		grid.data(Coordinate.new(1,1)).should == 1
	end
end