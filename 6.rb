require 'pry'
file_content = File.read('inputs/6.txt')
real_map = file_content.split("\n")

test_map = [
"....#.....",
".........#",
"..........",
"..#.......",
".......#..",
"..........",
".#..^.....",
"........#.",
"#.........",
"......#..."
]

map = test_map.map{|m| m.split("")}

def out_of_bounds?(grid, x, y)
  x < 0 || y < 0 || x >= grid.length || y >= grid[x].length
end

start_position = []
map.each_with_index do |row, x|
  y = row.index { |r|  r == "^" }
  if y
    start_position = [x, y]
    break
  end
end

if ARGV[0].to_i == 1
  def mark_and_move(to_mark, direction, map)
    map[to_mark[0]][to_mark[1]] = "X"
    new_position = case direction
    when "up"
      [to_mark[0] - 1, to_mark[1]]
    when "right"
      [to_mark[0], to_mark[1] + 1]
    when "down"
      [to_mark[0] + 1, to_mark[1]]
    when "left"
      [to_mark[0], to_mark[1] - 1]
    end
    next_element = map.dig(new_position[0], new_position[1])

    return if out_of_bounds?(map, new_position[0], new_position[1])

    if next_element != "#"
      return new_position, direction
    else
      direction = case direction
      when "up"
        return [to_mark[0], to_mark[1] + 1], "right"
      when "right"
        return [to_mark[0] + 1, to_mark[1]], "down"
      when "down"
        return [to_mark[0], to_mark[1] - 1], "left"
      when "left"
        return [to_mark[0] - 1, to_mark[1]], "up"
      end
    end
  end

  new_position, direction = mark_and_move(start_position, "up", map)
  while new_position
    # puts "new: #{new_position}, dir: #{direction}"
    new_position, direction = mark_and_move(new_position, direction, map)
  end

  puts map.map{ |e| e.count("X") }.sum
end

if ARGV[0].to_i == 2

  map.each { |d| puts d.join.inspect }
end