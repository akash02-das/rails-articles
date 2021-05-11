class ArticlesController < ApplicationController
  load_and_authorize_resource

  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :search]

  # GET /articles or /articles.json
  def index
    # @articles = Article.all
    @pagy, @articles = pagy(Article.all, items: 10)
    @user = current_user
  end

  # Search Articles
  def search
    @pagy, @articles = pagy(Article.where('title ILIKE ? OR body ILIKE ?', "%#{params[:q]}%", "%#{params[:q]}%"), items: 10)
    @user = current_user
  end

  # GET /articles/1 or /articles/1.json
  def show
    @user = current_user
  end

  # GET /articles/new
  def new
    # @article = Article.new
    @article = current_user.articles.build
    @user = current_user
  end

  # GET /articles/1/edit
  def edit
    @user = current_user
  end

  # POST /articles or /articles.json
  def create
    # @article = Article.new(article_params)
    @article = current_user.articles.build(article_params)
    @article.user = current_user
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def correct_user
  #   @article = current_user.articles.find_by(id: params[:id])
  #   redirect_to articles_path, notice: 'Not authorized to edit this article' if @article.nil?
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :user_id, images: [], :category_ids => [])
    end
end
