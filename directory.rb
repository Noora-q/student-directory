

def input_students
  puts "Please enter the names of the students".center(60)
  puts "To finish, just hit return twice".center(60)
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please provide cohort (month).".center(60)
    cohort = gets.chomp.capitalize! || "Unknown"
    puts "Please enter the student's country".center(60)
    country = gets.chomp.capitalize!
    # add the student hash to the array
    students << {name: name, cohort: cohort, country: country, language: :Ruby}

    if students.count == 1
      puts "Now we have #{students.count} student".center(60)
    else
      puts "Now we have #{students.count} students".center(60)
    end

    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(60)
  puts "-------------".center(60)
  puts "Please choose an initial".center(60)
  # gets initial
  @initial = gets.chomp.upcase
end


def print(students)
  students.each_with_index do |student, index|
    while student[:name].start_with?(@initial) && student[:name].length < 12
        puts "#{index + 1}. #{student[:name]} from #{student[:country]} learning #{student[:language]} (#{student[:cohort]} cohort)".center(60)
    break
    end
  end
end

# puts "For which cohort would you like to see the list of students?"
# cohort_choice = gets.chomp.capitalize!
# while student[:cohort] == cohort_choice
#   puts "#{student[:name]}"
# end

def print_footer(names)
  if names.count == 1
    puts "Overall, we have #{names.count} great student".center(60)
  else
    puts "Overall, we have #{names.count} great students".center(60)
  end
end

students = input_students
# nothing happens until we call the methods
print_header
print(students)
print_footer(students)
