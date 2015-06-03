class SessionsController < ApplicationController


  def new
  end



  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password_digest])

     if @user
      session[:user_id] = @user.id
      flash[:success] = "Login Successful!"
      redirect_to root_path
    else
      flash[:danger] = "Credentials Invalid"
      render :new
    end

  end



  def destroy
    session[:user_id] = nil
    flash[:info] = "User has logged out"
    redirect_to root_path
  end



end