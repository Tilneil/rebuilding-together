class Owner < ApplicationRecord
  belongs_to :user
  has_many   :repairs
end