# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id).page params[:page]
  end
end

