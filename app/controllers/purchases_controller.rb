class PurchasesController < ApplicationController
  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.save
      # 成功時の処理
    else
      # 失敗時の処理
    end
  end

  private

  def purchase_params
    # パラメータを適切に設定
  end
end
