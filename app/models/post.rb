class Post < ApplicationRecord
  belongs_to :user

  def formatted_created_at
    cst_time = created_at.in_time_zone('Central Time (US & Canada)')
    cst_time.strftime('%a, %d %b %Y %l:%M %p')
  end

end
