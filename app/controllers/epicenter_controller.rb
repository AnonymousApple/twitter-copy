class EpicenterController < ApplicationController

  before_action :authenticate_user!, except: [:new_tweet_path]

  def feed
    @following_tweets = []
    Tweet.all.each do |tweet|
      if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
        @following_tweets.push(tweet)
      end
    end
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    current_user.following.push(params[:id].to_i)
    current_user.save

    redirect_to request.referrer
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save

    redirect_to request.referrer
  end
  def tag_tweets
    @tag = Tag.find(params[:id])
  end
  def all_users
    @users = User.all
    # or:
    # User.order(:username)
    # User.order(:name)
    # or whatever order you'd
    # like to put them in
  end
  def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
  end

  def followers
    @user =  User.find(params[:id])
    @users = []

    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end

  def about_account
    @created_at = current_user.created_at
    @just_updated = current_user.updated_at
  end
end
