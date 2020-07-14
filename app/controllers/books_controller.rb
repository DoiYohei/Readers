class BooksController < ApplicationController
  def search
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(keyword: params[:keyword])
    end
  end
end