class PostsController < ApplicationController
 
before_action :ensure_current_user, {only:[:edit ,:destroy]}  

  def index
      @posts = Post.all.order(created_at: :desc)
  end
  
  def new
      @post = Post.new
  end
  
  def create
      #保存ボタン押した時の動き

      @post = Post.new(post_params)
        if params[:content_submit] 
          @post.post_on = true
          @post.user_id = current_user.id
          @post.save
          flash[:notice] = "投稿しました"
        redirect_to(posts_path)
        
        else
        @post.post_on = false
        @post.user_id = current_user.id
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
    flash[:notice] = "投稿を削除しました"
    redirect_to(posts_path)

  end
  
 # 編集権限があるかどうかを見極めるための記述
  def ensure_current_user
      @post = Post.find_by(id: params[:id] )
         if  current_user.id != @post.user_id
           flash[:notice] = "権限がありません"
             return_back and return

         end
  end
  
end



private

def post_params
  params.require(:post).permit(:category, :title, :content)
  
end