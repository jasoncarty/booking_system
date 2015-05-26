class AdminController < MainController
  layout 'admin'

  before_filter :require_admin
end