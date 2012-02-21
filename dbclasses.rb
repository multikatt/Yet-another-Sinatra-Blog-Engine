class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :slug, String
  property :text, Text
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Admin
  include DataMapper::Resource
  property :id, Serial
  property :user, String
  property :pass, BCryptHash
  property :token, String
end

DataMapper.auto_upgrade!
