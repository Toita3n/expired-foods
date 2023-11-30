document.addEventListener('DOMContentLoaded', function() {
    var templateButton = document.getElementById('use_template_button');
    var templateSelect = document.getElementById('item_template');
    var titleField = document.getElementById('item_title');
    var countField = document.getElementById('item_count');
    var detailField = document.getElementById('item_detail');
  
    templateButton.addEventListener('click', function() {
      var selectedTemplate = templateSelect.value;
  
      // テンプレートに応じてフォームの値を設定
      if (selectedTemplate === '牛肉') {
        titleField.value = '牛肉';
        countField.value = 1;
        detailField.value = '100g';
      } else if (selectedTemplate === '豚肉') {
        titleField.value = '豚肉';
        countField.value = 1;
        detailField.value = '100g';
      } else if (selectedTemplate === '鶏肉') {
        titleField.value = '鶏肉';
        countField.value = 1;
        detailField.value = '100g';
      } else if (selectedTemplate === '刺身') {
        titleField.value = 'マグロ';
        countField.value = 1;
        detailField.value = '100g';
      } else if (selectedTemplate === '鮭') {
        titleField.value = '鮭';
        countField.value = 1;
        detailField.value = '100g';
      } else if (selectedTemplate === 'ぶり') {
        titleField.value = 'ぶり';
        countField.value = 1;
        detailField.value = '100g';
      } else if (selectedTemplate === '鰆') {
        titleField.value = '鰆';
        countField.value = 1;
        detailField.value = '100g';
      }
    });
});