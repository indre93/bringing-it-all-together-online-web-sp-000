class Dog
  attr_accessor :id, :name, :breed

  def initialize(attr_hash)
    @id = id
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = DROP TABLE dogs
    DB[:conn].execute(sql)
  end

end
