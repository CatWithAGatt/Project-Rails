class ArticlesController < ApplicationController
	include ArticlesHelper

	#before_filter :require_login, except: [:show]
	before_filter :require_login, only: [:new, :create, :edit, :update, :destroy]

	def index
		@articles = Article.all
	end

	def show
		@article = finder #Article.find(params[:id])
		@comment = Comment.new
		#@comment = @article.comments.new	don't use
		@comment.article_id = @article.id
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.save

		flash.notice = "Article '#{@article.title}' created!"

		redirect_to article_path(@article)
	end

	def edit
		@article = finder #Article.find(params[:id])
	end

	def update
		@article = finder
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' updated!"

		redirect_to article_path(@article)
	end

	def destroy
		@article = finder #Article.find(params[:id])
		@article.destroy

	flash.notice = "Article '#{@article.title}' deleted!"

		redirect_to articles_path
	end

	private
	  def finder
	  	Article.find(params[:id])
	  end
end
