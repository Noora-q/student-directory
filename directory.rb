

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please enter the student's country"
    country = gets.chomp
    # add the student hash to the array
    students << {name: name, cohort: :november, country: country, language: :ruby}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end


def print(students)
  puts "Please choose an initial"
  # gets initial
  initial = gets.chomp.upcase
  students.each_with_index do |student, index|
    while student[:name].start_with?(initial) && student[:name].length < 12
        puts "#{index + 1}. #{student[:name]} from #{student[:country]} learning #{student[:language]} (#{student[:cohort]} cohort)"
        break
    end
  end
end


def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
# nothing happens until we call the methods
print_header
print(students)
print_footer(students)
