// require
// 加载http模块
var http = require('http');

// 创建http服务器
var server = http.createServer(function(request,response){
    response.write('Hello world');
    response.end();
});

// 监听服务器
server.listen(8081,'127.0.0.1');

console.log('监听8081');