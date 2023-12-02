class CalibrationValues2
  WORD_TO_DIGIT = %w[zero one two three four five six seven eight nine].zip(0..9).to_h
  DIGITS_RE = /(?=(one|two|three|four|five|six|seven|eight|nine|zero|[0-9]))/

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
    input.scan(DIGITS_RE).flatten.map do |match|
      WORD_TO_DIGIT[match] || match.to_i
    end
  end

  def extract_calibration_values
    @lines.map do |line|
      digits = get_digits(line)
      "#{digits.first}#{digits.last}".to_i
    end
  end
end
