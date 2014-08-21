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

welcome
