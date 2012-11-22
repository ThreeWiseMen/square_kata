require "./square.rb"

square = ARGV[0] # Assume first command-line input is our argument

square_root = square && Math.sqrt(square.to_i)

unless square && square_root == square_root.to_i && square_root > 0
	puts "You must provide an argument, and it must be a perfect square."
	exit 0
end

grid = Grid.new(square_root)
grid.fill

grid.print_matrix