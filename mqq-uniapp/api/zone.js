import request from "../utils/request.js";

const md5 = require('blueimp-md5')

// 发表动态
export function addZone(data) {

	return request({
		url: '/zone/addZone',
		method: 'post',
		data
	})
}

// 获取所有动态
export function getAllZones(id) {

	return request({
		url: '/zone/getAllZones',
		method: 'post',
		data: id
	})
}
