require 'active_record'
require './lib/knight'
require './lib/quest'
require './lib/favorite_color'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "*** Welcome to the Knight Tracker ***"
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "Press 'k1' to add a knight, 'k2' to list your knights, or 'ko' to mark a knight dead"
    puts "Press 'c1' to add a favorite color, 'c2' to list favorite colors, or 'c3' to assign a knight to a favorite color."
    puts "Press 'q1' to add a quest, 'q2' to list all quests, or 'q3' to assign a quest to a knight."
    puts "press 'x' to exit\n\n"
    choice = gets.chomp
    case choice
    when 'k1'
      add_knight
    when 'k2'
      list_knights
    when 'ko'
      mark_dead
    when 'c1'
      add_color
    when 'c2'
      list_colors
    when 'c3'
      assign_color
    when 'c4'
      puts "KABOOM"
      sleep(1.5)
      system 'clear'
      welcome
    when 'q1'
      add_quest
    when 'q2'
      list_quests
    when 'q3'
      assign_quest
    when 'x'
      puts 'til the morrow'
    else
      puts 'What is this sorcery?'
    end
  end
end

def add_knight
  puts "Which brave noble shall be add to the Round Table?"
  knight_name = gets.chomp
  knight = Knight.new({:name => knight_name, :dead => false})
  knight.save
  puts "'#{knight_name}' has been added to the Round Table."
end

def list_knights
  puts "Here are your Knights of the Round Table:"
  knights = Knight.where({:dead => false})
  knights.each { |knight| puts knight.name }
end

def add_quest
  puts "What. Is your quest?"
  quest_name = gets.chomp
  quest = Quest.new({:name => quest_name, :done => false})
  quest.save
  puts "Now you must go '#{quest_name}'"
end

def list_quests
  puts "Noble deeds to do:"
  quests = Quest.all
  quests.each { |quest| puts quest.name }
end

def add_color
  puts "What. Is your faaaaaaavorite color?"
  color_name = gets.chomp
  color = Favorite_Color.new(:name => color_name)
  color.save
  object_number = rand(5) + 1
  if object_number == 1
    @object = "river"
  elsif object_number == 2
    @object = "cross"
  elsif object_number == 3
    @object = "sword"
  elsif object_number == 4
    @object = "mountain"
  elsif object_number == 5
    @object = "dragon"
  elsif object_number == 6
    @object = "chicken"
  end
  puts "The Knights of the #{color.name} #{@object}"
end

def list_colors
  puts "The Knights of the Round Table have many faaaaaavorite colors:"
  colors = Favorite_Color.all
  colors.each { |color| puts color.name}
end

def assign_color
  puts "Who. Has a faaaaaaavorite color?"
  list_knights
  knight_input = gets.chomp
  knight = Knight.find_by(name: knight_input)
  puts "What. Is #{knight.name}'s faaaaaaaaaaaaaaaaaaaaaaaaaaaaaavorite color?"
  list_colors
  color_input = gets.chomp
  color = Favorite_Color.find_by(name: color_input)
  knight.update(:favorite_color => color.name)
  puts "\n\n#{knight.name} is now assigned to #{color.name}.\n\n"
end

def mark_dead
  puts "Who has died?!"
  list_knights
  knight_input = gets.chomp
  knight = Knight.where({:name => knight_input}).first
  knight.update({:dead => true})
end

welcome
