document.addEventListener('turbolinks:load', function() {
  let templateButton = document.getElementById('use_template_button');
  let templateSelect = document.getElementById('item_template');
  let titleField = document.getElementById('item_title');
  let countField = document.getElementById('item_count');
  let detailField = document.getElementById('item_detail');

  // テンプレート情報のマップ
  const templates = {
    '牛肉': { title: '牛肉', count: 1, detail: '100g' },
    '刺身': { title: 'マグロ', count: 1, detail: '100g' },
    '鮭': { title: '鮭', count: 1, detail: '100g' },
    '卵': { title: '卵', count: 10, detail: '1パック' }
  };

  if (templateButton) {
    templateButton.addEventListener('click', function(event) {
      event.preventDefault(); // デフォルトのアクションを防ぐ

      let selectedTemplate = templateSelect.value;

      // テンプレートが存在する場合にフォームの値を設定
      if (templates[selectedTemplate]) {
        let templateInfo = templates[selectedTemplate];
        titleField.value = templateInfo.title;
        countField.value = templateInfo.count;
        detailField.value = templateInfo.detail;
      }
    });
  }
});