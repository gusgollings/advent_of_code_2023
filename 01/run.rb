require_relative 'calibration_values_1'
require_relative 'calibration_values_2'

input_file = "input.txt"

total1 = CalibrationValues1.total(input_file)
total2 = CalibrationValues2.total(input_file)

puts "Total calibration values for #{input_file}:
      Part 1: #{total1}
      Part 2: #{total2}"
