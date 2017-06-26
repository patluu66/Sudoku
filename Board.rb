require_relative './Tile.rb'

class Board
	attr_reader :grid

	def initialize
		@grid = Array.new(9){ Array.new(9) }
		# @grid = [][]
		numbers = (1..9).to_a
		@valid_numbers = numbers.map(&:to_s) #array of int 1 to 9
		read_file
	end

	def read_file #read in file
		tiles = []
		f = File.open("sudoku1-almost.txt", "r")
		f.each_line do |line|
			line.chomp.split("").each do |digit_str|
				if digit_str == "0"
					digit_str = " "
				end
				tile = Tile.new(digit_str)
				tiles << tile
			end
		end
		f.close

		@grid.each_with_index do |row, row_i|
			row.each_with_index do |col, col_i|
				tile = tiles.pop
				@grid[row_i][col_i] = tile
			end
		end
	end

	def render
		puts "   0  1  2   3  4  5   6  7  8"
		puts "   -  -  -   -  -  -   -  -  -"
		@grid.each_with_index do |row, index_r|
			print "#{index_r}"
			row.each_with_index do |tile, index_c|
				if index_c % 3 == 0
					print "|"
				end
				print " #{tile} "
			end
			puts ""
			if (index_r + 1) % 3 == 0
				puts "- - - - - - - - - - - - - - - -"
			end
		end
	end

	def solved?
		is_rows_valid? && is_cols_valid? && is_squares_valid?
	end

	def is_squares_valid?
		squares_table = []
		i = 0
		while i < @grid.length
			j = 0
			while j < @grid.length
				row_index = i
				col_index = j
				if row_index % 3 == 0 && col_index % 3 == 0
					if !is_square_valid?(row_index, col_index)
						return false
					end
				end
				j += 1
			end
			i += 1
		end
		true
	end

	def is_square_valid?(row_index, col_index)
		squares_table = []
		row = (row_index / 3) * 3
		col = (col_index / 3) * 3

		i = 0 
		while i < 3
			j = 0
			while j < 3
				current_square = @grid[i + row][j + col].value
				squares_table << current_square
			j += 1
			end
			# p squares_table
		i += 1	
		end
		# p squares_table
		if squares_table.sort == @valid_numbers
			return true
		else
			return false
		end
	end

	def is_cols_valid?
		cols_table = []
		i = 0
		while i < @grid.length
			cols_check = []
			j = 0
			while j < @grid.length
				current_col = @grid[j][i].value
				cols_check << current_col
				j += 1
			end
			cols_table << is_numbers_valid?(cols_check)
			i += 1
		end

		if cols_table.include?(false)
			return false
		else
			return true
		end
	end

	def is_numbers_valid?(numbers)
		numbers.sort == @valid_numbers
	end

	def is_rows_valid?
		rows_table = []
		i = 0
		while i < @grid.length
			rows_check = []
			j = 0
			while j < @grid.length
				current_row = @grid[i][j].value
				rows_check << current_row
				j += 1
			end
			rows_table << is_numbers_valid?(rows_check)
			i += 1
		end

		if rows_table.include?(false)
			return false
		else
			return true
		end
	end

	def tile_position(pos)
		row = pos[0].to_i
		col = pos[1].to_i
		@grid[row][col]
	end
end

# game = Board.new
# game.render


