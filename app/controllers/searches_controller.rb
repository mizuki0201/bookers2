class SearchesController < ApplicationController
  def search
    if params[:obj] == "Book"
      if params[:search_method] == "all"
        @books = Book.where(title: params[:content])
      elsif params[:search_method] == "after"
        @books = Book.where('title like ?', "%#{params[:content]}")
      elsif params[:search_method] == "before"
        @books = Book.where('title like ?', "#{params[:content]}%")
      end
      @book = Book.new
      render template: "books/index"
    end

    if params[:obj] == "User"
      if params[:search_method] == "all"
        @users = User.where(name: params[:content])
      elsif params[:search_method] == "after"
        @users = User.where('name like ?', "%#{params[:content]}")
      elsif params[:search_method] == "before"
        @users = User.where('name like ?', "#{params[:content]}%")
      end
      @book = Book.new
      render "users/index"
    end
  end
end
