

def input_students
  puts "Please enter the names of the students".center(60)
  puts "To finish, just hit return twice".center(60)
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please enter the student's country".center(60)
    country = gets.chomp
    # add the student hash to the array
    students << {name: name, cohort: :november, country: country, language: :ruby}
    puts "Now we have #{students.count} students".center(60)
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(60)
  puts "-------------".center(60)
end


def print(students)
  puts "Please choose an initial".center(60)
  # gets initial
  initial = gets.chomp.upcase
  students.each_with_index do |student, index|
    while student[:name].start_with?(initial) && student[:name].length < 12
        puts "#{index + 1}. #{student[:name]} from #{student[:country]} learning #{student[:language]} (#{student[:cohort]} cohort)".center(60)
        break
    end
  end
end


def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(60)
end

students = input_students
# nothing happens until we call the methods
print_header
print(students)
print_footer(students)
