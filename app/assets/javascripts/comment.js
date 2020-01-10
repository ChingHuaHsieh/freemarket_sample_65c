$(function(){
  function buildHTML(comment) {
    var html = `<div class="product-message-comment">
                  <div class="message-items">
                    <div class="message-user">
                      <img alt="user-icon" class="user-icon" src="/assets/mypage/user-icon-ee8a60f6d86acc2daeba551c586f90ff762bcc95ce5064fe61be2f5dac92882a.png" width="30" height="30">
                      <div class="message-user-name">
                        <p>
                          ${comment.user_nickname}
                        </p>
                      </div>
                    </div>
                    <div class="message-body">
                        ${comment.text}
                      <div class="message-icons">
                        <div class="message-icon-left">
                          <svg class="svg-inline--fa fa-history fa-w-16" aria-hidden="true" data-prefix="fa" data-icon="history" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
                            <path fill="currentColor" d="M504 255.531c.253 136.64-111.18 248.372-247.82 248.468-59.015.042-113.223-20.53-155.822-54.911-11.077-8.94-11.905-25.541-1.839-35.607l11.267-11.267c8.609-8.609 22.353-9.551 31.891-1.984C173.062 425.135 212.781 440 256 440c101.705 0 184-82.311 184-184 0-101.705-82.311-184-184-184-48.814 0-93.149 18.969-126.068 49.932l50.754 50.754c10.08 10.08 2.941 27.314-11.313 27.314H24c-8.837 0-16-7.163-16-16V38.627c0-14.254 17.234-21.393 27.314-11.314l49.372 49.372C129.209 34.136 189.552 8 256 8c136.81 0 247.747 110.78 248 247.531zm-180.912 78.784l9.823-12.63c8.138-10.463 6.253-25.542-4.21-33.679L288 256.349V152c0-13.255-10.745-24-24-24h-16c-13.255 0-24 10.745-24 24v135.651l65.409 50.874c10.463 8.137 25.541 6.253 33.679-4.21z">
                            </path>
                          </svg>
                          <!-- <i class="fa fa-history"> </i> -->
                          <span>
                            ${comment.date}
                          </span>
                        </div>
                        <div class="message-icon-right">
                          <div class="message-delete">
                            <a rel="nofollow" data-method="PATCH" href="/products/${comment.product_id}/comments/${comment.id}">
                              <svg class="svg-inline--fa fa-trash fa-w-14" aria-hidden="true" data-prefix="fa" data-icon="trash" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
                              <path fill="currentColor" d="M0 84V56c0-13.3 10.7-24 24-24h112l9.4-18.7c4-8.2 12.3-13.3 21.4-13.3h114.3c9.1 0 17.4 5.1 21.5 13.3L312 32h112c13.3 0 24 10.7 24 24v28c0 6.6-5.4 12-12 12H12C5.4 96 0 90.6 0 84zm415.2 56.7L394.8 467c-1.6 25.3-22.6 45-47.9 45H101.1c-25.3 0-46.3-19.7-47.9-45L32.8 140.7c-.4-6.9 5.1-12.7 12-12.7h358.5c6.8 0 12.3 5.8 11.9 12.7z">
                              </path>
                            </svg>
                            <!-- <i class="fa fa-trash"></i> -->
                            </a>
                          </div>
                        </div>
                      </div>
                      <i class="icon-ballon"></i>
                    </div>
                  </div>
                </div>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment){
      var html = buildHTML(comment);
      $('.comment').append(html);
      $('#new_comment')[0].reset();
    })
    .fail(function() {
      alert('error');
    })
    .always(function() {
      $('.comment-button').prop('disabled', false);
    })
  })
  
});