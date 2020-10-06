require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?format=json&title=ruby&hits=5&applicationId=1015404481217467453')
json = Net::HTTP.get(uri)
result = JSON.parse(json)
books = result["Items"]
books.each do |data|
  Book.create(book_tittle: data['Item']['title'], author: data['Item']['author'], image: data['Item']['largeImageUrl'])
end