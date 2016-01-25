class User < ActiveRecord::Base

  has_many :portfolios
  has_many :stocks, through: :portfolios

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(auth)
      if user = self.where(provider: auth.provider, uid: auth.uid).first
        user
      else
        user = User.new(
        :provider => auth.provider,
        :uid => auth.uid,
        :name => auth.info.name,
        :email => auth.info.email,
        :password => Devise.friendly_token[0,20])
        user.skip_confirmation!
        user.save!
      end
  end


end
