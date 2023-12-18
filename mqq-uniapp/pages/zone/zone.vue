<template>
	<view class="container">

		<view class="" style="width: 100%;height: 100vh;overflow: hidden;">
			<view class="head-container">
				<view class="iconfont icon-fanhui fanhui" @click="backZone()">

				</view>
				<view class="head-title">
					好友动态
				</view>
				<view class="iconfont icon-tianjiahaoyou tianjiahaoyou" @click="editZone()">

				</view>
			</view>

			<scroll-view class="zone-container" show-scrollbar="false" :scroll-y="!showZoneInput">
				<view class="zone-container-item" v-for="(item,index) in zones">
					<view class="zone-top-container">
						<image class="zone-picture" :src="baseUrl+item.url" mode=""></image>
						<view class="zone-name-time">
							<view class="zone-name">
								{{item.username}}
							</view>
							<view class="zone-time">
								{{filterTime(item.time)}}
							</view>
						</view>
					</view>
					<view class="zone-content">
						<view class="">
							{{item.zone.content}}
						</view>
					</view>
					<view class="zone-container-picture">
						<view class="img-container" v-for="(item1,index1) in item.zone.pictures"
							:class="'img'+(item.zone.pictures.length!=1?0:1)">

							<view v-if="item1.type=='image'" @click="previewImage(index,index1)">
								<image :src="item1.url" :mode="item.zone.pictures.length==1?'widthFix':item1.size"
									class=""></image>
							</view>
						</view>
					</view>
					<view class="praise-comment">
						<view class="iconfont icon-a-dianzan1" @click="userPraiseZone(item.zone.id,index)"
							:class="'dianzan'+zonePraise[index].isPraise">

						</view>
						<view class="iconfont icon-a-pinglun2">

						</view>
						<view class="iconfont icon-fenxiang">

						</view>
					</view>
					<view class="praise-user-container">
						<view v-show="zonePraise[index].length!=0" class="iconfont icon-a-dianzan1 dianzan">
						</view>
						<view v-show="zonePraise[index].length!=0" class="praise-user"
							v-for="(item1,index1) in zonePraise[index]">
							{{index1!=0?'、':''}}{{item1.username}}
						</view>
					</view>
					<view class="comment-container">
						<view class="comment-container-item"
							@click="replyComment(item2.observeName,item.zone.id,index,item2.zoneComment.observerId)"
							v-for="(item2,index2) in zoneComment[index]">
							<view class="" style="font-weight: 550;">
								{{item2.observeName}}
							</view>
							<view class="" style="margin: 0 8rpx;" v-show="item2.replierName!=''">
								回复
							</view>
							<view class="" style="font-weight: 550;" v-show="item2.replierName!=''">
								{{item2.replierName}}
							</view>
							<view class="" style="font-weight: 550;margin-right: 8rpx;">
								:
							</view>
							<view class="">
								{{item2.zoneComment.content}}
							</view>
						</view>
					</view>

					<view class="comment-user-container">
						<image :src="headPicture" class="comment-head-picture" mode=""></image>
						<input @click="showCommentZone(item.zone.id,index)" type="text" class="comment-input"
							placeholder="说点什么吧...">
					</view>

				</view>
			</scroll-view>

			<view class="preview" v-show="previewShow" @click="tapPreview()" @touchstart="onTouchStart"
				@touchmove="onTouchMove" @touchend="onTouchEnd">
				<view class="preview-container">
					<view class="" v-if="preview.type=='image'">
						<image mode="widthFix" :src="preview.url" @click="changeWidth()"></image>
					</view>
					<view class="" v-else v-html="">
						<video :src="preview.url">
						</video>
					</view>
				</view>
			</view>
		</view>
		<view class="background" v-if="showZoneInput" @click="blurZoneInput()">

		</view>
		<view class="bottom-container">
			<view class="bottom-container" style="padding: 15rpx 20rpx;background: white;" v-if="showZoneInput">
				<textarea v-if="showZoneInput" :focus="showZoneInput" :blur="showZoneInput" @focus="showZoneInput=true"
					v-model="commentText" :adjust-position="false" :cursor-spacing="8" class="zone-comment"
					:placeholder="commentPlaceholder" auto-height ref="input"></textarea>
				<button v-if="showZoneInput" :class="commentText!=''?'chat-submit-ing':'chat-submit'"
					@click="sendComment()">发送</button>
			</view>
		</view>
	</view>
</template>

<script>
	import {
		selectUser,
		selectAllFriends
	} from "../../api/user.js"
	import {
		getAllZones
	} from '../../api/zone.js'

	import {
		praiseZone,
		getAllPraise,
		cancelPraiseZone
	} from '../../api/zonePraise.js'
	import {
		commentZone,
		getAllComment
	} from '../../api/zoneComment.js'
	export default {
		data() {
			return {
				isTap: true,
				commentText: '',
				showZoneInput: false,
				headPicture: '',
				zones: [],
				username: '',
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
				isPublisher: true,
				zonePraise: [],
				zoneComment: [],
				isPraising: 1,
				user: [],
				isBlur: true,
				commentPlaceholder: '说点什么吧...',
				replyUsername: '',
				zoneId: '',
				zoneIndex: 0,
				replyId: 0
			}
		},
		methods: {
			replyComment(replyUsername, zoneId, zoneIndex, replyId) {
				console.log(replyId);
				this.showZoneInput = true
				this.replyUsername = replyUsername
				this.replyId = replyId
				this.commentPlaceholder = "回复" + this.replyUsername + ":"
				this.zoneId = zoneId
				this.zoneIndex = zoneIndex
			},
			sendComment() {
				if (this.commentText != '') {
					this.showZoneInput = false
					var obj = {}
					console.log(this.commentText);
					var zoneComment = {}
					obj.observeName = this.user.username
					obj.replierName = this.replyUsername
					if (this.replyUsername != '') {
						zoneComment = {
							zoneId: this.zoneId,
							observerId: this.username,
							replierId: this.replyId,
							content: this.commentText
						}
						obj.zoneComment = zoneComment
					} else {
						zoneComment = {
							zoneId: this.zoneId,
							observerId: this.username,
							content: this.commentText
						}
						obj.zoneComment = zoneComment
					}
					console.log(obj);
					this.zoneComment[this.zoneIndex].push(obj)
					if (this.replyUsername != '') {
						commentZone(zoneComment).then(res => {
							console.log(res);
							this.commentText = ''
						})
					} else {
						commentZone(zoneComment).then(res => {
							console.log(res);
							this.commentText = ''
						})
					}


				}
				
			},
			blurZoneInput() {
				this.replyUsername = ""
				this.commentText = ''
				if (this.isBlur) {
					setTimeout(() => {
						this.showZoneInput = false
					}, 0)
				} else {
					this.commentPlaceholder = '说点什么吧...'
					this.showZoneInput = true
				}

			},
			backZone() {
				uni.navigateTo({
					url: '/pages/home/home?index=2'
				})
			},
			showCommentZone(zoneId,zoneIndex) {
				this.showZoneInput = true
				this.replyUsername = ""
				this.commentPlaceholder = '说点什么吧...'
				this.zoneId = zoneId
				this.zoneIndex = zoneIndex
				this.isBlur = false
				setTimeout(() => {
					this.isBlur = true
				})

			},
			userPraiseZone(id, index, index1) {
				if (this.isPraising) {
					this.isPraising = 0
					if (this.zonePraise[index].isPraise) {
						this.zonePraise[index].isPraise = 0
						this.zonePraise[index] = this.zonePraise[index].filter(item =>
							item.id + '' != this.username
						)
						this.$forceUpdate()
						cancelPraiseZone({
							zoneId: id,
							praiserId: this.username
						}).then(res => {
							console.log(this.zonePraise[index]);

							this.$forceUpdate()
							this.isPraising = 1
							console.log(res);
						})
					} else {
						this.zonePraise[index].isPraise = 1
						console.log(this.zonePraise[index].isPraise);
						var obj = {}
						obj.username = this.user.username
						obj.id = this.user.id
						obj.url = this.user.url
						this.zonePraise[index].push(obj)
						this.$forceUpdate()
						praiseZone({
							zoneId: id,
							praiserId: this.username
						}).then(res => {
							this.isPraising = 1
							console.log(this.user.name);


						})
					}
					// = this.zonePraise[index].isPraise == 1 ? 0 : 1

				}


			},
			tapPreview() {
				this.previewShow = false
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
			previewImage: function(index, index1) {
				if (!this.showZoneInput) {
					this.previewShow = true
					// console.log(1111, this.imgBg[e]);
					this.preview = this.zones[index].zone.pictures[index1]
					this.previewIndex = index1
				}


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
					this.imageSize.width *= scale;
					this.imageSize.height *= scale;
					this.startDistance = distance;
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
			pictureLength(item) {
				return item.length
			},
			filterTime(time) {
				var time1 = time.replace("T", " ")
				return time1
			},
			init() {
				this.blurZoneInput()
				this.user = uni.getStorageSync('user');
				this.username = uni.getStorageSync('uid');
				if (uni.getStorageSync("zones")) {
					this.zones = uni.getStorageSync("zones")
					this.$forceUpdate()
				}
				uni.getSystemInfo({
					success: function(res) {
						const screenHeight = res.screenHeight
					}
				});

				getAllZones(this.username).then(res => {
					var zones = res.data.data
					if (uni.getStorageSync("zones")) {
						this.zones = uni.getStorageSync("zones")
						console.log(this.zones);
					}
					var isAddZone = this.zones == '' ? true : false
					// this.zones = res.data.data
					zones.sort((b, a) => new Date(a.time) - new Date(b.time));
					this.$forceUpdate()
					console.log(this.zones, zones);
					zones.filter((item, index) => {
						getAllPraise(item.zone.id + '').then(res => {
							var obj = res.data.data
							obj.isPraise = res.data.data.some(obj1 => obj1.id == this.username) ?
								1 :
								0
							this.zonePraise.push(res.data.data)
							this.$forceUpdate()
							// console.log(obj,res.data.data.some(obj => obj.id == this.username));
						})
						getAllComment(item.zone.id + '').then(res => {
							console.log(res.data.data);
							this.zoneComment.push(res.data.data)
							this.$forceUpdate()
						})
						this.zones.filter((item, index) => {
							// console.log(!(zones.some(obj => obj.zone.id == item.zone.id)));
							if (!(zones.some(obj => obj.zone.id == item.zone.id))) {
								this.zones.splice(index, 1);
							}
							uni.setStorageSync("zones",
								this.zones)
							this.$forceUpdate()
						})

						if (isAddZone || item.zone.id > this.zones[0].zone.id) {
							if (!(this.zones.some(obj => obj.zone.id == item.zone.id))) {
								if (isAddZone) {
									this.zones = [...this.zones, item]
									uni.setStorageSync("zones",
										this.zones)
									this.$forceUpdate()
								} else {
									this.zones = [item, ...this.zones]
									uni.setStorageSync("zones",
										this.zones)

									this.$forceUpdate()
								}

								if (item.zone.pictures != null) {
									item.zone.pictures = JSON.parse(item.zone.pictures)
									item.zone.pictures.filter((item1, index1) => {
										uni.downloadFile({
											url: this.baseUrl + item1.url, // 服务器图片地址
											success: (res) => {
												if (res.statusCode === 200) {
													console.log('下载成功', res
														.tempFilePath);
													item1.url = res.tempFilePath
													if (index1 == item.zone.pictures
														.length - 1) {

														uni.setStorageSync("zones",
															this.zones)

														this.$forceUpdate()
													}

													// this.zones.filter(
													// item2 => {
													// 	if (item2.zone.id ==
													// 		item.zone.id) {
													// 		this.zones.push(item1)

													// 	}

													// })
													console.log(this.zones);

													// if()
													// console.log(this.zones);

													// 下载成功后将图片保存到相册
													//      uni.saveImageToPhotosAlbum({
													//          filePath: res.tempFilePath,
													//          success: function () {
													//              uni.showToast({
													//                  title: '图片保存成功'
													//              });
													//          },
													//          fail: function (err) {
													//              console.log('图片保存失败', err);
													//              // 处理没有权限的情况
													//              uni.showModal({
													//                  content: '检测到没有权限，需要你确认授权',
													//                  confirmText: '去设置',
													//                  success: modalRes => {
													//                      if (modalRes.confirm) {
													//                          // 打开设置页面让用户自行开启
													//                          uni.openSetting();
													//                      }
													//                  }
													//              });
													//          }
													//      });
												}
											},
											fail: (err) => {
												console.log('下载失败', err);
												uni.showToast({
													title: '下载失败',
													icon: 'none'
												});
											}
										});
									})

								}

							}

						}
					})

					this.$forceUpdate()
				})

				this.screenHeight = uni.getStorageSync('screenHeight')
				selectUser(this.username).then(res => {
					this.user = res.data.data
					console.log(res.data.data);
					// console.log(this.baseUrl);
					this.headPicture = `${this.baseUrl+this.user.url}`
					// console.log(this.headPicture);
				}).catch(err => {
					console.log(err);
				})
			},
			editZone() {
				uni.navigateTo({
					url: '/pages/editZone/editZone'
				})
			}
		},
		mounted() {
			this.init()
		}
	}
</script>

<style scoped>
	.comment-container-item {
		display: flex;
		margin-bottom: 10rpx;
	}

	.comment-container {
		margin-top: 20rpx;
	}

	.background {
		background: #019AFE00;
		width: 100%;
		height: 100vh;
		z-index: 11;
		position: absolute;
		top: 0;
		left: 0;

	}

	.chat-submit-ing,
	.chat-submit {
		width: 140rpx;
		height: 70rpx;
		display: flex;
		justify-content: center;
		align-items: center;
		background: #019AFE55;
		margin-left: 20rpx;
		color: white;
		font-size: 30rpx;
	}

	.chat-submit-ing {
		background: #019AFE;
	}

	.fanhui {
		font-size: 55rpx;
	}

	.zone-comment {
		white-space: pre-wrap;
		width: 100%;
		max-height: 290rpx;
		overflow: scroll;
		background: #F5F5F5;
		padding: 15rpx;
		box-sizing: border-box;
	}

	.chat-input {
		background: white;
		/* height: 80rpx; */
		max-height: 320rpx;
		display: flex;
		padding: 15rpx 20rpx;
		box-sizing: border-box;
		font-size: 35rpx;
		caret-color: #4772ff;
		align-items: flex-start;
		white-space: pre-wrap;
		width: 100%;
		border-radius: 10rpx;
	}

	.bottom-container {

		caret-color: #4772ff;
		box-sizing: border-box;
		/* max-height:400rpx; */
		display: flex;
		position: fixed;
		bottom: 0;
		width: 100%;
		/* padding: 18rpx 30rpx; */
		box-sizing: border-box;
		background: white;
		align-items: flex-end;
		overflow: hidden;
		background: #F5F5F5;
		z-index: 1111;

	}

	.comment-input {
		z-index: 11;
		width: 630rpx;
		height: 70rpx;
		background: #F5F5F5;
		padding: 15rpx;
		font-size: 30rpx;
		margin-left: 20rpx;
		box-sizing: border-box;
	}

	.comment-user-container {
		display: flex;
		margin-top: 20rpx;
		align-items: center;
	}

	.comment-head-picture {
		border-radius: 50%;
		width: 60rpx;
		height: 60rpx;
	}

	.praise-user-container {
		display: flex;
		flex-wrap: wrap;
	}

	.praise-user-container {
		font-size: 35rpx;
	}

	.dianzan {
		font-size: 42rpx;
		line-height: 45rpx;
		margin-right: 20rpx;
	}

	.dianzan1 {
		color: #12B7F5 !important;
	}

	.praise-comment .iconfont {
		font-size: 50rpx;
		margin-left: 40rpx;
	}

	.praise-comment {
		display: flex;
		justify-content: end;
		margin: 20rpx 0;
	}

	.preview-container image,
	.preview-container video {
		width: 750rpx;
		z-index: 1 !important;
		opacity: 0.9;
		height: 100vh;
		z-index: 111;
	}

	.preview-container video {
		height: 100vh;
	}

	.preview-container {
		width: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100%;
		overflow: hidden;
		position: absolute;
		z-index: 1;
	}

	.preview {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: black;
		z-index: 111;
	}

	.img-container view {
		width: 100%;
		height: 100%;
		background-repeat: no-repeat;
		/* overflow: hidden; */
		display: flex;
		justify-content: center;
		align-items: center;
		position: relative;
	}

	.img-container image,
	.img-container video {
		position: absolute;
		height: 100%;
		width: 100%;
	}

	.img0 {
		width: 220rpx;
		height: 220rpx;
		margin-right: 11rpx;
		margin-top: 11rpx;
		overflow: hidden;

	}

	.img1 {
		margin-right: 11rpx;
		margin-top: 11rpx;
		width: 100%;
		height: 450rpx;
		/* overflow: hidden; */

	}

	/* 	image:nth-child(1) {
		height: 220rpx;
	}
 */
	.zone-container-picture {
		display: flex;
		flex-wrap: wrap;
	}

	.zone-content {
		margin-top: 25rpx;
	}

	.zone-time {
		font-size: 30rpx;
		color: #818282;
	}

	.zone-name-time {
		display: flex;
		flex-direction: column;
		justify-content: space-between;
	}

	.zone-container-item {
		background-color: white;
		padding: 30rpx;
		box-sizing: border-box;
		margin-top: 20rpx;

	}

	.zone-picture {
		width: 90rpx;
		height: 90rpx;
		border-radius: 50%;
		margin-right: 20rpx;
	}

	.zone-top-container {
		display: flex;

	}

	.zone-container {
		width: 100%;
		height: 100%;
		padding-top: 130rpx;
		box-sizing: border-box;
	}

	/* 	.zone-container-box {
		padding-bottom: 120rpx;
		box-sizing: border-box;
		background: #F8F9F9;
	}
 */
	.box-card {
		width: 800px;

	}

	.head-container {
		background: linear-gradient(to right, #90d7f8, #8b91f8);
		width: 100%;
		height: 150rpx;
		padding: 15rpx 30rpx;
		padding-top: 50rpx;
		box-sizing: border-box;
		display: flex;
		justify-content: space-between;
		align-items: center;
		position: fixed !important;
		top: 0;
		color: white;
	}

	.head-container {
		background: linear-gradient(to right, #90d7f8, #8b91f8);
		width: 100%;
		height: 150rpx;
		padding: 15rpx 30rpx;
		padding-top: 50rpx;
		box-sizing: border-box;
		display: flex;
		justify-content: space-between;
		align-items: center;
		position: sticky;
		top: 0;
		z-index: 111;
	}

	.head-title {
		color: white;
		font-size: 36rpx;
		font-weight: 540;
	}

	.tianjiahaoyou {
		font-size: 60rpx;
		color: white;
	}

	.container,
	.container1 {
		width: 100%;
		background: #F8F9F9;
		height: 100vh;
	}

	.head-picture {
		height: 80rpx;
		width: 80rpx;
		border-radius: 50%;
	}
</style>
