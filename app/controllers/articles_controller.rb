require 'socket'
require 'net/http'
require 'uri'
require 'erb'
require 'oauth'

class ArticlesController < ApplicationController
  include ApplicationHelper

  before_action :request_login, only: [:edit, :new, :create, :update, :destroy, :hatena]

  def request_login
    if !loggedIn?
      redirect_to login_path
    end
  end

  def index
    if loggedIn?
      @articles = Article.all.order("created_at desc")
    else
      @articles = Article.where(private: false).order("created_at desc")
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def hatena
    @consumer = OAuth::Consumer.new(
      ENV['HATENA_CONSUMER_KEY'],
      ENV['HATENA_CONSUMER_SECRET'],
      :site => '',
      :request_token_path => 'https://www.hatena.com/oauth/initiate',
      :access_token_path => 'https://www.hatena.com/oauth/token',
      :authorize_path => 'https://www.hatena.ne.jp/oauth/authorize'
    )
    puts request.host_with_port
    request_token = @consumer.get_request_token(
      { :oauth_callback => 'http://' + request.host_with_port + '/callback' },
      :scope => 'read_public,write_public')

    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def callback
    requeust_token = OAuth.RequestToken.new(
      @consumer,
      session[:request_token],
      session[:request_token_secret])
    access_token = request_token.get_access_token(
      {},
      :oauth_verifier => params[:oauth_verifier])

    session[:requeust_token] = nil
    session[:request_token_secret] = nil

    session[:access_token] = access_token.token
    session[:access_token_secret] = access_token.secret

    erb :oauth_callback, :local => { :access_token => access_token }
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to '/articles'
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to '/articles'
    else
      rendor 'new'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :private)
  end
end
