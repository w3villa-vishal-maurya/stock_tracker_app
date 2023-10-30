class UsersController < ApplicationController
  def index
  end


  def show
    @user = User.find(params[:id])
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    # binding.pry
    # @tracked_stocks = current_user.stocks
    @my_friends = current_user.friends
  end


  def remove_friend
    friend = User.find(params[:id])
    remove_friend = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    remove_friend.destroy
    flash[:alert] = "#{friend.first_name} removed from your following list."
    redirect_to my_friends_path
  end

  def search
    if params[:friend].present?
      @friend = User.where(first_name: params[:friend]).first
      if @friend
        # render "users/my_portfolio"
        if @friend.email == current_user.email
          flash[:alert] = "User Not Found!"
          redirect_to my_friends_path
        elsif !current_user.is_friend?(@friend, current_user)
          Friendship.create(user_id: current_user.id, friend_id: @friend.id)
          flash[:alert] = "#{@friend.first_name}, Successfully added to your following list."
          redirect_to my_friends_path
        else
          flash[:alert] = "#{@friend.first_name} is already in your following list."
          redirect_to my_friends_path
        end
      else
        flash[:alert] = "User Not Found!"
        redirect_to my_friends_path
      end
    else
      flash[:alert] = "Please enter a name to search"
      redirect_to my_friends_path
    end
  end
end
