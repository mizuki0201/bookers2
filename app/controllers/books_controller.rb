class BooksController < ApplicationController
  impressionist :actions => [:show]

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comments = @book.book_comments
    @new_comment = BookComment.new
    impressionist(@book, nil, unique: [:session_hash.to_s])
  end

  def index
    @books = Book.all.sort { |a, b|
      b.favorite_count <=> a.favorite_count
    }
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    # bookの所有者ではないユーザーがURLに直接アクセスした場合にbook一覧にリダイレクトする
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
