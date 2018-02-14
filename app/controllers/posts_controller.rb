class PostsController < ApplicationController
 
  def index
      @posts = Post.all.order(created_at: :desc)
  end
  
  def new
      @post = Post.new
  end
  
  def create
      #保存ボタン押した時の動き

      @post = Post.new(post_params,
      user_id: @current_user.id)
        if params[:content_submit] 
          @post.post_on = true
          @post.save
          flash[:notice] = "投稿しました"
        redirect_to(posts_path)
        
        else
        @post.post_on = false
        @post.save
        flash[:notice] = "投稿を保存しました"
          
        redirect_to(posts_path)

          
        end
    
  end
  
  
  def show
      @post = Post.find_by(id: params[:id] )
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
        @post.update(post_params)
        
        if params[:content_submit] 
          @post.post_on = true
          @post.save
          flash[:notice] = "投稿しました"
          
        redirect_to(posts_path)
        
        else
        @post.post_on = false
        @post.save
        
        flash[:notice] = "投稿を保存しました"
          
        render(new_post_path)

          
        end
    
  end
  
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]
    redirect_to("/posts/index")
  end
  
  
  
end

private

def post_params
  params.require(:post).permit(:category, :title, :content)
  
end