jQuery(function($){
   $(".tweet").tweet({
      username: "smidig",
      join_text: "auto",
      avatar_size: 0,
      count: 3,
      auto_join_text_default: "we said,",
      auto_join_text_ed: "we",
      auto_join_text_ing: "we were",
      auto_join_text_reply: "we replied to",
      auto_join_text_url: "we were checking out",
      loading_text: "loading tweets...",
      template: "{text}"
   });
}); 