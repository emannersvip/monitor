#!/usr/bin/ruby

require 'clamp'
#https://github.com/fazibear/colorize/blob/master/README.md
#Magenta, Cyan, RGYB, White , Black
require 'colorize'
#http://stackoverflow.com/questions/1050749/including-a-ruby-class-from-a-separate-file
require 'net/ping'
require_relative 'lib/host'
require_relative 'lib/db'

class PreParser < Clamp::Command
  option ["-h", "--help"], :flag, "be helpful"
  option ["-v", "--verbose"], :flag, "be verbose"

  parameter "HOST", "Target host"
end

def print_host_list()
  monitordb = SQLite3::Database.new "monitor.db"
  puts "Printing host list"
  monitordb.execute("select * from hosts") do |row|
  #TODO add colors
    p row
  end
end

#TODO a subnet discover using discover.rb class

preparser = PreParser.new File.basename($0), {}
begin
  preparser.parse ARGV
rescue
end

#def execute
# puts "bob" if help?
#end

if preparser.help?
  #puts String.colors
  puts "2017 Comprehensive Simple Monitor".green
  #puts "monitor".colorize(:color => :light_blue, :background => :red) + "host list\n\n"
  #puts "monitor ".colorize(:color => :light_black) + "host list\n\n"
  puts "monitor ".colorize(:color => :magenta) + "host list\n\n"
  exit
end

#if preparser.host?
#  puts "2014 Comprehensive Simple Monitor"
#end

#if ARGV[0] == "host"
#  puts "2014 Comprehensive Simple Monitor"
#end

#Open a new Datebase
monitordb = SQLite3::Database.new "monitor.db"

if ARGV[0] == "host"
  #Create host object for the future
  puts "Configuring Host"

  if ARGV[1] == "list"
    print_host_list()
  #Neds input cleaning
  elsif ARGV[1] == "add"
    puts "Adding new host"
    mon_host = Host.new(ARGV[2], ARGV[3])

    monitordb.execute("INSERT INTO hosts (name,ip)
                VALUES (?, ?)", [ARGV[2], ARGV[3]])
  #Needs input cleaning
  elsif ARGV[1] == "discover"
    puts "Discovering new hosts"
    if ARGV[2] == nil
      discovered_ips = `/usr/bin/ruby lib/discover.rb`.split("\n")
    else
      discovered_ips = `/usr/bin/ruby lib/discover.rb #{ARGV[2]}`.split("\n")
    end

    discovered_ips.each do |ip|
      #[1..-1] removes first char from string
      #chop removes last char from string
      #puts ip.split("_")[0]+"----"+ip.split("_")[1][1..-1].chop
#--This insert needs to be in a function
#--This needs to first check that thes hosts dont already exist, maybe make the IP column inthe DB unique
      monitordb.execute("INSERT INTO hosts (name,ip)
                         VALUES (?, ?)", [ip.split("_")[0], ip.split("_")[1][1..-1].chop])
    end
  elsif ARGV[1] == "remove"
    puts "Removing host"
#add check for IP or Name (regex)
    #db.execute("DELETE from hosts where name = #{ARGV[2]}")
    monitordb.execute("DELETE from hosts where id = #{ARGV[2]}")
  elsif ARGV[1] == "info"
    puts "Printing host monitor info"
    #add check for IP or Name (regex)
    alertsdb = SQLite3::Database.new "alerts.db"
    alertsdb.execute("SELECT * from alerts where name = #{ARGV[2]}")
  end
  else
    puts "Bad command"
end

def check_connectivity
  monitordb.execute("select * from hosts") do |row|
  end
end


