import request from "../utils/request.js";

// 获得所有评论
export function getAllComment(id) {

	return request({
		url: '/zoneComment/getAllComment',
		method: 'post',
		data:id
	})
}

// 用户评论
export function commentZone(data) {

	return request({
		url: '/zoneComment/commentZone',
		method: 'post',
		data
	})
}
