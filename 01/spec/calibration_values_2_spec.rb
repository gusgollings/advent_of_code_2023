require 'rspec'
require_relative '../calibration_values_2'

RSpec.describe CalibrationValues2 do
  let(:input_data) do
    <<~DATA
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    DATA
  end

  before do
    allow(File).to receive(:readlines).and_return(input_data.lines)
  end

  describe '.total' do
    it 'factory for #total' do
      expect(CalibrationValues2.total('input.txt')).to eq(281)
    end
  end
end
