class AdminController < MainController
  layout 'admin'

  before_action :require_admin
end