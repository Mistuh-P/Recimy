class TagsController < ApplicationController

def index
  @current_user = current_user
  @tags = Tag.all
end


def new
  @current_user = current_user
  @tag = Tag.new()
end

def create
  @current_user = current_user
  @tag = Tag.create(tag_params)
  redirect_to tags_path #:tags

end

def edit
  @current_user = current_user
  @tag = Tag.find(params[:id])
end

def update
  @current_user = current_user
   @tag = Tag.update(params[:id], tag_params)
  redirect_to tags_path
end

def show
  @current_user = current_user
    @tag = Tag.find(params[:id])
    @recipes = @tag.recipes

  end

def destroy
  @current_user = current_user

   @tag = Tag.find(params[:id])


   if @tag.recipes.length == 1

    flash[:danger] = "Can't delete! There is #{ @tag.recipes.length } creature using this tag!"

   elsif @tag.recipes.length > 1

    flash[:danger] = "Can't delete! There are #{ @tag.recipes.length } recipes using this tag!"

   else

    @tag.destroy

  end



    redirect_to tags_path
end

private

def tag_params
    params.require(:tag).permit(:name)
end

end