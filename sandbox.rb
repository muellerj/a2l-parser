require "rubygems"
require "treetop"
Treetop.load File.join(__dir__, "grammar/a2l")

parser = A2lGrammarParser.new

puts "A"
puts parser.parse "hello Jonas"
puts "B"
puts parser.parse "hello jonas"


