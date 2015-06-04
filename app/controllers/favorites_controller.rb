class FavoritesController < ApplicationController

  def index

    @current_user = current_user

  end

  def new

    @favorite = Favorite.new

  end

  def create

    @current_user = current_user

    @favorite = Favorite.create({where:{user_id=@current_user}})

    redirect_to cookbook_path



  end



end