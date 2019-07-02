class Dog
  attr_accessor :id, :name, :breed

  def initialize(attr_hash)
    @id = id
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

end
