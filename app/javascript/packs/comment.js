$(document).ready(function () {
  // ここを.on('submit')にするとなぜか反応しない
  $('#comment_submit').on('click', function(e){
    e.preventDefault()
    const formElement = $('#comment_form')[0]

    const formData = new FormData(formElement);
    const url = $(formElement).attr('action');

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment){
      const htmlElement = `
        <div>
          ${comment.user_name}
          ${comment.date}
          ${comment.comment}
          <a rel="nofollow" data-method="delete" href="/books/${comment.book_id}/book_comments/${comment.id}">削除</a>
        </div>
      `
      $('.comments').append(htmlElement)
      $('#comment_form')[0].reset()
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    })
  })
})