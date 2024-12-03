file_content = File.read('inputs/2.txt')
levels = file_content.split("\n").map{ |lines| lines.split(" ").map(&:to_i) }

def safe?(arr)
  is_increasing = arr.each_cons(2).all? { |a, b| a < b }
  is_decreasing = arr.each_cons(2).all? { |a, b| a > b }
  one_to_three = arr.each_cons(2).all? { |a, b| (a-b).abs.between?(1, 3) }

  if (is_increasing || is_decreasing) && one_to_three
    true
  else
    false
  end
end


### first part

if ARGV[0].to_i == 1
  safe_levels = levels.select do |level|
    level if safe?(level)
  end

  puts safe_levels.size
end

###### second part

if ARGV[0].to_i == 2
  def double_check_safe?(arr)
    arr.each_with_index.any? do |_, index|
      new_arr = arr[0...index] + arr[index+1..-1]
      safe?(new_arr)
    end
  end

  safe_levels = levels.select do |level|
    if safe?(level)
      level
    else
      level if double_check_safe?(level)
    end
  end

  puts safe_levels.size
end
