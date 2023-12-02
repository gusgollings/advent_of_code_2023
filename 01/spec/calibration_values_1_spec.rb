require 'rspec'
require_relative '../calibration_values_1'

RSpec.describe CalibrationValues1 do
  let(:input_data) do
    <<~DATA
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    DATA
  end

  before do
    allow(File).to receive(:readlines).and_return(input_data.lines)
  end

  describe '.total' do
    it 'sum of calibration values from the input' do
      expect(CalibrationValues1.total('input.txt')).to eq(142)
    end
  end
end
