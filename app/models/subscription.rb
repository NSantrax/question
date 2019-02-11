class Subscription < ApplicationRecord
  belongs_to :post, class_name: 'Quest', foreign_key: :post_id
  belongs_to :user#:subscriber, class_name: 'User', foreign_key: "user_id"
end
