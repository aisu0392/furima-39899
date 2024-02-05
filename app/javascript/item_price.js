document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profitPrice = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    if (!inputValue || isNaN(inputValue)) {
      addTaxPrice.innerHTML = "NaN";
      profitPrice.innerHTML = "NaN";
      return;
    }

    // 販売手数料と販売利益の計算
    const price = parseFloat(inputValue);
    const fee = price * 0.1;  // 10%の手数料として計算（適宜変更してください）
    const profit = price - fee;

    // 結果を表示
    addTaxPrice.innerHTML = `${fee.toFixed(2)}円`;
    profitPrice.innerHTML = `${profit.toFixed(2)}円`;

  });
});