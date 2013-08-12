$(function() {
  function getFilters() {
    var filters = [];
    $(".filter select").each(function() {
      filters.push({
        type: $(this).data("type"), 
        value: $(this).find("option:selected").val()
      });
    });
    return filters;
  }

  function shouldRowBeVisible(row, filters) {
    var visible = true;
    $.each(filters, function(idx, filter) {
      if(filter.value === "") return;
      var cell = row.find("td[data-type='"+filter.type+"']");
      var value = $.trim(cell.text());
      if(value != filter.value) {
        visible = false;
      }
    });
    return visible;
  }

  function applyFilters(rows, filters) {
    rows.each(function() {
      var row = $(this);
      if(shouldRowBeVisible(row, filters)) {
        row.show();
      }
    });
  }

  function updateCount() {
    var count = $(".table tr:visible").length;
    $(".filter .count").text(count);
  }

  $(".filter select").change(function() {
    var filters = getFilters($(this)); 
    var rows = $(".table tr");
    rows.hide();
    applyFilters(rows, filters);   
    updateCount();
  });
});
