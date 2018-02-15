class PostsController < ApplicationController

  before_action :ensure_current_user, {only:[:edit ,:destroy]}  
  before_action :authenticate_user!, {only:[ :new, :create, :new_tweet, :create_tweet]}
  
  def index
      @posts = Post.all.order(created_at: :desc)
  end
  
  def new
      @post = Post.new
  end
  
  def create
      #保存ボタン押した時の動き

      @post = Post.new(post_params)
          @post.user_id = current_user.id

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
  

  # 拡散ツイート機能
  
  def new_tweet
    
    if ShareUser.find_by(user_id: current_user.id)
      
    @post = Post.find_by(id: params[:id])
    random = SecureRandom.hex(8)
    @url = url_for(action: :show, id: params[:id], only_path: false, code:random)
    session[:code] = random
    
    else
      redirect_to("/posts/index")
      flash[:notice] = "ツイッターを登録してね！"
    end
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

  def crate_tweet
  
  require 'twitter'
  api = ShareUser.find_by(user_id: current_user.id)

  client = Twitter::REST::Client.new do |config|
    
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
    config.access_token = api.token
    config.access_token_secret = api.secret


  end

  @tweet = Share.new(
    user_id: @current_user.id,
    post_id: params[:id],
    content: params[:content],
    parameter: session[:code])

    #生成時のパラメータとコンテンツ内のパラメータがあってれば、つぶやき、save
    if @tweet.content.include?(session[:code])

      @tweet.save
      client.update(params[:content])
      session[:code] = nil

    #例えば
      #@current_user.depo += @current_user.level 
    
      redirect_to("/posts/index")
    else
      flash[:notice] = "URLが間違ってる可能性があるお"
      
    #とりあえずインデックスへ？？
      redirect_to("/posts/index")
    end
  end


end



private

#コンテンツの新規投稿フォームから受け取る情報属性をpost_paramsアクションで定義
def post_params
  params.require(:post).permit(:category, :title, :content)
  
end