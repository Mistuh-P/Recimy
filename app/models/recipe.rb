class Recipe < ActiveRecord::Base

  has_and_belongs_to_many :tags

  belongs_to :user

  has_and_belongs_to_many :favoriters, :class_name => 'User', :join_table => :recipes_users


  validates :name, :ingredients, :directions, presence: true






end
