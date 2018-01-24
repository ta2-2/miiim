class PostsController < ApplicationController
  def index
      @posts = Post.all.order(created_at: :desc)
  end
  
  def new
      @post = Post.new
  end
  
  def create
    @post = Post.new(
      content: params[:content])
    if @post.save
      flash[:notice] = "投稿を作成しました"
      
      redirect_to("/posts/index")
       else
      render("posts/new")
    end
  end
  
  
  def show
      @post = Post.find_by(id: params[:id])
  end
  
  
  
  
end
