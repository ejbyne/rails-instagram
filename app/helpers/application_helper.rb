module ApplicationHelper

  def find_user_email(id)
    User.find(id).email
  end

end
