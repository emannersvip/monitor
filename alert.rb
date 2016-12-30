#!/usr/bin/ruby

require 'clamp'
require 'sqlite3'
require 'net/ping'

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

if preparser.help?
  puts "2017 Comprehensive Simple Alerter"
  puts "monitor host info <host/ip>\n\n"
end

#Open a new Datebase
db = SQLite3::Database.new "test.db"

#File.zero?("test.rb")
if File.size("test.db") == 0
  puts "Aborting you need to add new hosts"
end

db.execute( "select ip from hosts" ) do |row|
  p row
end


#def check_connectivity
#  db.execute("select * from hosts") do |row|
#  end
#end


