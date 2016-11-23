class StaticPagesController < ApplicationController
  def home
    if logged_in?
    @micropost = current_user.microposts.build 
    @feed_items = current_user.feed_items.includes(:user).order(create_at: :desc)
    end  
  end
end
