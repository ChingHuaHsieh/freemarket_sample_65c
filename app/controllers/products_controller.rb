class ProductsController < ApplicationController

  def index
    @parents = Category.all.order("id ASC").limit(13)
  end

  def new
    @parents = Category.all.order("id ASC").limit(13)
  end

  def show
    @parents = Category.all.order("id ASC").limit(13)
  end
end
