class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

end
