<template>
	<view class="container">

		<view class="head-container">
			<view class="" @click="closed">
				取消
			</view>
			<view class="">
				写说说
			</view>
			<view class="" @click="postZone()">
				发表
			</view>
		</view>
		<view class="content-container">
			<textarea v-model="content"
				style="	margin-bottom:15rpx;caret-color: #4772ff; white-space: pre-wrap;width: 100%;min-height:200rpx;max-height: 290rpx;overflow: scroll;"
				:adjust-position="false" :cursor-spacing="8" class="" placeholder="分享新鲜事..." auto-height></textarea>
			<view class="picture-container">
				<view class="img-container" v-for="(item,index) in imgBg" @tap="previewImage(index)"
					:class="'img'+(index%3==2?'1':'0')">
					<view class="" v-if="item.type=='image'">
						<image :mode="item.size" :src="item.url">
						</image>
					</view>
					<view class="" v-else>
						<image :src="item.url" :controls="false"></image>
					</view>
				</view>
				<view class="upload-picture" @click="chooseVideoImage()">
					<view class="">
						照片/视频
					</view>
				</view>
			</view>
		</view>

		<view class="preview" v-show="previewShow" @touchstart="onTouchStart" @touchmove="onTouchMove"
			@touchend="onTouchEnd">
			<view class="head-container1">
				<view class="" @click="changePreview()">
					返回
				</view>
				<view class="" @click="deleteImg()">
					删除
				</view>
			</view>
			<view class="preview-container">
				<view class="" v-if="preview.type=='image'">
					<image mode="widthFix"
						:style="{width: imageSize.width + 'px',transform: 'translate(' + offsetX + 'px, ' + offsetY + 'px)'}"
						:src="preview.url" @click="changeWidth()"></image>
				</view>
				<view class="" v-else v-html="">
					<video :src="preview.url">
					</video>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	// import MyEditorWithFormula from './components/MyEditorWithFormula'
	// import MyEditorWithMention from './components/MyEditorWithMention'
	import {
		uploadZoneFile
	} from '../../api/file.js'
	import {
		addZone
	} from '../../api/zone.js'
	export default {
		components: {

			// MyEditorWithFormula,
			// MyEditorWithMention
		},
		data() {
			return {
				content: '',
				// 背景图展示
				imgBg: [],
				// 背景图预览
				imgBgArray: [],
				// 背景图路径
				imgBgArr: '',
				// 上传的背景临时路径
				imgBgUrl: '',
				// 上传的背景图绝对路径
				imgBgArrUrl: '',
				preview: '',
				previewShow: false,
				previewVideo: '',
				imageSize: {
					width: 750,
					height: 0,
				},
				primarySize: {
					width: 750,
					height: 0,
				},
				startX: 0,
				startY: 0,
				startDistance: 0,
				scaling: false,
				initWidth: false,
				startX1: 0,
				startY1: 0,
				offsetX: 0,
				offsetY: 0,
				dragging: false,
				lastOffsetX: 0,
				lastOffsetY: 0,
				previewIndex: 0,
				scale: 0,
				publiserContent: {},
				publiserImg: [],
				loading: true,
				isPublisher: true
			}
		},
		onBackPress(options) {
			// 触发返回就会调用此方法，这里实现的是禁用物 理返回，顶部导航栏的自定义返回 uni.navigateBack 仍可使用
			// this.preview = false
			if (this.previewShow == true) {
				this.previewShow = false
				this.initPreview()
				return true;
			}


		},
		onLoad() {
			console.log(uni.getStorageSync('screenHeight'), uni.getStorageSync('screenWidth'));
			this.primarySize.width = uni.getStorageSync('screenWidth')
			this.primarySize.height = uni.getStorageSync('screenHeight') - this.primarySize.width / 5
			this.imageSize.width = this.primarySize.width
			this.imageSize.height = this.primarySize.height
		},
		methods: {
			postZone() {
				console.log(this.content, this.publiserContent);
				console.log(JSON.stringify(this.publiserContent) != '{}');
				if (this.content != '' || JSON.stringify(this.publiserContent) != '{}') {
					uni.showLoading({
						title: '正在发布...'
					});
					if (this.isPublisher) {
						this.isPublisher = false
						if (this.imgBg.length == 0) {
							this.publiserContent.publisherId = uni.getStorageSync('user').id
							this.publiserContent.content = this.content
							addZone(this.publiserContent).then(res => {
								console.log(res);
								this.loading = false
								uni.hideLoading();
								uni.navigateTo({
									url: '/pages/home/home?index=2'
								})
							}).catch(err => {
								console.log(err);
							})
						} else {
							this.imgBg.filter((item, index) => {

								if (item.type == "image") {
									console.log(item.url);
									uni.uploadFile({
										url: this.baseUrl + '/uploadImage', // Spring Boot 服务器地址
										filePath: item.url,
										name: 'file',
										success: (uploadFileRes) => {
											this.publisherZone(uploadFileRes, item, index)
										},
										fail: (err) => {
											console.error('上传失败', err);
										},
									});
								} else {
									uni.uploadFile({
										url: this.baseUrl + '/uploadVideo',
										filePath: item.url,

										name: file,
										success: (res) => {
											this.publisherZone(res, item, index)
										},
										fail: (err) => {
											console.error('上传失败', err);
										},
									});
								}

							})

						}

					}
					// this.publiserZone()
				}


			},
			chooseImg() {
				var that = this
				const isIosTrue = uni.getStorageSync('IOS_FIRST_CAMERA')
				if (this.phoneType === 'ios' && isIosTrue !== 'false') {
					// 设为false就代表不是第一次开启相机
					uni.setStorageSync('IOS_FIRST_CAMERA', 'false')
				}
				uni.chooseImage({
					sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
					sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
					// 选择图片的数量
					// count: 1,
					success: res => {
						console.log(res);
						const tempFilePaths = res.tempFilePaths;
						console.log(tempFilePaths[0]);
						uni.uploadFile({
							url: that.baseUrl + '/uploadImage', // Spring Boot 服务器地址
							filePath: tempFilePaths[0],
							name: 'file',
							success: (uploadFileRes) => {
								console.log(uploadFileRes.data);
							}
						});
						res.tempFilePaths.filter(item => {
							uni.getImageInfo({
								src: item,
								success: function(infoRes) {
									const formData = new FormData();
									formData.append('file', item);
									console.log(formData);
									// uni.uploadFile({
									// 	url: that.baseUrl + '/uploadImage',
									// 	formData: {
									// 		file: formData
									// 	},
									// 	name: 'file',
									// 	success: (res) => {
									// 		console.log(res);
									// 	},
									// 	fail: (err) => {
									// 		console.error('上传失败', err);
									// 	},
									// });

									var obj = {}
									obj.url = item
									obj.type = 'image'
									obj.size = infoRes.width > infoRes.height ?
										'heightFix' : 'widthFix'
									obj.width = that.primarySize.width
									obj.height = infoRes.height * (that.primarySize.width /
										infoRes.width)
									console.log(res);
									// console.log(res.tempFilePaths[0])
									that.imgBg.push(obj)
									that.imgBgArray = res.tempFilePaths
									console.log(that.imgBgArray);
									that.app_img(0, res)
									// 图片信息
									console.log('图片宽度：', infoRes.width);
									console.log('图片高度：', infoRes.height);
								}
							});

						})

					},

				})

			},
			publisherZone(res, item, index) {
				var obj = {}
				obj.url = res.data
				obj.type = item.type
				obj.size = item.size
				obj.width = item.width
				obj.height = item.height
				console.log(this.publiserImg);
				this.publiserImg.push(obj)
				if (index == this.imgBg.length - 1) {
					console.log(uni.getStorageSync('user'));
					this.publiserContent.publisherId = uni.getStorageSync('user').id
					this.publiserContent.content = this.content
					this.publiserContent.pictures = JSON.stringify(this.publiserImg)
					console.log(this.publiserContent);
					console.log(this.imgBg);
					addZone(this.publiserContent).then(res => {
						console.log(res);
						this.loading = false
						uni.hideLoading();
						uni.navigateTo({
							url: '/pages/home/home?index=2'
						})
					}).catch(err => {
						console.log(err);
					})

				}
			},
			changeWidth() {
				if (this.initWidth) {
					this.imageSize.width = this.primarySize.width
					this.imageSize.height = this.primarySize.height
					this.initPreview()
				}
				this.initWidth = true
				setTimeout(() => {
					this.initWidth = false
				}, 300)
			},
			changePreview() {
				this.previewShow = false
				this.initPreview()
				console.log(123);
			},
			closed() {
				uni.navigateTo({
					url: '/pages/home/home'
				})
			},
			previewImage: function(e) {
				this.previewShow = true
				console.log(1111, this.imgBg[e]);
				this.preview = this.imgBg[e]
				this.previewIndex = e
				console.log(this.previewIndex);
				// uni.previewImage({
				// 	current: e,
				// 	urls: this.imgBgArray, // 需要预览的图片链接列表
				// 	success: function(res) {
				// 		console.log(res);
				// 		console.log('预览图片成功');
				// 	},
				// 	fail: function(err) {
				// 		console.error('预览图片失败', err);
				// 	}
				// })
			},
			// 选择背景图片
			chooseVideoImage() {
				uni.showActionSheet({
					title: "选择上传类型",
					itemList: ['图片', '视频'],
					success: (res) => {
						console.log(res)
						if (res.tapIndex == 0) {
							this.chooseImg()
						} else {
							this.chooseVideo()
						}
					}
				})
			},
			initPreview() {
				this.startX = 0
				this.startY = 0
				this.startX1 = 0
				this.startY1 = 0
				this.offsetX = 0
				this.offsetY = 0
				this.lastOffsetX = 0
				this.lastOffsetY = 0
				this.scale = 0
				var obj = {}
				obj.width = this.primarySize.width
				obj.height = this.primarySize.height
				this.imageSize = obj

			},
			chooseVideo() {
				uni.chooseVideo({
					sourceType: ['album', 'camera'],
					compressed: true,
					success: (res) => {
						console.log(res);
						this.video1 = res.tempFilePath;
						const videoPath = res.tempFilePath;
						console.log(videoPath);
						var obj = {}
						obj.url = videoPath
						obj.type = 'video'
						obj.size = '1'
						this.imgBg.push(obj)
						// 在这里可以处理选择视频的逻辑
						// this.uploadVideo(videoPath);
					},
				});
			},
			onTouchStart(event) {

				this.startX1 = event.touches[0].clientX;
				this.startY1 = event.touches[0].clientY;
				this.dragging = true;

				if (event.touches.length >= 2) {
					const x1 = event.touches[0].clientX;
					const y1 = event.touches[0].clientY;
					const x2 = event.touches[1].clientX;
					const y2 = event.touches[1].clientY;
					const deltaX = x1 - x2;
					const deltaY = y1 - y2;
					const distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
					this.startX = (x1 + x2) / 2;
					this.startY = (y1 + y2) / 2;
					this.startDistance = distance;
					this.scaling = true;
				}
			},
			onTouchMove(event) {

				if (this.dragging) {
					const moveX = event.touches[0].clientX;
					const moveY = event.touches[0].clientY;
					const deltaX = moveX - this.startX1;
					const deltaY = moveY - this.startY1;
					this.offsetX += deltaX;
					this.offsetY += deltaY;
					this.startX1 = moveX;
					this.startY1 = moveY;
				}

				if (this.scaling && event.touches.length >= 2) {
					const x1 = event.touches[0].clientX;
					const y1 = event.touches[0].clientY;
					const x2 = event.touches[1].clientX;
					const y2 = event.touches[1].clientY;
					const deltaX = x1 - x2;
					const deltaY = y1 - y2;
					const distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
					const scale = distance / this.startDistance;
					// this.scale = scale
					this.imageSize.width *= scale;
					this.imageSize.height *= scale;

					this.startDistance = distance;
					// this.offsetX = 0
					// this.offsetY = 0
					// this.lastOffsetX = 0
					// this.lastOffsetY = 0
				}
			},
			onTouchEnd() {
				if (this.imgBg[this.previewIndex].width <= this.imageSize.width) {
					if (this.offsetX * 2 >= (this.imageSize.width - this.imgBg[this.previewIndex].width)) {
						this.offsetX = (this.imageSize.width - this.imgBg[this.previewIndex].width) / 2
					} else if (this
						.offsetX * -2 >= (this.imageSize.width - this.imgBg[this.previewIndex].width)) {
						this.offsetX = -(this.imageSize.width - this.imgBg[this.previewIndex].width) / 2
					}
				} else {
					this.offsetX = this.lastOffsetX
				}
				// if (this.imageSize.width == this.primarySize.width) {
				// 	this.initPreview()
				// }
				var imgheight = this.imgBg[this.previewIndex].height * (this.imageSize.width / this.primarySize.width)
				console.log(imgheight, this.primarySize.height);
				if (imgheight >= this.primarySize.height) {

					if (this.offsetY * 2 >= (imgheight - this.primarySize.height)) {
						this.offsetY = ((imgheight - this.primarySize.height) >= 0 ? (imgheight - this.primarySize
							.height) : 0) / 2
					} else if (this.offsetY * -2 >= (imgheight - this.primarySize.height)) {
						this.offsetY = -((imgheight - this.primarySize.height) >= 0 ? (imgheight - this.primarySize
							.height) : 0) / 2
					}

				} else {
					this.offsetY = this.lastOffsetY
				}

				this.lastOffsetY = this.offsetY
				this.lastOffsetX = this.offsetX
				// this.offsetX = 

				this.imageSize.width = this.imageSize.width <= this.primarySize.width * 1 ? this.primarySize.width *
					1 : this.imageSize.width
				this.imageSize.width = this.imageSize.width >= this.primarySize.width * 3.5 ? this.primarySize.width *
					3.5 : this.imageSize.width
				this.scaling = false;
				this.dragging = false;
			},

			// 图片压缩
			//（这里实际上一开始是要求选择多张图片的，所以将res作为一个数组进行的处理，
			// 后期需求变更,写的比较急，就没改，直接给num传了一个0，默认从数组第一个开始，
			// 然后通过判断数组的length来直接return掉。）
			app_img(num, res) {
				let that = this
				if (Number(num) === Number(res.tempFiles.length)) {
					return
				}
				let index = res.tempFiles[num].path.lastIndexOf(".")
				let img_type = res.tempFiles[num].path.substring(index, res.tempFiles[num].path.length)
				let img_yuanshi = res.tempFiles[num].path.substring(0, index)
				let d2 = new Date().getTime()
				plus.zip.compressImage({
					src: res.tempFiles[num].path,
					dst: img_yuanshi + d2 + img_type,
					quality: 10
				}, function(e) {
					that.imgBgArr = e.target
					that.postImg(that.imgBgArr)
					that.app_img(num + 1, res)
				})
			},
			// 删除图片
			deleteImg() {
				this.imgBg.splice(this.previewIndex, 1);
				this.previewShow = false
			},
			// 点击图片
			bindImg() {
				if (this.imgBgArrUrl.length !== 0) {
					// console.log(index)
					uni.previewImage({
						urls: this.imgBgArrUrl,
						current: 0
					})
				}
			},
			// 上传图片
			postImg(imgFilePaths) {
				uni.uploadFile({
					url: baseUrl.apiUrl + '/xxx/xxx',
					filePath: imgFilePaths,
					name: 'file',
					success: (uploadFileRes) => {
						let imgValue = JSON.parse(uploadFileRes.data)
						this.imgBgArrUrl = imgValue.data.absoluteUrl
						this.imgBgUrl = imgValue.data.url
					}
				});
			}

		}
	}
</script>

<style scoped>
	.preview-container image,
	.preview-container video {
		width: 750rpx;
		z-index: 1 !important;
		opacity: 0.9;
		height: calc(100vh - 150rpx);
	}

	.preview-container video {
		height: calc(100vh - 150rpx);
	}

	.preview-container {
		width: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		height: calc(100vh - 150rpx);
		overflow: hidden;
		position: absolute;
		top: 150rpx;
		z-index: 1;


	}

	.preview {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: black;
		z-index: 0;
	}

	.img-container view,
	.img-container video {

		width: 220rpx;
		height: 220rpx;
		background-repeat: no-repeat;
		overflow: hidden;
		display: flex;
		justify-content: center;
		align-items: center;
		position: relative;
		z-index: 0;

	}



	.img-container {
		width: 220rpx;
		height: 220rpx;
		margin-right: 11rpx;
		margin-top: 11rpx;
	}

	.img-container image {
		position: absolute;
		height: 100%;
		width: 100%;

		/*使用绝对定位来防止高度挤压别的盒子*/

	}

	image:nth-child(1) {
		height: 220rpx;
	}

	.img1 {
		margin-right: 0;
	}

	.picture-container {
		display: flex;
		flex-wrap: wrap;
	}

	.upload-picture {
		margin-top: 11rpx;
		width: 220rpx;
		height: 220rpx;
		background: #F8F9F9;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		color: #6a6b6b;
		font-size: 30rpx;
	}

	.content-container {
		width: 100%;
		min-height: 500rpx;
		background: white;
		padding: 30rpx;
		box-sizing: border-box;
		margin-top: 30rpx;
	}

	.head-container,
	.head-container1 {
		background: white;
		width: 100%;
		height: 150rpx;
		padding: 15rpx 30rpx;
		padding-top: 50rpx;
		box-sizing: border-box;
		display: flex;
		justify-content: space-between;
		align-items: center;
		position: sticky;
		font-size: 36rpx;
		top: 0;
	}

	.head-container1 {
		background-color: #F8F9F9;
		color: black;
		z-index: 1111;
	}

	.box-card {
		width: 800px;
	}

	h1 {
		font-size: 200rpx;
	}

	.container,
	.container1 {
		width: 100%;
		background: #F8F9F9;
		height: 100vh;
	}
</style>
