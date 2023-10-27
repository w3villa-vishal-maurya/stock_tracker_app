class UserStocksController < ApplicationController

    def destroy
        stock = Stock.find(params[:id])
        user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
        user_stock.destroy
        flash[:alert] = "#{stock.ticker} removed from your portfolio."
        redirect_to my_portfolio_path
    end
end
