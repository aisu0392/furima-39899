class PurchasesController < ApplicationController
  
  def index
    @purchases_form = PurchaseForm.new # ログイン中のユーザーに関連する購入履歴を取得
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.save
      # 成功時の処理
      flash[:success] = '購入が完了しました。'
      redirect_to root_path
    else
      # 失敗時の処理
      flash[:error] = '購入に失敗しました。入力内容を確認してください。'
      render :new  
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
