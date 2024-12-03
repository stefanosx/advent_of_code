file_content = File.read('inputs/1.txt')
locations = file_content.split("\n").map{ |lines| lines.split(" ") }

latitudes = locations.map { |loc| loc[0].to_i }.sort
longitudes = locations.map { |loc| loc[1].to_i }.sort

# This is the first part

if ARGV[0].to_i == 1
  total_distance = latitudes.map.with_index do |latitude, index|
    (latitude - longitudes[index]).abs
  end

  puts total_distance.sum
end

# the second part

if ARGV[0].to_i == 2
  total_distance = latitudes.map do |latitude|
    latitude * longitudes.count(latitude)
  end

  puts total_distance.sum
end

