document.addEventListener('DOMContentLoaded', function() {
    document.body.addEventListener('ajax:success', function(event) {
      const detail = event.detail;
      const data = detail[0], status = detail[1], xhr = detail[2];

      if (data.action === 'increment' || data.action === 'decrement') {
        const itemInfo = document.getElementById(`item-count-${data.item_id}`);
        if (itemInfo) {
          itemInfo.innerHTML = data.item.count;
        }
      }
    });
});