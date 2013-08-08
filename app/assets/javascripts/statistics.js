$(function () {
    $.get("/administration/statistics.json").success(function(data) {
        console.debug(data);
        hei = data; 
        $('#antallPrJobbrolle').highcharts({   
            chart: {
                type: 'column'
            },
            title: {
                text: 'Antall påmeldt pr jobbrolle'
            },
            xAxis: {
                categories: Object.keys(data),
                title: {
                    text: 'Jobbrolle'
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Antall påmeldte'
                }
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                data: findValues(data)
            }]
        });      
    });

    function findValues(data){
        var verdier = [];
        for (var rolle in data) {
          verdier.push(data[rolle]);
        }
        
        return verdier;
    }
});