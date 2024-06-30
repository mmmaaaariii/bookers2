class BooksController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    @books = Book.all
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end


  def index
    @user = current_user
    @book_new = Book.new
    @books = Book.all

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new

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
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path
    else
       render :edit
    end
  end
  

   private

    def book_params
      params.require(:book).permit(:title, :body)
    end
    
    def is_matching_login_user
      book = Book.find(params[:id])
      unless book.user_id == current_user.id
        redirect_to books_path
      end
    end

end
