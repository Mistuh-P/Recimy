class RecipesUsers < ActiveRecord::Base
  belongs_to_many :recipe
  belongs_to_many :user
end
