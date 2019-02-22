class User < ApplicationRecord
  include PgSearch
 
  after_save :reindex
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]
  has_many :answers
  has_many :quests
  has_many :authorizations
  has_many :comments
  has_many :subscriptions, dependent: :destroy
  has_many :posts, through: :subscriptions, dependent: :destroy

  multisearchable against: :email
  
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

  private

  def reindex
    PgSearch::Multisearch.rebuild(Quest)
  end
end
