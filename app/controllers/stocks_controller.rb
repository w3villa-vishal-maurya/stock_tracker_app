class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        # render "users/my_portfolio"
        if current_user.can_track_stock?(@stock.ticker)
          @stock.save
          UserStock.create(user_id: current_user.id, stock_id: @stock.id)
          flash[:alert] = "Successfully added, Stock to your Portfolio!"
          redirect_to my_portfolio_path
        elsif current_user.stock_already_track?(@stock.ticker)
          flash[:alert] = "User already tracking this stock!"
          redirect_to my_portfolio_path
        else
          flash[:alert] = "You are already tracking 10 stocks!"
          redirect_to my_portfolio_path
        end
      else
        flash[:alert] = "Please enter a valid symbol to search"
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = "Please enter a symbol to search"
      redirect_to my_portfolio_path
    end
  end
end
