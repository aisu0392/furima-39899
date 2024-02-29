class PurchasesController < ApplicationController
  
  def index
    @purchases_form = PurchaseForm.new 
    @item = Item.find(params[:item_id])
  end

  def new
    @purchases_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.save
      # 成功時の処理
      redirect_to root_path
    else
      # 失敗時の処理
      render :index, status: :unprocessable_entity  
    end
  end

  private

  def purchase_params
    # パラメータを適切に設定
    params.require(:purchase_form).permit(:item_id, :user_id)
  end

  def shipping_address_params
    params.require(:purchase_form).require(:shipping_address_attributes).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number)
  end
end
