require "rubygems"
require "treetop"
require "ostruct"
require "characteristic"

class A2lParser

  Treetop.load File.join(__dir__, "../grammar/a2l")

  def initialize(filename)
    @filename = filename
    @rawcontent = File.open(filename, "rb").read
    @parser = A2lGrammarParser.new
  end

  def characteristics
    #[OpenStruct.new(name: "ASAM.M.SCALAR.UBYTE.IDENTICAL")]
    @characteristics ||= @parser.parse(@rawcontent)
  end

end
