class TopsController < ApplicationController
  def index
    @items = Item.order(created_at: :desc).limit(20)
  end

  def overview
  end
end
