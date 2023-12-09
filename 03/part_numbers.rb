require 'debug'

class PartNumbers
  Number = Struct.new("Number", :number, :is_part_number)
  SYMBOLS = /[-+\*&\/@%=\$#]/ # file.gsub(/\.+|[0-9]+|\n/, '').chars.uniq.join => "-+*&/@%=$#"

  def initialize(engine_schematic)
    @engine_schematic = File.readlines(engine_schematic, chomp: true)
    @line_length = @engine_schematic.first.length
  end

  def self.summary(data_file:)
    new(data_file).send(:summary)
  end

  def self.summary2(data_file:)
    new(data_file).send(:summary2)
  end

  private
  def data_set
    results = {}
    @engine_schematic.each_with_index {|line, i| results[i] = line}
    return results
  end

  def summary
    summary = []
    data_set.each do |line_number, line|
      line.scan(/([0-9]+)/) do |number|
        start_index = Regexp.last_match.begin(0)
        end_index = Regexp.last_match.end(0)

        left_index = start_index == 0 ? start_index : start_index - 1
        right_index = end_index < line.length ? end_index + 1 : end_index

        above = data_set[line_number - 1] ? data_set[line_number - 1][left_index...right_index] : ""
        current = data_set[line_number][left_index...right_index]
        below = data_set[line_number + 1] ? data_set[line_number + 1][left_index...right_index] : ""
        is_part_number = [above, current, below].join.match?(SYMBOLS)
        summary << Number.new(number: number.first.to_i, is_part_number:)
      end
    end
    return summary
  end

  def map_indexes_to_numbers(pairs)
    index_number_map = {}
    current_number = ""
    start_index = nil

    pairs.each_with_index do |(digit, index), idx|
      # new number?
      if idx == 0 || pairs[idx - 1][1] != index - 1
        unless current_number.empty?
          # add all indexes to the number
          (start_index..pairs[idx - 1][1]).each do |i|
            index_number_map[i] = current_number.to_i
          end
        end
        # new number
        current_number = digit
        start_index = index
      else
        # add digit
        current_number += digit
      end
    end

    # add indexes of the last number
    (start_index..pairs[-1][1]).each do |i|
      index_number_map[i] = current_number.to_i
    end

    index_number_map
  end

  def summary2
    matches_indexes = {}
    @engine_schematic.each_with_index do |line, line_number|
      pairs = []
      line.chars.each_with_index do |char, column_number|
        next unless char.match?(/\d/)
        pairs << [char, column_number]
      end
      matches_indexes[line_number] = map_indexes_to_numbers(pairs)
    end

    gear_ratios = []
    @engine_schematic.each_with_index do |line, line_number|
      line.chars.each_with_index do |char, column_number|
        next unless char.match?(/\*/)
        numbers_near_star = []
        # current left right
        numbers_near_star << matches_indexes[line_number].values_at(column_number-1, column_number+1).compact
        if line_number - 1 >= 0
          # above left current right
          numbers_near_star << matches_indexes[line_number - 1].values_at(column_number-1, column_number, column_number+1).compact.uniq
        end
        if line_number <= @engine_schematic.length
          # below left current right
          numbers_near_star << matches_indexes[line_number + 1].values_at(column_number-1, column_number, column_number+1).compact.uniq
        end

        if numbers_near_star.flatten.compact.length == 2
          gear_ratios << numbers_near_star.flatten.compact.inject(:*)
        end
      end
    end
    return gear_ratios.sum
  end
end