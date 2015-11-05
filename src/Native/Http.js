var sanitize = function sanitize(record) {
    var spaces = Array.prototype.slice.call(arguments, 1);
    return spaces.reduce(function (r, space) {
        return (function () {
            r[space] ? void 0 : r[space] = {};
            return r[space];
        })();
    }, record);
};

var wrap_with_type = function(item){
    return {
        ctor: item
    };
};

var createServer = function createServer(http, Tuple2, Task) {
    return function (address) {
        return function () {
            var send = address._0;
            var server = http.createServer(function (request, response) {
                request.method = wrap_with_type(request.method);

                return Task.perform(send(Tuple2(request, response)));
            });
            return Task.asyncFunction(function (callback) {
                return callback(Task.succeed(server));
            });
        }.call(this);
    };
};
var listen = function listen(Task) {
    return function (port, echo, server) {
        return Task.asyncFunction(function (callback) {
            return server.listen(port, function () {
                console.log(echo);
                return (function () {
                    return callback(Task.succeed(server));
                })();
            });
        });
    };
};
var writeHead = function writeHead(Task) {
    return function (code, header, res) {
        return function () {
            var o = {};
            return Task.asyncFunction(function (callback) {
                return (function () {
                    o[header._0] = header._1;
                    res.writeHead(code, o);
                    return callback(Task.succeed(res));
                })();
            });
        }.call(this);
    };
};
var write = function write(Task) {
    return function (message, res) {
        return Task.asyncFunction(function (callback) {
            return (function () {
                res.write(message);
                return callback(Task.succeed(res));
            })();
        });
    };
};
var end = function end(Task, Tuple0) {
    return function (res) {
        return Task.asyncFunction(function (callback) {
            return (function () {
                res.end();
                return callback(Task.succeed(Tuple0));
            })();
        });
    };
};
var on = exports.on = function on(Signal) {
    return function (eventName, x) {
        return x.on(eventName, function (request, response) {
            if (typeof(request) == 'undefined') {
                return Signal.input(eventName, Tuple0);
            }
            return Signal.input(eventName, Tuple(request, response));
        });
    };
};
var make = function make(localRuntime) {
    return function () {
        var httpø1 = require('http');
        var Taskø1 = Elm.Native.Task.make(localRuntime);
        var Utilsø1 = Elm.Native.Utils.make(localRuntime);
        var Signalø1 = Elm.Native.Signal.make(localRuntime);
        var Tuple0ø1 = (Utilsø1 || 0)['Tuple0'];
        var Tuple2ø1 = (Utilsø1 || 0)['Tuple2'];
        var noopø1 = function () {
            return void 0;
        };
        return (function () {
            sanitize(localRuntime, 'Native', 'Http');
            return function () {
                var vø1 = localRuntime.Native.Http.values;
                return vø1 ? vø1 : localRuntime.Native.Http.values = {
                    'createServer': createServer(httpø1, Tuple2ø1, Taskø1),
                    'listen': F3(listen(Taskø1)),
                    'writeHead': F3(writeHead(Taskø1)),
                    'write': F2(write(Taskø1)),
                    'on': F2(on(Signalø1, Tuple0ø1)),
                    'end': end(Taskø1, Tuple0ø1)
                };
            }.call(this);
        })();
    }.call(this);
};
sanitize(Elm, 'Native', 'Http');
Elm.Native.Http.make = make;
typeof(window) == 'undefined' ? window = global : void 0;
