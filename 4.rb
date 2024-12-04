file_content = File.read('inputs/4.txt')
puzzle = file_content.split("\n")

if ARGV[0].to_i == 1
  def count_word_occurrences(grid, word)
    rows = grid.size
    cols = grid[0].size
    word_length = word.size
    count = 0
    directions = [
        [0, 1],  # Horizontal right
        [0, -1], # Horizontal left
        [1, 0],  # Vertical down
        [-1, 0], # Vertical up
        [1, 1],  # Diagonal down-right
        [-1, -1], # Diagonal up-left
        [1, -1], # Diagonal down-left
        [-1, 1]  # Diagonal up-right
      ]

    check_direction = lambda do |x, y, dx, dy|
      (0...word_length).all? do |i|
        nx, ny = x + i * dx, y + i * dy
        nx.between?(0, rows - 1) && ny.between?(0, cols - 1) && grid[nx][ny] == word[i]
      end
    end

    # Search the grid for the word in all directions
    grid.each_with_index do |row, x|
      row.chars.each_with_index do |_, y|
        directions.each do |dx, dy|
          count += 1 if check_direction.call(x, y, dx, dy)
        end
      end
    end

    count
  end

  puts count_word_occurrences(puzzle, "XMAS")
end

if ARGV[0].to_i == 2
  def count_x_shapes(grid, word)
    rows = grid.size
    cols = grid[0].size

    count = 0

    # Iterate through each cell, treating it as the center of the X
    (1...rows - 1).each do |x|
      (1...cols - 1).each do |y|
        # Check the X shape
        center = grid[x][y]
        top_left = grid[x - 1][y - 1]
        top_right = grid[x - 1][y + 1]
        bottom_left = grid[x + 1][y - 1]
        bottom_right = grid[x + 1][y + 1]

        # Check if the X shape matches "MAS" in any order
        if [top_left, top_right, center, bottom_left, bottom_right] == [word[0], word[2], word[1], word[0], word[2]] ||
          [top_left, top_right, center, bottom_left, bottom_right] == [word[0], word[0], word[1], word[2], word[2]] ||
          [top_left, top_right, center, bottom_left, bottom_right] == [word[2], word[0], word[1], word[2], word[0]] ||
          [top_left, top_right, center, bottom_left, bottom_right] == [word[2], word[2], word[1], word[0], word[0]]
          count += 1
        end
      end
    end

    count
  end

  puts count_x_shapes(puzzle, word)
end



