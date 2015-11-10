module Admin::UsersHelper

  def user_status user
    if user.confirmed
      content_tag :span, "Confirmed", class: 'label label-success'
    else
      content_tag :span, "Not confirmed", class: 'label label-warning'
    end
  end

  def user_role user
    if user.role == 'admin'
      content_tag :span, "Admin", class: 'label label-default'
    else
      content_tag :span, "User", class: 'label label-info'
    end
  end
end
