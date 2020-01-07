  //  top_page_slick  //

$(function() {
  $('.slider').slick({
      prevArrow:'.slick-prev',
      nextArrow:'.slick-next',
      dots: true,
      autoplay: true,
      autoplaySpeed: 2500,
      speed: 800
  });

  $('.slick-dots li').on('mouseover', function() {
    $('.slider').slick('goTo', $(this).index());
  });
});

  //  product_show_slick  //

$(function() {
  $('.slider-for').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplaySpeed: 3500,
    arrows: false,
    fade: true,
    asNavFor: '.slider-nav'
  });
  $('.slider-nav').slick({
    slidesToShow: $('.owl-dot').children('.owl-dot__product').length, //  中身の写真数により変更  //
    slidesToScroll: 1,
    asNavFor: '.slider-for',
    focusOnSelect: true,
  });
});
