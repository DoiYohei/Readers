class BooksController < ApplicationController
  def search
    @books = Book.search(params[:search])
  end
  
  def show
    @book = Book.find(params[:id])
  end
end