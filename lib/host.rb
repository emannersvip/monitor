#Monitor_Host.rb
#define  class Monitor_Host

#class Monitor_Host
class Host
  def initialize(name,ip)
    #Instance variables
    @name = name
    @ip   = ip
  end

  def info
    puts "Hostname: #{@name}"
    puts "IP Address: #{@ip}"
  end
end
