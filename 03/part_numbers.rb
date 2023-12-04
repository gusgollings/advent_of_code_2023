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
  def self.summary1(data_file:)
    new(data_file).send(:summary1)
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
end