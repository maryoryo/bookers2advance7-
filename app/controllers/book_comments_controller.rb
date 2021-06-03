class BookCommentsController < ApplicationController

  before_action :books_comments_params
  

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      # redirect_to book_path(@book), notice: "You have created bookcomment successfully."
    else
      @book_comment = @comment
      @book_user = @book.user
      # render "books/show"
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # redirect_to book_path(params[:book_id])
  end


private

  def books_comments_params
     @book = Book.find(params[:book_id])
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
