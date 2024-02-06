class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  # def index
  #   @items = Item.all
  # end

  def new
    @item = Item.new
  end

  def create
    
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_duration_id, :price)
  end
end