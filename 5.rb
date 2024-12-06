file_content = File.read('inputs/5.txt')

test_file = "47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47"



rules, updates = file_content.split("\n\n")

rules = rules.split("\n").map { |line| line.split("|") }
updates = updates.split("\n")

valid_pages = []
invalid_pages = []
updates.map do |update|
  pages = update.split(",")

  valid = true

  pages.each_with_index do |page, index|
    page_to_check = pages[index]
    relevant_rules = rules.select { |rule| rule.include?(pages[index]) }

    should_be_after = relevant_rules.select {|r| r[0] == page_to_check}.map {|r| r[1]}.flatten.uniq
    should_be_before = relevant_rules.select {|r| r[1] == page_to_check}.map {|r| r[0]}.flatten.uniq

    # binding.pry
    if pages[(index + 1)..].find { |p| should_be_before.include?(p) }
      valid = false
      break
    end

    if pages[...index].find { |p| should_be_after.include?(p) }
      valid = false
      break
    end
  end

  if valid
    valid_pages << pages
  else
    invalid_pages << pages
  end
end

if ARGV[0].to_i == 1
  puts valid_pages.map { |rule| rule[rule.size / 2].to_i}.sum
end

if ARGV[0].to_i == 2
  correct_array = []
  invalid_pages.each do |invalid_page|
    page_size = invalid_page.size
    page_size.times do
      i = 1
      while i < invalid_page.size
        arr = [invalid_page[i-1], invalid_page[i]]

        relevant_rule = rules.find do |rule|
          rule if rule.sort == arr.sort
        end
        # binding.pry if relevant_rules
        # binding.pry
        if arr != relevant_rule
          invalid_page[i-1] = arr[1]
          invalid_page[i] = arr[0]
        end

        i += 1
      end
    end

    correct_array << invalid_page
  end


  puts correct_array.map { |rule| rule[rule.size / 2].to_i}.sum
end
