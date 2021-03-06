class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You are successfully registered! Welcome to Alpha Blog, #{@user.username}"
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account is updated!"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and its associations has been deleted"
    redirect_to articles_path, status: :see_other
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if @user != current_user and !current_user.admin?
      flash[:alert] = "Unauthorized user!"
      redirect_to user_path(current_user)
    end
  end
end
