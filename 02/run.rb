require 'debug'
require_relative 'cube_game_report'

possible_maximums = {red: 12, green: 13, blue: 14}
data_file = "input.txt"
report = CubeGameReport.summary(data_file:, possible_maximums:)
total_of_possible_ids = report.select do |game|
      game.possible
end.collect do |game|
      game.game_id.to_i
end.sum

total_of_powers = report.collect do |game|
      # debugger
      game.results.values.reduce(1, :*)
end.sum

puts "Total of possibe ids in #{data_file}:
      (limits: #{possible_maximums})
      Part 1: #{total_of_possible_ids}
      Part 2: #{total_of_powers}"
