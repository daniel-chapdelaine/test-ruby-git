class WelcomeController < ApplicationController
  def index
    @git = Chef.new
  end
end
