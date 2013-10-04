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
      $(this).removeClass("dragover");

      var talkId = event.dataTransfer.getData("talk");
      var node = $(".available-talks [data-talk-id='"+talkId+"']");
      $(this).append(node);

      var roomslotId = $(this).data("roomslot-id");

      $.ajax({
        url: "/roomslots/add_talk",
        type: "GET",
        data: {talk_id: talkId, roomslot_id: roomslotId}
      });
      
  },

  onDragStart = function(event) {
    //event.preventDefault();
    event.dataTransfer.effectAllowed="move";
    event.dataTransfer.setData("talk", $(this).data("talk-id"));
  };


  $(".talks .dropzone")
    .on("dragenter", onDragEnter)
    .on("dragover", onDragOver)
    .on("dragleave", onDragLeave)
    .on("drop", onDrop);

  $(".available-talks .talk")
    .on("dragstart", onDragStart);


});