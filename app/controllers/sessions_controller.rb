class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      check_activation
    else
      flash.now[:danger] = t "sessions.new.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
  end

  def check_activation
    if @user.activated?
      log_in @user
      params[:session][:remember_me] == Settings.user.remember ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      message = t ".message"
      flash[:warning] = message
      redirect_to root_url
    end
  end
end
