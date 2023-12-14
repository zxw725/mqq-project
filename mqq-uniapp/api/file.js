import request from "../utils/request.js";

// 上传文件
export function uploadZoneFile(data) {
	return request({
		url: '/upload/files',
		method: 'post',
		data
	})
}

// 上传动态照片
export function uploadImage(data) {
	return request({
		url: '/uploadImage',
		method: 'post',
		data
	})
}

// 上传动态视频
export function uploadVideo(data) {
	return request({
		url: '/uploadVideo',
		method: 'post',
		data
	})
}

