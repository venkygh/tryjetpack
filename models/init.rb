require 'data_mapper'
require 'rufus/scheduler'

DataMapper.setup(:default, 'sqlite::memory:')

class Post
  include DataMapper::Resource

  property :id,         Serial    # An auto-increment integer key
  property :title,      String    # A varchar type string, for short strings
  property :body,       Text      # A text block, for longer string data.
  property :created_at, DateTime  # A DateTime, for any date you might like.
end

DataMapper.finalize

DataMapper.auto_upgrade!

# Load init DB data if empty
scheduler = Rufus::Scheduler.start_new
scheduler.in '5s' do
  load_defaults
end

def load_defaults
  if Post.count == 0
    puts "Loading init data"
  end
end
