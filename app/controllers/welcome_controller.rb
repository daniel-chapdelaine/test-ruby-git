class WelcomeController < ApplicationController

  def index
    @chef = Chef.new
    @sftp_user_names = @chef.sftp_user_names
  end
end
