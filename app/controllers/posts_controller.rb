class PostsController < ApplicationController
  def index
      @posts = Post.all.order(created_at: :desc)
      
    
  end
  
  def new
      @post = Post.new
  end
  
  def create
      #保存ボタン押した時の動き

      @post = Post.new(
        #if @current_user 
        #  user_id: @current_user
        #end
        category: params[:category],
        title: params[:title],
        content: params[:content],
        )
        if params[:content_submit] 
          @post.post_on = true
          @post.save
          flash[:notice] = "投稿しました"
        redirect_to("/posts/index")
        
        else
        
        @post.save
        flash[:notice] = "投稿を保存しました"
          
        render("/posts/new")

          
        end
    
  end
  
  
  def show
      @post = Post.find_by(id: params[:id])
  end
  
  
  
  
end
