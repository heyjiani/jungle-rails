class Admin::DashboardController < ApplicationController
  def show
    @products_count = Product.sum(:quantity)
    @out_of_stock = Product.where(quantity: 0)
    @categories = Category.all
  end
end
