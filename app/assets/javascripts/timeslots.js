$(function() {
  jQuery.event.props.push( "dataTransfer" );

  var onDragEnter = function(event) {
      event.preventDefault();
      $(this).addClass("dragover");
  }, 
  onDragOver = function(event) {
      event.preventDefault(); 
      $(this).addClass("dragover");
  }, 
  onDragLeave = function(event) {
      event.preventDefault();
      $(this).removeClass("dragover");
  },

  onDrop = function(event) {
      event.preventDefault();
      var container = $(this);
      container.removeClass("dragover");

      var talkId = event.dataTransfer.getData("talk");
      var node = $("[data-talk-id='"+talkId+"']");
      var roomslotId = $(this).data("roomslot-id");

      var deferred = $.ajax({
        url: "/roomslots/add_talk",
        type: "GET",
        data: {talk_id: talkId, roomslot_id: roomslotId}
      });

      deferred.success(function() {
        container.append(node);
      });
  },

  onDragStart = function(event) {
    //event.preventDefault();
    event.dataTransfer.effectAllowed="move";
    event.dataTransfer.setData("talk", $(this).data("talk-id"));
    console.debug($(this).data("talk-id"))
  },

  removeTalk = function(event) {
    event.preventDefault();
    var node = $(this).parent();
    var talk_id = node.data("talk-id");

    var deferred = $.ajax({
        url: "/roomslots/remove_talk",
        type: "GET",
        data: {talk_id: talk_id}
    });

    deferred.success(function() {
      $(".available-talks").append(node);  
    });
  };


  $(".talks .dropzone")
    .on("dragenter", onDragEnter)
    .on("dragover", onDragOver)
    .on("dragleave", onDragLeave)
    .on("drop", onDrop);

  $(".talk").on("dragstart", onDragStart);

  $(".talk .remove").click(removeTalk)
});
