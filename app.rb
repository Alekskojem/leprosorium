require 'rubygems'
require 'sinatra'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'leprosorium.db'
	@db.results_as_hash = true
end
# before визивается каждий раз при перезагрузке
# любой страници
before do
  # Инициализация БД
  init_db
end
# configure визивается каждий рвз при конфигурации приложения:
# когда изменячется код программи или что то ввели
# или перезгрузилась страница
configure do
  #Инициализауия БД
	 init_db
   # Создает таблицу если таблица еще не существует
   @db.execute 'CREATE TABLE IF NOT EXISTS Post
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	created_date DATE,
	content TEXT
)'
end

# обработчик get запроса /new
# (браузер получает страницу с сервера)
get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/new' do
 erb :new
end

post '/new' do
# Получаем переменную из Post запроса /new
# (браузер отправляет страницу на сервер)
 content = params[:content]
 
 if content.length <= 0
    @error = 'Type post text'
    return erb :new
 end
erb "You taped #{content}"
end

