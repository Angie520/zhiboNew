// 加载express模块，
var express = require('express');

// 创建server
var server = express();

// 创建房间字典
var rooms = {};

// 开启房间
server.get('/openRoom',function(request,response){

    // 获取房间ID
    var roomID = request.query.roomID;

    // 获取房间名称
    var roomName = request.query.roomName;
    rooms[roomID] = roomName;

    // 获取字典中所有keys
    var keys = Object.keys(rooms);
    var values = keys.map(function(key){
        return rooms[key];
    });

    console.log(values);
    response.send(values);

});

// 删除房间
server.get('/closeRoom',function(request,response){

    // 获取房间ID
    var roomID = request.query.roomID;

    // 删除房间
    delete rooms[roomID];

    // 获取字典中所有keys
    var keys = Object.keys(rooms);
    var values = keys.map(function(key){
        return rooms[key];
    });

    console.log(values);
    response.send(values);

});

// 获取房间列表
server.get('/rooms',function(request,response){

    // 获取字典中所有keys
    var keys = Object.keys(rooms);
    var values = keys.map(function(key){
        return rooms[key];
    });

    console.log(values);

    response.send(values);

});

// 监听端口
server.listen(8081);

console.log('监听8081');