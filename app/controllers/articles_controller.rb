class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @user = current_user
    if @article.save
      flash[:notice] = "Post added successfully"
      redirect_to article_path(@article)
    else
      flash[:error] = @article.errors.full_messages.join(". ")
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @user = @article.user
  end

  private

  def article_params
    params.require(:article).permit(:title, :body).merge(user: current_user)
  end
end
