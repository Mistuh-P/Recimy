class RecipesController < ApplicationController

  before_action :fix_directions

  def index
    @recipes = Recipe.all.order('created_at DESC')
    @current_user = current_user

  end

  def new
    is_authenticated?
    @current_user = current_user
    @recipe = Recipe.new
    @tags = Tag.all
  end

  def create
    is_authenticated?
    @current_user = current_user
    @recipe = Recipe.create(recipe_params)
    current_user.recipes << @recipe

    # render :json => params

    tags = params[:recipe][:tag_ids]
    tags.each do |t|
      @recipe.tags << Tag.find(t) unless t.blank?
    end
    redirect_to @recipe
  end

  def favorite
    is_authenticated?

    current_user.favorites << Recipe.find(params[:id])

    redirect_to cookbook_path

  end

  def remove_favorite


  end

  def show
    @current_user = current_user
    @recipe = Recipe.find(params[:id])
    @tag = @recipe.tags

    list = flickr.photos.search :text => @recipe.name, :sort => "relevance"
    photos = list.map do |i|
       "https:/farm3.static.flickr.com/#{i["server"]}/" "#{i["id"]}_" "#{i["secret"]}_n.jpg"
    end
    @photo = photos.sample

p @recipe.user_id
p @current_user
  end

  def edit
    @current_user = current_user
    @recipe = Recipe.find(params[:id])
    @tags = Tag.all

  end

  def update
    @current_user = current_user
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)

    @recipe.tags.clear

    tags = params[:recipe][:tag_ids]
    tags.each do |t|
      @recipe.tags << Tag.find(t) unless t.blank?
    end


    redirect_to @recipe

  end

  def destroy
    @current_user = current_user
    @recipe = Recipe.destroy(params[:id])
    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name,:ingredients,:directions,:id)
  end


  def fix_directions
      if params[:recipe].present?
        params[:recipe][:directions] = params[:recipe][:directions].to_s.gsub('.', '~').to_s
      end
  end


end