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
    const fee = Math.floor(price * 0.1);  
    const profit = Math.floor(price - fee);

    // 結果を表示
    addTaxPrice.innerHTML = `${fee}円`;
    profitPrice.innerHTML = `${profit}円`;

  });
});