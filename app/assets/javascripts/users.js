var smidig = smidig || {};

smidig.tableFilter = (function($) {
  
  function getFilters(selectList) {
    var filters = [];
    selectList.each(function() {
      var option = $(this);
      filters.push({
        type: option.data("type"), 
        value: option.find("option:selected").val()
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

  function updateCount(countNode, table) {
    var count = table.find("tbody tr:visible").length;
    countNode.text(count);
  }

  function register(container, table) {
    var countNode = container.find(".count"),
        selectList = container.find("select"),
        rows = table.find("tbody tr");

    selectList.change(function() {
      var filters = getFilters(selectList); 
      rows.hide();
      applyFilters(rows, filters);   
      updateCount(countNode, table);
    });
  }

  return {
    register: register
  }
}(jQuery));

$(function() {
  smidig.tableFilter.register($(".filter"), $(".table"));
});
