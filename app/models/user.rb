class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def diary_entries
    DiaryEntry.where(user_id: self.id)
  end

  def is_admin?
    email == 'greg.shailes@gmail.com' || email == 'jo.shailes@hotmail.co.uk'
  end

end
