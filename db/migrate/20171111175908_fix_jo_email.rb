class FixJoEmail < ActiveRecord::Migration[5.0]

  class LocalUser < ActiveRecord::Base
    self.table_name = 'users'
  end

  def up
    LocalUser.where(email: 'jo.shailes@hotmail.com').each do |user|
      user.update_attributes(email: 'jo.shailes@hotmail.co.uk'
    end
  end

end
