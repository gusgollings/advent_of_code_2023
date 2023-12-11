require 'debug'
require_relative 'seed_locations'

data_file = "input.txt"
summary = SeedLocations.summary(data_file:)
# summary2 = SeedLocations.summary2(data_file:)

puts "Lines #{data_file}:
      Part 1: #{summary}"
      # Part 2: #{summary2}"

