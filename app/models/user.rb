class User < ActiveRecord::Base

  has_many :portfolios
  has_many :stocks, through: :portfolios
  has_many :alerts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable,
    :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
    else
      return_user = self.create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.username = auth.info.username
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        return_user.skip_confirmation!
        return_user.save!
      end
    end

    return_user
  end

  def self.from_dummy
    @password = Faker::Internet.password(8)
    dummy_user =  User.new(
      :name => Faker::Superhero.name,
      :email => Faker::Internet.email ,
      :password => @password,
      :password_confirmation => @password
    )
    dummy_user.skip_confirmation!
    dummy_user.save!
    return dummy_user
  end

end
