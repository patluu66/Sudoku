require 'colorize'

class Tile
	attr_reader :value, :given

	def initialize(value)
		@value = value
		if value == " "
			@given = false
		else
			@given = true
		end
	end

	def color
		given? ? :red : :blue
	end

	def given?
		@given
	end
	
	def to_s
		@value.colorize(color)
	end

	def value=(new_value)
		if given?
			puts "Invalid entry, can't change the given tile."
			sleep(3)
		else
			@value = new_value
		end
	end
end

