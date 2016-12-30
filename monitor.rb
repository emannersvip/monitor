#!/usr/bin/ruby

require 'clamp'
require 'sqlite3'
#http://stackoverflow.com/questions/1050749/including-a-ruby-class-from-a-separate-file
require_relative 'lib/host'
#require 'lib/host'

class PreParser < Clamp::Command
  option ["-h", "--help"], :flag, "be helpful"
  option ["-v", "--verbose"], :flag, "be verbose"

  parameter "HOST", "Target host"
end


preparser = PreParser.new File.basename($0), {}
begin
  preparser.parse ARGV
rescue
end

#def execute
# puts "bob" if help?
#end

if preparser.help?
  puts "2017 Comprehensive Simple Monitor"
  puts "monitor host list\n\n"
end

#if preparser.host?
#  puts "2014 Comprehensive Simple Monitor"
#end

#if ARGV[0] == "host"
#  puts "2014 Comprehensive Simple Monitor"
#end

#Open a new Datebase
db = SQLite3::Database.new "test.db"

#File.zero?("test.rb")
if File.size("test.db") == 0
  puts "Make new tables"
  
  #Create a database
  #http://sqlite.org/autoinc.html
  rows = db.execute <<-SQL
    create table hosts (
      id integer primary key autoincrement,
      name varchar(64),
      ip varchar(16)
    );
  SQL
end

if ARGV[0] == "host"
  #Create host object for the future
  puts "Configuring Host"

  if ARGV[1] == "list"
    puts "Printing host list"
    db.execute("select * from hosts") do |row|
      p row
    end
  #Neds input cleaning
  elsif ARGV[1] == "add"
    puts "Adding new host"
    mon_host = Host.new(ARGV[2], ARGV[3])

    db.execute("INSERT INTO hosts (name,ip)
                VALUES (?, ?)", [ARGV[2], ARGV[3]])
  #Neds input cleaning
  elsif ARGV[1] == "remove"
    puts "Removing host"
#add check for IP or Name (regex)
    #db.execute("DELETE from hosts where name = #{ARGV[2]}")
    db.execute("DELETE from hosts where id = #{ARGV[2]}")
  elsif ARGV[1] == "info"
    puts "Printing host monitor info"
    #add check for IP or Name (regex)
    #db.execute("DELETE from hosts where name = #{ARGV[2]}")
    #db.execute("DELETE from hosts where id = #{ARGV[2]}")
  end
end

def check_connectivity
  db.execute("select * from hosts") do |row|
  end
end


