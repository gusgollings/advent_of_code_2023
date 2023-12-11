require 'rspec'
require_relative '../seed_locations'

RSpec.describe SeedLocations do
  let(:data_file) { "input.txt" }
  let(:summary) { SeedLocations.summary(data_file:) }
  # let(:summary2) { SeedLocations.summary2(data_file:) }
  let(:input_data) do
<<~DATA
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
DATA
  end

  before do
    allow(File).to receive(:read).and_return(input_data)
  end

  describe '.summary' do
    it 'returns total of points per game' do
      expect(summary).to eq(35)
    end
  end
  # describe '.summary2' do
  #   it 'returns the answer' do
  #     expect(summary2).to eq(30)
  #   end
  # end
end
