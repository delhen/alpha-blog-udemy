class ArticlesController < ApplicationController
  def index
    # Create instance variable so it can be accessed into ERB format view
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
