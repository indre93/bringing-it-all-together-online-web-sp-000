class Dog
  attr_accessor :id, :name, :breed

  def initialize(id = nil, name:, breed:)
    @id = id
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def initialize(attr_hash)
      attr_hash.each do |key, value|
        self.send("#{key}=", value)
      end

end
