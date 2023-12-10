require 'debug'
require_relative 'scratch_cards'

data_file = "input.txt"
summary = ScratchCards.summary(data_file:)
summary2 = ScratchCards.summary2(data_file:)

puts "Lines #{data_file}:
      Part 1: #{summary}
      Part 2: #{summary2}"

# Part 2 Try #1: 6973790 => Too Low
# Part 2 Try #2: 2951603 => Too Low
# Part 2 Try #2: 7013204 => Just right
