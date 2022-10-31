class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    
  end 

  def index 
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end 

  def new
    @article = Article.new
    # Allows us to have an empty instance varable of article to do work on
    # Within the new.html.erb (before form submission as it is already available)
  end 

  def edit 
    
  end 

  def create
    @article  = Article.new(articles_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      render 'new'
    end
  end 

  def update
    
    if @article.update(articles_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article 
    else
      render 'edit'
    end
  end 

  def destroy 
    
    @article.destroy
    redirect_to articles_path
    # This will forward to the articles listing page
  end

  private

  def set_article
  @article = Article.find(params[:id])
  # Finds the article from the articles table using the id
  end

  def articles_params 
    params.require(:article).permit(:title, :description)
  end 

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end 
  end 

end 