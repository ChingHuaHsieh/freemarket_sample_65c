class MypageController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:index, :logout, :profile]

  def index
  end

  def logout
  end

  def profile
  end

  def set_category
    @parents = Category.all.order(id: "ASC").limit(13)
  end
end
