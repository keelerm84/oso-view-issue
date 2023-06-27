class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'Student'
end
