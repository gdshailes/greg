class PopulateNameInUsers < ActiveRecord::Migration[5.0]

  class LocalUser < ActiveRecord::Base
    self.table_name = 'users'
  end

  def up
    LocalUser.all.each do |user|
      user.update_attributes(first_name: gregorjo(user.email), last_name: gregorjoshailes(user.email), email: gregorjoemail(user.email))
    end
  end

  def down
  end

  private

    def gregorjo(email)
      case email
      when 'greg.shailes@gmail.com'
        'Greg'
      when 'jo.shailes@hotmail.com'
        'Jo'
      when 'jo.shailes@hotmail.com/jo'
        'Jo'
      when 'jo.shailes@hotmail.comjo'
        'Jo'
      else
        email
      end
    end

    def gregorjoshailes(email)
      case email
      when 'greg.shailes@gmail.com'
        'Shailes'
      when 'jo.shailes@hotmail.com'
        'Shailes'
      when 'jo.shailes@hotmail.com/jo'
        'Shailes'
      when 'jo.shailes@hotmail.comjo'
        'Shailes'
      else
        ''
      end
    end

    def gregorjoemail(email)
      case email
      when 'greg.shailes@gmail.com'
        email
      when 'jo.shailes@hotmail.com'
        email
      when 'jo.shailes@hotmail.com/jo'
        'jo.shailes@hotmail.com'
      when 'jo.shailes@hotmail.comjo'
        'jo.shailes@hotmail.com'
      else
        'jo.shailes@hotmail.com'
      end
    end

end
