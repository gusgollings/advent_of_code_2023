class CubeGameReport
  Result = Struct.new('Result', :game_id, :results, :possible)

  def initialize(game_data)
    @games = File.readlines(game_data, chomp: true)
  end

  def self.summary(data_file:, possible_maximums:)
    new(data_file).send(:summary).map do |game_id, results|
      possible = compare_to(results, possible_maximums)
      Result.new(game_id:, results:, possible: )
    end
  end

  def self.compare_to(results, possible_maximums)
    results.all? { |key, value| value <= possible_maximums[key] }
  end

  private
  def summary
    @games.collect do |game|
      max_known(game)
    end
  end

  def max_known(game_data)
    game, data = game_data.split(/Game (\d+): /)[1..]
    rounds = data.split('; ')
    draws = rounds.map do |r|
      r.split(', ')
    end.map do |draw|
      draw.map do |colour_amount|
        colour_amount.split(' ').reverse # colour as key
      end.to_h.transform_keys(&:to_sym).transform_values(&:to_i)
    end

    result = Hash.new(0)
    draws.each do |draw|
      draw.each do |colour, value|
        result[colour] = [result[colour], value].max
      end
    end

    return [game, result]
  end
end
