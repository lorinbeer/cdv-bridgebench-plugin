


var XHRBench = {
    deltas : [],
    
    run : function() {
        for (var i = 0; i < 10; i = i+1) {
            var t = new Date().getTime();
            var request = XHRBench.initXHR("http://cordova.plugin.file?starttime="+t+"&target=targettarget");
            request.send();
        }
        var total = 0;
        for (each in XHRBench.deltas) {
            total = total+XHRBench.deltas[each];
            
        }
        console.log(XHRBench.deltas);
        console.log(total/XHRBench.deltas.length);
        XHRBench.deltas = [];
    },
 
    initXHR : function(url) {
        var request = new XMLHttpRequest();
        request.open("GET", url, false);
        request.onreadystatechange = function() {
            if (request.readyState==4) {
                console.log(request);
                var t = new Date().getTime();
                var resp = JSON.parse(request.responseText);
                XHRBench.deltas.push(t - resp.starttime);
                console.log(t-resp.starttime);
            }
            
        };
        return request;
    }
}
