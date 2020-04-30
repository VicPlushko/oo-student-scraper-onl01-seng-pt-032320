class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    self.send('name=', student_hash[:name])
    self.send('location=', student_hash[:location])
    self.send('profile_url=', student_hash[:profile_url])
    @@all << self
  end

  def self.create_from_collection(students_array)
    student_array.each do |student_info|
      Student.new(student_info)
    end
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    
  end
end

