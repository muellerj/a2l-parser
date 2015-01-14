module A2L
  class Document < Treetop::Runtime::SyntaxNode
  end

  class Characteristic < Treetop::Runtime::SyntaxNode
    def to_array
      text_value.lines
    end
  end
end
