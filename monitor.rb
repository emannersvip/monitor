require 'clamp'

class PreParser < Clamp::Command
  option ["-v", "--verbose"], :flag, "be verbose"
end

preparser = PreParser.new File.basename($0), {}
begin
  preparser.parse ARGV
rescue
end
