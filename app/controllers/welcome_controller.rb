class WelcomeController < ApplicationController
  def index
    @pages = Page.all
    @articles = Article.limit(5).order("created_at desc")
  end
end
