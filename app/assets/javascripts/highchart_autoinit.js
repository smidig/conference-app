$(function () {
    $('#container').highcharts({
        data: {
            table: $(".datatable")[0]
        },
        chart: {
            type: 'column'
        },
        title: {
            text: 'Fordeling av stemmer'
        },
        yAxis: {
            allowDecimals: false,
            title: {
                text: 'Antall'
            }
        },
        xAxis: {
            allowDecimals: false,
            title: {
                text: 'Karakter'
            }
        }
    });
});
