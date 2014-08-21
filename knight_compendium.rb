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
      add
    when 'k'
      list
    when 'x'
      puts 'til the morrow'
    else
      puts 'What is this sorcery?'
    end
  end
end

def add
  puts "Which brave noble shall be add to the Round Table?"
  knight_name = gets.chomp
  knight = Knight.new({:name => knight_name, :dead => false})
  knight.save
  puts "'#{knight_name}' has been added to the Round Table."
end

def list
  puts "Here are your Knights of the Round Table:"
  knights = Knight.all
  knights.each { |knight| puts knight.name }
end

welcome
