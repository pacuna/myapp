class Article < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
