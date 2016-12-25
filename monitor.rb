#!/usr/bin/ruby

require 'clamp'
require 'sqlite3'

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
      name varchar(64)
    );
  SQL
end

if ARGV[0] == "host"
  puts "Configuring Host"
  if ARGV[1] == "list"
    puts "Printing host list"
    db.execute("select * from hosts") do |row|
      p row
    end
  elsif ARGV[1] == "add"
    puts "Adding new host"
    #db.execute("INSERT INTO hosts (id, name)
    #            VALUES (?, ?)", [1, ARGV[2]])
    db.execute("INSERT INTO hosts (name)
                VALUES (?)", [ARGV[2]])
  end
end

#puts #{verbose}
#puts verbose
