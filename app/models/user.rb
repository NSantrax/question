class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]
  has_many :answers
  has_many :quests
  has_many :authorizations
  has_many :comments
  
  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]

    
    email ||= auth.uid.to_s + '@test.com'
   
    user = User.where(email: email).first  
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)

    end
    user.authorizations.create(provider: auth.provider, uid: auth.uid)
    user
  end

  def self.daily_mailer_digest
    find_each.each do |user|
      DailyMailer.digest(user)
    end
  end
end
