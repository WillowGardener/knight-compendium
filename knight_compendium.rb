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
    puts "Press 'a' to add a knight, 'k' to list your knights, or 'd' to mark a knight dead"
    puts "press 'x' to exit"
    choice = gets.chomp
    case choice
    when 'a'
      add_knights
    when 'k'
      list_knights
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
  knights = Knight.all
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

def add_favorite_color
  puts "What. Is your faaaaaaavorite color?"
  favorite_color_name = gets.chomp
  favorite_color = Favorite_Color.new(:name => favorite_color_name)
  favorite_color.save
  object_number = rand(5) + 1
  if object_number == 1
    @object = "river"
  if object_number == 2
    @object = "cross"
  if object_number == 3
    @object = "sword"
  if object_number == 4
    @object = "mountain"
  if object_number == 5
    @object = "dragon"
  if object_number == 6
    @object = "chicken"
  end
  puts "The Knights of the '#{favorite_color}'' '#{@object}'"
end

def list_favorite_colors
  puts "The Knights of the Round Table have many faaaaaavorite colors:"
  colors = Favorite_color.all
  colors.each { |color| puts color.name}
end

welcome
