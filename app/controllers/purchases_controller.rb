class PurchasesController < ApplicationController
  
  def index
    @purchases_form = PurchaseForm.new 
    @item = Item.find(params[:item_id])
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def new
    @purchases_form = PurchaseForm.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchases_form = PurchaseForm.new(purchase_params)
    if @purchases_form.valid?
      pay_item(@purchases_form.token)
      @purchases_form.save
      redirect_to root_path
    else
      # 失敗時の処理
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    # パラメータを適切に設定
    params.require(:purchase_form).permit( :quantity, :buyer_id, :payment_method, :shipping_address_attributes, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end

  def pay_item(token)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    amount = @item.price
    Payjp::Charge.create(
      amount: amount,  # 商品の値段
      card: token,    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
  

  def shipping_address_params
    params.require(:purchase_form).require(:shipping_address_attributes).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number)
  end
end
