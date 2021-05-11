class HomeController < ApplicationController

  def index
    # @articles = Article.all
    @pagy, @articles = pagy(Article.all, items: 10)
    @user = current_user
  end
end
