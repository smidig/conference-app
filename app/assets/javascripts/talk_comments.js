$(function() {

  var url = "/talk_comments.json";

  function addCommentRow(data, container) {
    container.find("input[name='content']").val("");
    var li = $("<li>").html("<span class='time'>Akkuratt nå, </span> <span class='username'>sier du:</span><br /><span class='content'>"+data.content+"</span>");

    li.appendTo(container.find("ul"));
  }

  $(".talk_comments form").submit(function(event) {
    event.preventDefault();
    var container = $(this).parent();
    var data = {
      talk_comment: {
        content: $(this).find("input[name='content']").val(),
        user_id: $(this).find("input[name='user_id']").val(),
        talk_id: $(this).find("input[name='talk_id']").val(),
      }
    };
    
    if(!data.talk_comment.content || data.talk_comment.content === "") {
        alert("Du må skrive en kommentar!");
        return;
    }

    $.post(url, data,"json").success(function(data) {
      addCommentRow(data, container);
    });
  });
});