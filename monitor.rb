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

if preparser.host?
  puts "2014 Comprehensive Simple Monitor"
end

#if ARGV[0] == "host"
#  puts "2014 Comprehensive Simple Monitor"
#end

#Open a new Datebase
db = SQLite3::Database.new "test.db"

#Create a database
#rows = db.execute <<-SQL
#  create table numbers (
#    name varchar(30),
#    val int
#  );
#SQL

#puts #{verbose}
#puts verbose
