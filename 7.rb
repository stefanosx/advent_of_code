require 'pry'

file_content = File.read('inputs/7.txt')

test_input = "190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20"

puzzle = file_content.split("\n").map { |line| line.split(":") }.map { |line| {line[0].to_i => line[1].split(" ").map(&:to_i)}}

if ARGV[0].to_i == 1
  def generate_combinations(array)
    n = array.size - 1
    results = []

    # Generate all possible operator combinations for `n` operators
    (0...(2**n)).each do |combination|
      operators = combination.to_s(2).rjust(n, '0').chars.map { |bit| bit == '0' ? :+ : :* }
      steps = [] # To store the calculation steps

      # Calculate result step-by-step, left-to-right
      result = array[0]
      steps << result.to_s

      array[1..].each_with_index do |num, i|
        operator = operators[i]
        result = result.send(operator, num)
        steps << "#{operator} #{num}"
      end

      results << result
    end

    results
  end


  data = []
  puzzle.each do |hash|
    result = hash.keys.first
    values = hash.values.flatten
    combinations = generate_combinations(values)
    data << result if combinations.include?(result)
  end

  puts data.sum
end

if ARGV[0].to_i == 2

  def generate_combinations(array)
    n = array.size - 1
    results = []

    # Define custom operation handlers
    custom_operations = {
      :+ => ->(a, b) { a + b },
      :* => ->(a, b) { a * b },
      :'||' => ->(a, b) { (a.to_s + b.to_s).to_i }
    }

    # Generate all possible operator combinations for `n` operators
    operator_combinations = custom_operations.keys.repeated_permutation(n).to_a

    operator_combinations.each do |operators|
      # steps = [] # To store the calculation steps

      # Calculate result step-by-step, left-to-right
      result = array[0]
      # steps << result.to_s

      array[1..].each_with_index do |num, i|
        operator = operators[i]
        result = custom_operations[operator].call(result, num)
        # steps << "#{operator} #{num}"
      end

      results << result
    end

    results
  end

  data = []
  puzzle.each do |hash|
    result = hash.keys.first
    values = hash.values.flatten
    combinations = generate_combinations(values)
    data << result if combinations.include?(result)
  end

  puts data.sum

end