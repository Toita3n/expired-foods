$(function(){
  // モーダルが表示される前に呼ばれるイベント
  $('.item-modal-trigger').on('show.bs.modal', function (event) {
    // クリックされたアイテムの詳細を取得するための処理を追加する
    var itemId = $(event.relatedTarget).data('item-id');
    // 例: 詳細情報をAjaxで取得し、モーダルの内容を更新する
    // $.ajax({
    //   url: '/items/' + itemId,
    //   method: 'GET',
    //   success: function(data){
    //     $('.modal-body').html(data);
    //   }
    // });
  });
});