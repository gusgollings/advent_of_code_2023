class CalibrationValues1
  DIGITS_RE = /[0-9]/

  def initialize(calibration_document)
    @lines = File.readlines(calibration_document)
  end

  def self.total(calibration_document)
    new(calibration_document).send(:total)
  end

  private
  def total
    extract_calibration_values.sum
  end

  def get_digits(input)
    input.scan(DIGITS_RE).flatten.map(&:to_i)
  end

  def extract_calibration_values
    @lines.map do |line|
      digits = get_digits(line)
      "#{digits.first}#{digits.last}".to_i
    end
  end
end
