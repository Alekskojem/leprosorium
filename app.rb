require 'rubygems'
require 'sinatra'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'leprosorium.db'
	@db.results_as_hash = true
end

before do
	init_do
end

configure do
	init_db
db.execute 'CREATE TABLE IF NOT EXISTS Post
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	created_date DATE,
	content TEXT
)'


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/new' do
 erb :new
end

post '/new' do
 content = params[:content]
erb "You taped #{content}"
end
end
