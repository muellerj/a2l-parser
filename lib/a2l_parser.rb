require "treetop"
require_relative "label"

require "awesome_print"
require "pry"

class A2lParser

  Treetop.load File.join(__dir__, "../grammar/a2l")
  require_relative "../grammar/a2l"

  def initialize(data)
    @data = data.respond_to?(:read) ? data.read : data
  end

  def characteristics
    walk_tree(ast) { |node| node.class == A2lGrammar::Characteristic }.
      map { |c| Label.from_a2l(c) }
  end

  private

  def ast
    unless @ast ||= a2l_parser.parse(@data)
      a2l_parser.failure_reason =~ /^(expected .+) after/m
      puts "#{$1.gsub("\n", '$newline')}:"
      puts @data.lines.to_a[a2l_parser.failure_line - 1]
      puts "#{'~' * (a2l_parser.failure_column - 1)}^"
      return
    end
    @ast
  end

  def a2l_parser
    @a2l_parser ||= A2lGrammarParser.new
  end

  def walk_tree(root_node, ary=[], &block)
    ary << root_node.to_array if block.call(root_node)
    root_node.elements.each { |node| walk_tree(node, ary, &block) } if root_node.elements
    ary
  end
end

ap A2lParser.new(DATA.read.gsub(/^ {2}/, "")).characteristics

__END__

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

