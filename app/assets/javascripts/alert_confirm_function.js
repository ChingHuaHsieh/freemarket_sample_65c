$(function (){

  //  when_product_destroy //
  
  $("#destroy_btn").on("click", function() {
    if( window.confirm('本当にこの商品を削除しますか？')) {
      return true;
    }
    else {
      return false;
    }
  });

  //  when_logout  //

  $("#logout-btn").on("click", function() {
    alert("ログアウトしました。");
  });

  //  when_purchase  //

  $("#buy_btn").on("click", function() {
    if( window.confirm('本当にこの商品を購入しますか？')) {
      return true;
    }
    else {
      return false;
    }
  });

  //  when_click_soldout_btn  //

  $("#soldout_btn").on("click", function() {
    alert("すでに売り切れました。");
  });
});