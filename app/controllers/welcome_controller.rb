class WelcomeController < ActionController::Base

  def index
    render json: {status: 200, message: 'Yay It is working!'}
  end

end
