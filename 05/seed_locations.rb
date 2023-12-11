require 'debug'

class SeedLocations
  MAP_RE = /(\w+)-\w+-(\w+) map:\n(.+)/m
  def initialize(input)
    data = File.read(input)
    parts = data.split("\n\n")
    @seeds = parts.shift.split(" ")[1..].map(&:to_i)
    @maps = {}

    new_seeds = @seeds
    parts.each do |source_to_destination_map|
      seed_collection = []
      source_to_destination_map.match(MAP_RE) do |matchdata|
        origin, destination, mappings = matchdata[1], matchdata[2], matchdata[3]
        range_offsets = {}
        lines = mappings.split("\n")
        lines.each do |line|
          dest, src, depth = line.split.map(&:to_i)
          range = Range.new(src, src+depth, true)
          offset = dest - src
          range_offsets[range] = offset
        end
        @maps["#{origin}-#{destination}"] = range_offsets
      end
    end
  end

  def self.summary(data_file:)
    new(data_file).send(:summary)
  end

  def self.summary2(data_file:)
    new(data_file).send(:summary2)
  end

  private
  def summary
    locations = []
    @seeds.each do |seed|
      result = seed
      @maps.each_value do |map|
        offset = map.detect{|k,v| k === result}&.last || 0
        result = result + offset
      end
      locations << result
    end
    return locations.min
  end

  def summary2
  end
end