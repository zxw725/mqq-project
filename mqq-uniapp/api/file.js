import request from "../utils/request.js";

export function uploadZoneFile(data) {
	return request({
		url: '/upload/files',
		method: 'post',
		data
	})
}

export function uploadImage(data) {
	return request({
		url: '/uploadImage',
		method: 'post',
		data
	})
}

export function uploadVideo(data) {
	return request({
		url: '/uploadVideo',
		method: 'post',
		data
	})
}

