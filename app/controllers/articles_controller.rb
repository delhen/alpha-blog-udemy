class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy, :edit, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :delete]

  def index
    # Create instance variable so it can be accessed into ERB format view
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    # Strong parameters
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article created successfully!"
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
    # render plain: @article.inspect
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article successfully deleted!"
    redirect_to articles_path, status: :see_other
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if @article.user != current_user and !current_user.admin?
        flash[:alert] = "You can only edit and delete your own article!"
        redirect_to user_path(current_user)
      end
    end
end
