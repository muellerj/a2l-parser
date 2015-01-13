require_relative "../spec_helper"
require_relative "../../lib/characteristic"

RSpec.describe Characteristic do

  let(:characteristic) { Characteristic.new(name: "foo", ecu_address: "0x12412") }

  it "cannot be instanciated without a name and ecu_address" do
    expect{ Characteristic.new }.to raise_error(ArgumentError)
    expect{ Characteristic.new(name: "foo") }.to raise_error(ArgumentError)
    expect{ Characteristic.new(ecu_address: "bar") }.to raise_error(ArgumentError)
    expect{ Characteristic.new(name: "foo", ecu_address: "bar") }.not_to raise_error
  end

  it "prints nicely" do
    expect(characteristic.to_s).to eq "Characteristic foo"
  end

end
