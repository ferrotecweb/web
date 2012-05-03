class Agents < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  validates_confirmation_of :password
  validates_presence_of :name, :password
  validates_uniqueness_of :name

  before_save :crypte_password

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  def encrypt(password)
    self.class.encrypt(password,salt)
  end

  def self.authenticate(name,password)
    agent = find_by_name(name)
    agent && agent.authenticated?(password) ? agent : nil
  end

  def authenticated?(password)
    hashed_password == encrypt(password)
  end

  private
  def crypte_password
    return unless password
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{name}--") if new_record?
    self.hashed_password = encrypt(password)
  end
end
