class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google]

  def diary_entries
    DiaryEntry.where(user_id: self.id)
  end

  def is_admin?
    is_greg? || is_jo?
  end

  def is_greg?
    email == 'greg.shailes@gmail.com'
  end

  def is_jo?
    email == 'jo.shailes@hotmail.co.uk'
  end

  def display_name
    first_name || name || email || 'guest'
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
      if data = session['devise.google_data'] && session['devise.google_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
    end
  end

end
