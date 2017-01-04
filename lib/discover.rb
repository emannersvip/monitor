#Must be run as 'root'

require 'fileutils'
require 'netaddr'
require 'resolv'
require 'sqlite3'

#If arguments are given do scan that network
if ARGV[0] != nil
  #Write subnet to file and run pingsweep
  File.open("./lib/subnets.txt", 'w') {|file| file.write(ARGV[0]+"\n") }
  discover_subnet = ARGV[0].split('/')[0]
  discover_cidr = ARGV[0].split('/')[1]
else
  #If no arguments are given do local network
  #puts "Using current subnet"
  #TODO write code to find current interface's IP
  File.open("./lib/subnets.txt", 'w') {|file| file.write("144.174.35.0/24") }
  discover_subnet = '144.174.35.0'
end


#https://github.com/pentestgeek/scripts/wiki/pingsweep.rb
#puts "#{ENV['PWD']}"
`./lib/pingsweep.rb ./lib/subnets.txt`
$?.exitstatus => return error code

#Check if the hosts directory was successfully created
#http://stackoverflow.com/questions/4897568/how-to-check-if-a-directory-file-symlink-exists-with-one-command
hosts_dir = './hosts'
if File.directory?(hosts_dir)
  begin
    f = File.open("hosts/#{discover_subnet}_hosts.txt")
  rescue Errno::ENOENT
    puts "Pingsweep failed to run or find hosts. Exiting..."
    exit
  end
    f.each do |ip|
    #https://ruby-doc.org/stdlib-1.9.2/libdoc/resolv/rdoc/Resolv.html
    #http://stackoverflow.com/questions/27834603/resolve-domain-from-ip-address-using-ruby
    #https://coderwall.com/p/lhkkug/don-t-confuse-ruby-s-throw-statement-with-raise
    begin
      hostname = Resolv.getname ip.chomp
      puts ip.chomp+"_(#{hostname})"
    rescue Resolv::ResolvError
      hostname = 'NoDNS.rcc.fsu.edu'
      puts ip.chomp+"_(#{hostname})"
    end
  end 

  #Finally remove hosts directories
  #http://stackoverflow.com/questions/12335611/ruby-deleting-directories
  if File.directory?("hosts")
    FileUtils.remove_dir("hosts")
    #FileUtils.rm_rf("hosts")
  end
  #Finally remove pingsweep directories
  if File.directory?("pingsweep")
    FileUtils.remove_dir("pingsweep")
  end
else
  puts "Ping sweep failed"
end
