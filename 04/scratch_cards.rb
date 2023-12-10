require 'debug'

class ScratchCards
  def initialize(input)
    @cards = File.readlines(input, chomp: true)
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
    @cards.each_with_index {|line, i| results[i] = line}
    return results
  end

  def extract_game_data(line)
    # "Card   1: 30 51 48 31 36 33 49 83 86 17 | 17 33 31 70 90 37 86 45 58 21 83 52 59 68 55 32 20 43 48 75 30 42 80 60 71"
    matches = line.match(/^Card[[:blank:]]+(\d+):([ \d]+)\|([ \d]+)$/)
    card = matches[1]
    draw = matches[2].split(" ").map(&:to_i)
    lucky_numbers = matches[3].split(" ").map(&:to_i)
    return [card.to_i, draw, lucky_numbers]
  end

  def summary
    points = []
    data_set.each do |line_number, line|
      card, draw, lucky_numbers = extract_game_data(line)
      winning_numbers = draw & lucky_numbers
      unless winning_numbers.empty?
        discard_one = winning_numbers.shift
        points << winning_numbers.reduce(1) {|n| n * 2 }
      end
    end
    return points.sum
  end

  def summary2
    # init the card counts to 1
    card_counts = data_set.keys.to_h { |key| [key+1, 1] }

    #walk through all the cards
    data_set.each do |line_number, line|
      # 0123...
      card, draw, lucky_numbers = extract_game_data(line)
      winning_numbers = draw & lucky_numbers

      unless winning_numbers.empty?
        keys_to_increment = data_set.keys[card...card+winning_numbers.length]
        keys_to_increment = keys_to_increment * card_counts[card]
        keys_to_increment.each do |key|
          card_counts[key+1] += 1
        end
      end
    end
    return card_counts.values.sum
  end
end