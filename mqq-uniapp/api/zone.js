import request from "../utils/request.js";

const md5 = require('blueimp-md5')

// 发送消息
export function addZone(data) {

	return request({
		url: '/zone/addZone',
		method: 'post',
		data
	})
}

// 获取聊天信息
export function getAllZones(id) {

	return request({
		url: '/zone/getAllZones',
		method: 'post',
		data: id
	})
}
