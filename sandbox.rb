require "rubygems"
require "treetop"

require "awesome_print"
require "pry"

def parse(data)
  require_relative "grammar/a2l"
  Treetop.load File.join(__dir__, "grammar/a2l")
  parser = A2lGrammarParser.new
  ast = parser.parse(data)

  if ast
    characteristics = walk_tree(ast) { |klass| klass == A2L::Characteristic }
    ap characteristics
  else
    parser.failure_reason =~ /^(Expected .+) after/m
    puts "#{$1.gsub("\n", '$NEWLINE')}:"
    puts data.lines.to_a[parser.failure_line - 1]
    puts "#{'~' * (parser.failure_column - 1)}^"
  end
end

def walk_tree(root_node, ary=[], &block)
  ary << root_node.to_array if block.call(root_node.class)
  (root_node.elements || []).each { |node| walk_tree(node, ary, &block) }
  ary
end


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

  /begin CHARACTERISTIC K_Cnt_FIS_DAQ_IGKN_RNG_dec "0x1A040C (DTC (Hex): 0x1A040C)"
    VALUE 0x803CBAA1 _REC_S1VAL_1_u1 0 _CNV_R_R_CM_Def_8_0_CM 0 255
    FORMAT "%6.0"
    DISPLAY_IDENTIFIER K_Cnt_FIS_DAQ_IGKN_RNG_dec
    /begin ANNOTATION
      ANNOTATION_LABEL "Calibration Note"
      /begin ANNOTATION_TEXT
        "0x1A040C (DTC (Hex): 0x1A040C)"
      /end ANNOTATION_TEXT
    /end ANNOTATION
  /end CHARACTERISTIC
EOS

parse(TESTA2L)

