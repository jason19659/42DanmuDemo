<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>演示：弹幕demo</title>
<meta name="copyright" content="ckplayer" />
<link href="css/example.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="ex">
  <div class="left">
    <div id="a1" style="position:absolute;width:200px;height:115px;z-index:100;color:#FFF;"></div>
  <div class="clear"></div></div>
  <div class="lright">
    <div class="ryytf2">
    </div>
<div class="clear"></div>
  </div>
<div class="clear"></div></div>
<script type="text/javascript">status=0;</script>
<script type="text/javascript" src="/video/js/jquery-1.3.2.min.js" charset="utf-8"></script>
<script type="text/javascript" src="ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">
	function loadedHandler(){
		if(!CKobject.getObjectById('ckplayer_a1').getType()){//说明使用flash
			//getbarrage();
			CKobject.getObjectById('ckplayer_a1').addListener('myObjectChange','myObjectChange'); 
		}
	}
	var flashvars={
		f:'http://localhost/video/files/video/20-2.flv',
		c:0,
		e:1,
		p:2,
		i:'image/pic6_4.jpg',
		b:0,
		o:138,
		barrage:'/video/loadBarrages.action',//这是保存好的弹幕的内容
		loaded:'loadedHandler'//监听播放器加载成功
		};
	var video=['http://movie.ks.js.cn/flv/other/1_0.mp4->video/mp4','http://www.ckplayer.com/webm/0.webm->video/webm','http://www.ckplayer.com/webm/0.ogv->video/ogg'];
	CKobject.embed('ckplayer/ckplayer.swf','a1','ckplayer_a1','650','410',false,flashvars,video);
	//以下是弹幕用到的代码
	function barrage(str){//当用户在文本框里输入文字时这个函数将接收到。并且保存到数据库里，并实时显示在播放器里
		if(!str){
			alert('请输入内容后发布');
		}
	//	CKobject.getObjectById('ckplayer_a1').time
	//判断用户是否登录
	//	if(false){
	//		alert('您没有登陆，无法发布');
	//		return;
	//	}
	//	CKobject.ajax('post','utf-8','http://www.ckplayer.com/asw2.php?con='+str,function(s){
		CKobject.ajax('post','utf-8','/video/addAssess.action?con='+str+'&ntime='+CKobject.getObjectById('ckplayer_a1').getStatus().time,function(s){
			if(s=='no'){
				alert('出错，发布不成功');
			}
			else{
				CKobject.getObjectById('ckplayer_a1').loadBarrage('您刚刚发布的：'+str+'，发送成功！');
			}
		});
		
	}
	//以下是定时调用最新的留言显示在播放器里
	var nowTime= new Date().getTime();
	var newSet=null;
	var bShow=false;
	function getbarrage(){
		//CKobject.ajax('POST','utf-8','http://www.ckplayer.com/dm6.4.php',function(s){
		//	alert(CKobject.getObjectById('ckplayer_a1').getStatus().time);
		$.ajax({ url:'/video/getAssess.action?ntime='+CKobject.getObjectById('ckplayer_a1').getStatus().time, success: function(s){
			f(s){
				var arr=s.split('++||++');
				for(var i=0;i<arr.length;i++){
					if(arr[i]!=''){
						CKobject.getObjectById('ckplayer_a1').loadBarrage(arr[i]);
					}
				}
			}
     	 }});

	//	CKobject.ajax('POST','utf-8','/video/getAssess.action?con='+CKobject.getObjectById('ckplayer_a1').getStatus().time,function(s){
	//		if(s){
	//			var arr=s.split('++||++');
	//			for(var i=0;i<arr.length;i++){
	//				if(arr[i]!=''){
	//					CKobject.getObjectById('ckplayer_a1').loadBarrage(arr[i]);
	//				}
	//			}
	//		}
	//	});
		nowTime= new Date().getTime();
		newSet=setTimeout(getbarrage,5000);
	}
	function myObjectChange(obj){
		for(var k in obj){
			if(k=='barrageShow' && obj[k]!=bShow){
				bShow=obj[k];
				if(bShow){
					nowTime= new Date().getTime();
					getbarrage();
				}
				else{
					clearTimeout(newSet);
				}
			}
		}
	}
</script>

</body>
</html>
