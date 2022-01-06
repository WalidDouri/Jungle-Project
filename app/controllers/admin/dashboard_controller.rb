class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => "Jungle", :password => "book"

  def show
    @category_list = Category.all
    
    @product_count = Product.count();

  end
end
