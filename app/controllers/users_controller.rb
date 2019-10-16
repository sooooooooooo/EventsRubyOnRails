class UsersController < ApplicationController
  skip_before_action :require_login, except: [:show, :update, :logout]
  def index
  end

  def create
  	user = User.create(user_params)
  	if user.valid?
  		flash[:success] = "Successfully registered"
      session[:user_id] = user.id
  		redirect_to "/events"
  	else
  		flash[:errors_reg] = user.errors.full_messages
  		redirect_to "/"
  	end
  end

  def login
  	user = User.find_by_email(params[:login_email]).try(:authenticate, params[:login_password])
  	if user
  		session[:user_id] = user.id
  		redirect_to "/events"
  	else
  		flash[:errors_login] = "You cannot be logged in"
  		redirect_to "/"
  	end
  end

  def logout
    session[:user_id] = nil
    flash[:success_logout] = "You've logged out"
    redirect_to "/"
  end

  def show
    if !User.exists?(params[:id])
      redirect_to "/events"
    end
  end

  def update
    updated_user = current_user
    updated_user.update(first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email], location: user_params[:location], state: user_params[:state])
    if updated_user.valid?
      flash[:success] = "Successfully updated profile"
      redirect_to "/events"
    else
      flash[:errors] = updated_user.errors.full_messages
      redirect_back fallback_location: user_path(id: session[:user_id])
    end
  end

  private
  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
  	end
end
