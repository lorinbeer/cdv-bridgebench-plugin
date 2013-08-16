
var cdvfs = null;

var CDVBench = {
    run : function() {
        console.log("Cordova Bridge BenchTest initializing");
        window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, gotFS, fail);
        
    },
    
    gotFS : function(fileSystem) {
        fileSystem.root.getFile("random",
                           {create:true, exclusive: false},
                           function (fe) {
                                console.log("got file, let's write");
                                fe.createWriter( function(writer) {
                                                console.log("writing some text");
                                                    writer.write("somesampletextblahblahblah");
                                                    cdvfs.root.getFile("random", null, CDVBench.gotFE, CDVBench.fail); },
                                                    CDVBenchFail);
                           },
                           CDVBenchFail);
    },
    
    initData : function (writer) {
        console.log("writing some text");
        writer.write("some sample text");
        cdvfs.root.getFile("random", null, CDVBench.gotFE, CDVBench.fail);
    },

    gotFE : function(file) {
        console.log("got fe");
        var filereader = new FileReader();
        filereader.onloadend = function (evt) {
            console.log("read success");
            console.log(evt.target);
        }
        filereader.readAsText(file);
    },

    fail : function(e) {
        console.log("FAIL");
        console.log("Failed with Error Code", e.code);
    }
      
}

function fail(e) {
    console.log("FAILED", e);
}

function createWriter(fe) {
    console.log(fe);
    var fileEntry = fe;
    fileEntry.createWriter(writeFile, fail);
}

function gotFileEntry(fe) {
    console.log("READ FILE");
    fe.file(gotFile, fail);
    
}

function gotFile(f) {
    var reader = new FileReader();
    reader.onloadend = function(evt) {
        console.log("Read as data URL");
        console.log(new Uint8Array(evt.target.result));
    };
    reader.readAsArrayBuffer(f);
}

function writeFile(writer) {
    console.log("WRITER FILE");
    writer.onwriteend = function() {
        cdvfs.root.getFile("dummy",null,gotFileEntry, fail);
    };
     writer.write("some sample text");
}

function writeFooFile(fileSystem) {
    cdvfs = fileSystem;
    cdvfs.root.getFile("dummy", {create: true,exclusive: false}, createWriter, fail);
}