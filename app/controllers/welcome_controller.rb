class WelcomeController < ApplicationController
  def index
    render nothing: true, status: 403
  end
end
