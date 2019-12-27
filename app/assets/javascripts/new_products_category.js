$(function(){
  var buildPrompt = `<option value>---</option>`
  var buildHtmlOption = function(cat) {
      var option = `<option value ="${cat.id}">${cat.name}</option>`
      return option
  }
  
  $('#parent').change(function() {
    var parent_id = $(this).val();
    $.ajax({
        type: 'GET',
        url: '/api/products/child',
        data: {id: parent_id},
        dataType: 'json'
    })
    .done(function(categories) {
        $('.child').css('display', 'block');
        $('#child').empty();
        $('.grand_child').css('display', 'none');
        $('#child').append(buildPrompt);
        categories.forEach(function(cat) {
          var html_option = buildHtmlOption(cat);
          $('#child').append(html_option);
        });
    })
    .fail(function() {
    });
  });

  $(this).on("change", "#child", function() {
    var child_id = $("#child").val();
    $.ajax({
        type: 'GET',
        url: '/api/products/grand_child',
        data: {id: child_id},
        dataType: 'json'
    })
    .done(function(categories) {
        $('.grand_child').css('display', 'block');
        $('#grand_child').empty();
        $('#grand_child').append(buildPrompt);
        categories.forEach(function(cat) {
            var html_option = buildHtmlOption(cat);
            $('#grand_child').append(html_option);
        });
    })
    .fail(function() {
    });
  });
})