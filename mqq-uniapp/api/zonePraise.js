import request from "../utils/request.js";

// 动态点赞
export function praiseZone(data) {

	return request({
		url: '/zonePraise/praiseZone',
		method: 'post',
		data
	})
}

// 获得所有点赞用户信息
export function getAllPraise(id) {

	return request({
		url: '/zonePraise/getAllPraise',
		method: 'post',
		data:id
	})
}

// 取消点赞
export function cancelPraiseZone(data) {

	return request({
		url: '/zonePraise/cancelPraiseZone',
		method: 'post',
		data
	})
}
