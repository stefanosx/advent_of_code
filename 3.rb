file_content = File.read('inputs/3.txt')
mul_regex = /mul\(\d{1,3},\d{1,3}\)/

def mul(x, y)
  x * y
end

def get_sum(arr)
  params_regex = /mul\((.*?)\)/

  arr.map do |match|
    params = match.match(params_regex)[1].split(',').map(&:strip).map(&:to_i)
    mul(params[0], params[1])
  end.sum
end


if ARGV[0].to_i == 1
  matches = file_content.scan(mul_regex)

  puts get_sum(matches)
end

if ARGV[0].to_i == 2
  # Regex to find `don't()`...`do()` blocks and all `mul(X,Y)` calls
  dont_do_regex = /don't\(\)[\s\S]*?do\(\)/

  # Find ranges of `don't()`...`do()` blocks
  excluded_ranges = file_content.enum_for(:scan, dont_do_regex).map { Regexp.last_match.offset(0) }

  # Find all `mul(X,Y)` matches with their positions
  matches = file_content.enum_for(:scan, mul_regex).map do
    match = Regexp.last_match
    { match: match[0], start: match.begin(0), end: match.end(0) }
  end

  # Keep only `mul(X,Y)` calls that are outside excluded ranges
  valid_matches = matches.reject do |m|
    excluded_ranges.any? { |start_pos, end_pos| m[:start] >= start_pos && m[:end] <= end_pos }
  end

  # Extract the valid `mul(X,Y)` calls
  result = valid_matches.map { |m| m[:match] }

  puts get_sum(result)
end
