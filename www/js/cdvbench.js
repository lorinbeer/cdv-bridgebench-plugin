


var CDVBench = {
    run : function() {
        console.log("Cordova Bridge BenchTest initializing");
        window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, CDVBench.gotFS, CDVBench.fail);
    },
    
    gotFS : function(cdvfs) {
        console.log("Cordova Bridge BenchTest running");
        cdvfs.root.getFile("Resources/random.task", null, CDVBench.gotFE, CDVBench.fail);
    },

    gotFE : function(file) {
        console.log("got fe");
        var filereader = new FileReader();
        filereader.onloadend = function (e) {
            console.log("read success");
            console.log(new Uint8Array(evt.target.result));
        }
        reader.readAsArrayBuffer(file);
    },

    fail : function(e) {
        console.log("FAIL");
        console.log("Failed with Error Code", e.target.error.code);
    }
}