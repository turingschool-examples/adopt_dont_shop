class Admin::Shelter < Shelter
  def self.admin_display
    find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
  end
end
