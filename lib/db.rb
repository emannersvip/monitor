require 'sqlite3'

#Create Databases
alertsdb = SQLite3::Database.new "alerts.db"
monitordb = SQLite3::Database.new "monitor.db"

if File.size("alerts.db") == 0
  puts "Making new tables and DB for Alerts"
  rows = alertsdb.execute <<-SQL
    create table alerts (
      id integer primary key autoincrement,
      name varchar(64),
      ip varchar(16),
      status integer
    );
  SQL
end

if File.size("monitor.db") == 0
  puts "Making new tables and DB for Monitor"
  rows = monitordb.execute <<-SQL
    create table hosts (
      id integer primary key autoincrement,
      name varchar(64),
      ip varchar(16)
    );
  SQL
end
