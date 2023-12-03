require 'rspec'
require_relative '../cube_game_report'

RSpec.describe CubeGameReport do
  let(:possible_maximums) { {red: 12, green: 13, blue: 14} }
  let(:data_file) { "input.txt" }
  let(:summary) { CubeGameReport.summary(data_file:, possible_maximums:) }
  let(:input_data) do
    <<~DATA
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    DATA
  end

  before do
    allow(File).to receive(:readlines).and_return(input_data.lines)
  end

  describe '.summary' do
    it 'returns an array of structs with correct values' do
      expect(summary.first.game_id).to eq("1")
      expect(summary.first.results).to eq({blue: 6, green: 2, red: 4})
    end
  end
end
