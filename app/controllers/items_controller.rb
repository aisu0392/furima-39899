class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @items = Item.new
  end

  def create
    @items = Item.new(item_params)

    if @items.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_duration_id, :price)
  end
end