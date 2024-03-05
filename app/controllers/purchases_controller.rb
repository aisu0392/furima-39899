class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :find_item, only: [:index, :create]
  
  def index 
    @purchases_form = PurchaseForm.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if current_user == @item.user || (current_user != @item.user && Purchase.exists?(item_id: @item.id))
      redirect_to root_path
    end
  end



  def create
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
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
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

  def find_item
    @item = Item.find(params[:item_id])
  end
  
end
