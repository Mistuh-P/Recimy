class UsersController < ApplicationController

def new
end

def create
  @user = User.new(user_params)
  if @user.save
    redirect_to login_path
    flash[:success] = "User Created!"
  else
    flash[:danger] = "Didnt Work!"
    render 'new'
  end
end

def show
  @current_user = current_user
  @recipes = @current_user.recipes

end

private

def user_params
  params.require(:user).permit(:name,:email,:password)
end



end