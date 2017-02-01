
@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students".center(60)
  puts "To finish, just hit return twice".center(60)
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please provide cohort (month)".center(60)
    cohort = gets.chomp.capitalize || "Unkown"
    puts "Please enter the student's country".center(60)
    country = gets.chomp.capitalize!
    # add the student hash to the array
    @students << {name: name, cohort: cohort, country: country, language: :Ruby}

    if @students.count == 1
      puts "Now we have #{@students.count} student".center(60)
    else
      puts "Now we have #{@students.count} students".center(60)
    end
    # get another name from the user
    name = gets.chomp
  end
end


def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    print_menu
    process(gets.chomp)
  end
end


def print_menu
  # 1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" # 9 because we'll be adding more items
end


def show_students
  print_header
  print_student_list
  print_footer
end


def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end


def print_header
  puts "The students of Villains Academy".center(60)
  puts "-------------".center(60)
  puts "Please type an initial or press enter to see all students".center(60)
  # gets initial from user
  @initial = gets.chomp.upcase
end


def print_student_list
  @students.each_with_index do |student, index|
    while student[:name].start_with?(@initial) && student[:name].length < 12
        puts "#{index + 1}. #{student[:name]} from #{student[:country]} learning #{student[:language]} (#{student[:cohort]} cohort)".center(60)
    break
    end
  end
  # sorts students by cohort
  sorted = @students.group_by{|student| student[:cohort]}
  # puts sorted.map {|cohort,student| "#{student}"}.join(', ')
  # puts "which cohort?"
  # choice = gets.chomp
  puts sorted
end


def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student".center(60)
  else
    puts "Overall, we have #{@students.count} great students".center(60)
  end
end


interactive_menu
