class ArticlesController < ApplicationController
  def index
    # Create instance variable so it can be accessed into ERB format view
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    # Strong parameters
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article created successfully!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
    # render plain: @article.inspect
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article updated successfully!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article successfully deleted!"
    redirect_to articles_path
  end
end
