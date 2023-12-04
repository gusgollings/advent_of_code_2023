require 'rspec'
require_relative '../part_numbers'

RSpec.describe PartNumbers do
  let(:data_file) { "input.txt" }
  let(:summary) { summary = PartNumbers.summary(data_file:) }
  let(:input_data) do
<<~DATA
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
DATA
  end

  before do
    allow(File).to receive(:readlines).and_return(input_data.lines)
  end

  describe '.summary' do
    it 'returns an array of structs with correct values' do
      expect(summary.first.number).to eq(467)
      expect(summary.first.is_part_number).to eq(true)
      expect(summary.select {|n| n.is_part_number}.map {|n| n.number}.sum).to eq(4361)
    end
  end
end
