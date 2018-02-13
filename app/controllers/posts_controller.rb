class PostsController < ApplicationController
  before_action :authenticate_user!, {only:[ :new, :create, :new_tweet, :create_tweet]}
  
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
  
  
  #拡散ツイートのセーブと判定
  
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