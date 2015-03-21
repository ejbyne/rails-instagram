module ApplicationHelper

  def find_username(id)
    User.find(id).username
  end

end
