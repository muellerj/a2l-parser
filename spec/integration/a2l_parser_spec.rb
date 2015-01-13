require_relative "../spec_helper"
require_relative "../../lib/a2l_parser"

RSpec.describe A2lParser do

  let(:parser) { A2lParser.new(File.join(__dir__, "../fixtures/asap2_demo_v161.a2l"))}

  it "can parse simple A2L files" do
    expect(parser.characteristics.map(&:name)).to include("ASAM.M.SCALAR.UBYTE.IDENTICAL")
  end

end
