
@students = [] # an empty array accessible to all methods

def print_menu
  # 1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students".center(60)
  puts "To finish, just hit return twice".center(60)
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please provide cohort (month)".center(60)
    cohort = STDIN.gets.chomp.capitalize || "Unkown"
    # puts "Please enter the student's country".center(60)
    # country = STDIN.gets.chomp.capitalize!
    # # add the student hash to the array
    @students << {name: name, cohort: cohort, country: :country, language: :Ruby}

    if @students.count == 1
      puts "Now we have #{@students.count} student".center(60)
    else
      puts "Now we have #{@students.count} students".center(60)
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
  puts "Please type an initial or press enter to see all students".center(60)
  # gets initial from user
  puts "Please choose an initial".center(60)
  # gets initial
  @initial = STDIN.gets.chomp.upcase
end


def print_student_list
  @students.each_with_index do |student, index|
    while student[:name].start_with?(@initial) && student[:name].length < 12
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(60)
        # puts "#{index + 1}. #{student[:name]} from #{student[:country]} learning #{student[:language]} (#{student[:cohort]} cohort)".center(60)
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

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Saved!"
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym}
    end
    file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end


try_load_students
interactive_menu
