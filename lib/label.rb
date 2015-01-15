class Label

  require_relative "../grammar/characteristic"
  Treetop.load File.join(__dir__, "../grammar/characteristic")

  attr_reader :name, :ecu_address, :value, :description

  def initialize(name:, ecu_address:, value:, description: "")
    @name, @ecu_address, @value, @description = name, ecu_address, value, description
  end

  def self.from_a2l(str)
    new(name: "FOO", ecu_address: 0x21122, value: 10)
    #puts walk_tree(ast(str)) { |node| node.class == CharacteristicGrammar::Property }
  end

  def to_s
    "Label #{name} <0x#{ecu_address.to_s(16)}>"
  end

  alias :inspect :to_s

  private

  def self.ast(data)
    unless ast = characteristic_parser.parse(data)
      characteristic_parser.failure_reason =~ /^(Expected .+) after/m
      puts "#{$1.gsub("\n", '$NEWLINE')}:"
      puts data.lines.to_a[characteristic_parser.failure_line - 1]
      puts "#{'~' * (characteristic_parser.failure_column - 1)}^"
      return
    end
    ast
  end

  def self.walk_tree(root_node, ary=[], &block)
    ary << root_node.to_array if block.call(root_node)
    root_node.elements.each { |node| walk_tree(node, ary, &block) } if root_node.elements
    ary
  end

  def self.characteristic_parser
    @characteristic_parser = CharacteristicGrammarParser.new
  end

end
