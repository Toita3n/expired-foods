document.addEventListener("DOMContentLoaded", function() {
  const selectElement = document.getElementById("item-sort-select");

  // itemのviewファイルにのみ存在する場合に実行
  if (selectElement) {
    selectElement.addEventListener("change", function() {
      const selectedValue = selectElement.value;
      let redirectUrl = "/items"; // ベースのURLを指定

      if (selectedValue === "latest") {
        // 遠い順の場合の処理
        redirectUrl += "?latest_expired=true";
      } else if (selectedValue === "close") {
        // 近い順の場合の処理
        redirectUrl += "?close_expired=true";
      }

      // 画面移行
      if (redirectUrl !== "/items") {
        window.location.href = redirectUrl;
      }
    });
  }
});