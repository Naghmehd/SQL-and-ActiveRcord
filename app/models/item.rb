class Item < ActiveRecord::Base
  has_one :address
  belongs_to :order
end
