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
    sql =  <<-SQL
      DROP TABLE dogs
    SQL
    DB[:conn].execute(sql)
  end

  def save
      if self.id
        self.update
      else
        sql = <<-SQL
          INSERT INTO dogs (name, breed)
          VALUES (?, ?)
        SQL

        DB[:conn].execute(sql, self.name, self.breed)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      end
      self
    end

  def self.create(attr_hash)
    dog = self.new(attr_hash)
    dog.save
    dog
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    row = DB[:conn].execute(sql, id)[0]
    self.new(id: row[0])
  end

  def self.find_or_create_by(name:, breed:)
    dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed)
    if !dog.empty?
      dog_data = dog[0]
      dog = self.new(id: dog_data[0],name: dog_data[1],breed: dog_data[2])
    else
      dog = self.create(name: name, breed: breed)
    end
    dog
  end

  def self.new_from_db(row)
  # create a new Student object given a row from the database
    new_student = self.new(row)
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
end

end
