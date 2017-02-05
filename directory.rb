puts File.read(__FILE__)

require 'csv'
@students = [] # an empty array accessible to all methods

def add_to_students(name,cohort,country)
  @students << {name: name, cohort: cohort.to_sym, country: country, language: :Ruby}
end

def print_menu
  # 1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    # 1. print the menu and ask the user what to do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    puts "You have chosen to provide the students' details, please follow the instructions".center(60)
    puts "To finish, just hit return twice".center(60)
    input_students
  when "2"
    puts "You have chosen to display the students' details".center(60)
    show_students
  when "3"
    save_students
    puts "Students' details have been saved".center(60)
  when "4"
    load_students
    puts "Loaded students' details, to see them select 2".center(60)
  when "9"
    puts "Bye!".center(60)
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again".center(60)
  end
end

def input_students
  puts "First, enter the name of the student".center(60)
  # get the first name
  name = STDIN.gets.chomp
  name = "Unknown" if name.empty?
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please provide cohort (month)".center(60)
    cohort = STDIN.gets.chomp.capitalize.to_sym
    cohort = "Unknown".to_sym if cohort.empty?
    puts "Please enter the student's country".center(60)
    country = STDIN.gets.chomp.capitalize
    # # add the student hash to the array
    add_to_students(name,cohort,country)
    puts "Added student details!"

    if @students.count == 1
      puts "Now we have #{@students.count} student, add another name or hit enter to end".center(60)
    else
      puts "Now we have #{@students.count} students, add another name or hit enter to end".center(60)
    end
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy".center(60)
  puts "-------------".center(60)
  puts "Please type an initial or hit return to see all students".center(60)
  # gets initial from user
  @initial = STDIN.gets.chomp.upcase
end

def print_student_list
  if @students.count >= 1
    @students.sort_by{|student| student[:cohort]}.each_with_index do |student, index|
      while student[:name].start_with?(@initial) && student[:name].length < 12
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort) from #{student[:country]} studying #{student[:language]}".center(60)
        break
      end
    end
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student".center(60)
  else
    puts "Overall, we have #{@students.count} great students".center(60)
  end
end

def save_students
puts "Enter the name of the file to which you would like to save the students' details".center(60)
filename = STDIN.gets.chomp
filename = "students.csv" if filename.empty?
  # open the file for writing
  CSV.open(filename, "a+") do |file|
  # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:country]]
      csv_line = student_data.join(",")
      file << student_data #csv_line
    end
  end
  puts "Saved!"
end

def load_students(filename = "students.csv")
puts "Enter the name of the file from which you would like to load the students' details".center(60)
filename = STDIN.gets.chomp
filename = "students.csv" if filename.empty?
CSV.foreach(filename) do |line|
    name,cohort,country = line
    add_to_students(name,cohort,country)
  end
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}".center(60)
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist.".center(60)
    exit # quit the program
  end
end

try_load_students
interactive_menu
