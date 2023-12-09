require 'debug'
require_relative 'part_numbers'

data_file = "input.txt"
summary = PartNumbers.summary(data_file:)
sum_of_ratios = PartNumbers.summary2(data_file:)
sum_of_part_numbers = summary.select do |game|
      game.is_part_number
end.collect do |game|
      game.number
end.sum

puts "Lines #{data_file}:
      Part 1: #{sum_of_part_numbers}
      Part 2: #{sum_of_ratios}"