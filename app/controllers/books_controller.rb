class BooksController < ApplicationController

  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    # impressionist(@book, nil, unique: [:session_hash])
    @book_new = Book.new
    @book_user = @book.user
    @book_comment = BookComment.new
    impressionist(@book, unique: [:ip_address])
    # impressionist(@book_user, nil, :unique => [:session_hash])
    # ←詳細ページにいくとPV数が1つ増える
  end

  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> a.favorited_users.includes(:favorites).where(created_at: from...to).size}
    # @books = Book.all
    # @book_rank = @book.joins(:favorites).last_week.group(:id).order("count(*) desc")
    # @books = Book.joins(:favorites).where(favorites: {created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
    # @books = Book.favorites.where(favorites: {created_at: 0.days.ago.prev_week..6.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
    # @books = Book.find(Favorite.group(:favorite_id).order('count(favorite_id) desc')
    # @books = Book.find.where(favorites: {created_at: 0.days.ago.prev_week..6.days.ago.prev_week(:sunday)}).group(:book_id).order('count(book_id) desc').limit(5).pluck(:book_id)
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
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
