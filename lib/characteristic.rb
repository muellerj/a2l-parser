class Characteristic

  attr_reader :name, :ecu_address, :description

  def initialize(name:, ecu_address:, description: "")
    @name, @ecu_address, @description = name, ecu_address, description
  end

  def to_s
    "Characteristic #{name}"
  end

end
