# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates(:username, :password_digest, :session_token, {presence: true})
  validates(:username, {uniqueness: true}) #runs query with DB to compare
  validates :password, {length: {minimum: 6}, allow_nil: true}
  #validate what needs to go into DB, not going to be run until try to save/#valid?/update, just a firewall before anything goes into DB
  #doesn't validate on #new and use #errors.full_messages to see array of messages

  #AR makes getter methods for each attribute in the validation
  attr_reader :password

  after_initialize :ensure_session_token
  #called every time User is initlaized

  #called right when User is initialized
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  #need this method to check against user logging in
  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  #if you don't have setter for password, AR will read password as nil and still be able
  #to save the record

  # User.new(username: username, session_token: session_token, password_digest: password_digest)
  #   @username = username
  #   @session_token = session_token
  #   @password_digest = password_digest
  # end
  #
  # User.new(username: username, password: password)
  #   @username = username
  #   @password = password
  # end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  #this is just setting it on the model level and will be saved to DB
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save! #save will not throw error and only return true/false and save! will return true/error
    # error can't be part of conditional, we don't want it to fail quiety here
    self.session_token
  end

  #don't want to give user new session_token on every initalization of user, beucase initialization
  #happens all the time (User.find_by, User.new, during other requests, User.all. if it resets,
  #then user would end up having a different token and wouldn't be logged in)
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def self.find_by_credentials(username, password) #you don't have specific user, just parameters to find the user
    #so you use class method
    user = User.find_by(username: username) #this returns nil if user doesn't exist in database (ie. mistype username)
    return user if user && user.valid_password?(password)
    #this would return an error without the first condition because calling valid_password?
    #on nil would return ruby error and that would just break the program
  end

end
