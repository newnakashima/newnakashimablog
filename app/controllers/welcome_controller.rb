class WelcomeController < ApplicationController
  def index
    @pages = Page.all
    @articles = Article.where(private: false).limit(5).order("created_at desc")
  end
end
