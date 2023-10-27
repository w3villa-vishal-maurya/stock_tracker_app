class UsersController < ApplicationController
    def index
    end

    def my_portfolio
        @tracked_stocks = current_user.stocks
    end
end