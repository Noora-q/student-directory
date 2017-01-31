

def input_students
  puts "Please enter the names of the students".center(60)
  puts "To finish, just hit return twice".center(60)
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please provide cohort (month)".center(60)
    cohort = gets.chomp.capitalize || "Unkown"
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
  puts "Please type an initial or press enter to see all students".center(60)
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
  # sorts students by cohort
  sorted = students.group_by{|student| student[:cohort]}
  # puts sorted.map {|cohort,student| "#{student}"}.join(', ')
  # puts "which cohort?"
  # choice = gets.chomp
  puts sorted
end

def print_footer(names)
  if names.count == 1
    puts "Overall, we have #{names.count} great student".center(60)
  else
    puts "Overall, we have #{names.count} great students".center(60)
  end
end

# students = input_students
# # nothing happens until we call the methods
# print_header
# print(students)
# print_footer(students)

def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
