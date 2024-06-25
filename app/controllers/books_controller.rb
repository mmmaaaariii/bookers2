class BooksController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render :new
    end
  end


  def index
    @user = current_user
    @books = Book.all
  end

  def show
    @user = current_user
    @book = Book.new
    @books = @user.books

  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 投稿一覧画面へリダイレクト
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path  
  end
  

   private

    def book_params
      params.require(:book).permit(:title, :body)
    end
    
    def is_matching_login_user
      book = Book.find(params[:id])
      unless book.user_id == current_user.id
        redirect_to top_path
      end
    end

end
