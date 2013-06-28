#-*- coding: utf-8 -*-

class BanditAlgorithm

  attr_accessor :counts, :values

  def initialize(counts, values)
    @counts = counts
    @values = values
  end

  def init(n_arms)

    @counts = (1 .. n_arms).map{|i| 0 }
    @values = (1 .. n_arms).map{|i| 0.0 }
  end

  def update(chosen_arm, reward)
    @counts[chosen_arm] = @counts[chosen_arm] + 1
    n = @counts[chosen_arm]
    value = @values[chosen_arm]
    new_value = ((n - 1).to_f / n.to_f * value.to_f + (1.to_f / n.to_f) * reward.to_f)
    @values[chosen_arm] = new_value
  end

  def ind_max(arr)
    arr.index(arr.max)   
  end
end

class Ucb < BanditAlgorithm

  def select_arm
    n_arms = @counts.size

    0.upto(n_arms - 1) do |arm|
      return arm if @counts[arm] == 0
    end

    ucb_values = (1 .. n_arms).map{|i| 0.0 }
    total_counts = @counts.inject(0) {|sum, n| sum += n}

    0.upto(n_arms - 1) do |arm|
      bonus = Math.sqrt((2.to_f * Math.log(total_counts)) / @counts[arm].to_f)
      ucb_values[arm] = @values[arm] + bonus
    end

    return ind_max(ucb_values)
  end
end

class Softmax < BanditAlgorithm

  def initialize(temperature, counts, values)

    super(counts, values)

    @temperature = temperature
  end

  def select_arm
    z = @values.map{|v| Math.exp(v.to_f / @temperature.to_f)}.inject(0.0) {|sum, f| sum += f }
    probs = @values.map{|v| Math.exp(v.to_f / @temperature) / z }

    return categorical_draw(probs)
  end

  def categorical_draw(probs)
    z = rand
    cum_prob = 0.0

    0.upto(probs.size - 1) do |i|
      prob = probs[i]
      cum_prob += prob
      return i if cum_prob > z
    end

    return probs.size - 1
  end
end

class EpsilonGreedy < BanditAlgorithm

  def initialize(epsilon, counts, values)

    super(counts, values)

    @epsilon = epsilon
  end 

  def select_arm

    if rand > @epsilon
      return ind_max(@values)
    else
      return (@counts.size * rand).floor
    end
  end
end

algorithm = ARGV[0]

if algorithm.nil? || !['ucb', 'softmax', 'epsilon'].include?(algorithm)
  puts "Usage: ruby bandit.rb [epsilon|ucb|softmax]"
  exit
end

n_trial = 500
n_candidates = 5

impl = nil

case algorithm
when "ucb"
  impl = Ucb.new([], [])
when "softmax"
  impl = Softmax.new(100, [], [])
when "epsilon"
  impl = EpsilonGreedy.new(0.5, [], [])
end

impl.init(n_candidates)


# run & save results
out = open("./out/#{algorithm}.csv", 'w')

1.upto(n_trial) do |i|

  arm = impl.select_arm
  puts "selected => #{arm}"
  impl.update(arm, 0.1 * rand * (arm + 1).to_f)

  out.write "#{i} " + impl.values.join(" ") + "\n"
end

out.close
