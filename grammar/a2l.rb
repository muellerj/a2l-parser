module A2lGrammar
  class Document < Treetop::Runtime::SyntaxNode
  end

  class Characteristic < Treetop::Runtime::SyntaxNode
    def to_array
      text_value
    end
  end
end
