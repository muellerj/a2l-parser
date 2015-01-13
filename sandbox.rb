require "rubygems"
require "treetop"

require "awesome_print"
require "pry"

Treetop.load File.join(__dir__, "grammar/a2l")
parser = A2lGrammarParser.new

TESTA2L = <<-EOS.gsub(/^ {2}/, "")
  /begin CHARACTERISTIC foo.bar.bay
    "Scalar FW U16 and CDF20 as name"
    VALUE
    0x810000
    RL.FNC.UBYTE.ROW_DIR
    0
    CM.IDENTICAL
    10 200
    EXTENDED_LIMITS 0 256
    DISPLAY_IDENTIFIER DI.ASAM.C.SCALAR.UBYTE
  /end CHARACTERISTIC
EOS

puts TESTA2L
ap parser.parse(TESTA2L).to_hash

