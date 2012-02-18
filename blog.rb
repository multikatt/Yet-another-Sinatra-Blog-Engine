DataMapper::setup(:default, "sqlite://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :text, Text
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Admin
  include DataMapper::Resource
  property :id, Serial
  property :user, String
  property :pass, String
  property :token, String
end

DataMapper.auto_upgrade!

enable :sessions

helpers do
  def admin? ; Admin.all(:user => request.cookies["user"]).any? and
               Admin.all(:token => request.cookies["token"]).any? ; end
  def protected! ; halt [ 401, 'Not authorized' ] unless admin? ; end
end

get '/' do
  @title = "Kattfest blog"
  @posts = Post.all
  haml :home
end

get '/admin' do
  @title = "Admin"
  haml :admin
end

get '/logout' do
  response.delete_cookie("user")
  response.delete_cookie("token")
  redirect '/'
end

get '/newpost' do
  protected!
  @title = "New post"
  haml :newpost
end

post '/login' do
  a = Admin.all
  a.each do |admins|
    if admins.user == params['username'] && admins.pass == params['password']
      response.set_cookie("user", admins.user)
      response.set_cookie("token", admins.token)
      flash[:notice] = "Signed in successfully"
      redirect '/'
    else
      flash[:notice] = "Failed to sign in"
      redirect '/'
    end
  end
end
