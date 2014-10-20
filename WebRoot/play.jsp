<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<script type="text/javascript" src="http://www.ckplayer.com/js/js6.4.js"></script>
<script type="text/javascript" src="http://www.ckplayer.com/js/zDrag.js"></script>
<script type="text/javascript" src="http://www.ckplayer.com/js/zDialog.js"></script>
<script type="text/javascript" src="ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">
	var wid=parseInt('130');
	var status=0;
</script>
<link href="file/css/css6.4.css" rel="stylesheet" type="text/css">
<link href="file/css/example.css" rel="stylesheet" type="text/css">

<body>
  <div class="top_right">
   <!--  <form name="form1" method="get" action="search6.php">
<div class="ssearch">
            <div class="sleft">
            	<input name="w" type="text" id="w" maxlength="50" value="点击输入关键字" onFocus="clw()">
            </div>
            <div class="sright">
				<input name="sub" type="image" src="images/search.jpg" width="28" height="33" border="0">
            </div>
      </div>
    </form> -->
  </div>
<div class="cler"></div></div><div style="font-size: 20px;line-height: 50px;width: 1080px;margin-right: auto;margin-left: auto;text-align: center;">演示：弹幕插件-默认调用之前所有的发布内容均匀显示-同时支持实时弹幕</div><div class="ex">
  <div class="left">
    <div id="a1"></div>
  <div class="clear"></div></div>
<div class="clear"></div></div>
<script type="text/javascript">
	function loadedHandler(){
		if(!CKobject.getObjectById('ckplayer_a1').getType()){//说明使用flash
			//getbarrage();
			CKobject.getObjectById('ckplayer_a1').addListener('myObjectChange','myObjectChange'); 
		}
	}
	var flashvars={
		f:'/files/video/20-2.flv',
		c:0,
		e:1,
		p:2,
		 i:'/files/image/pic6.4.jpg', 
		barrage:'http://www.ckplayer.com/dm6.4.2.php',//这是保存好的弹幕的内容
		o:138,
		loaded:'loadedHandler'//监听播放器加载成功
		};
	var video=['http://localhost/video/video/VIDEO0005_new0.mp4->video/mp4'];
	CKobject.embed('ckplayer/ckplayer.swf','a1','ckplayer_a1','650','410',false,flashvars,video);
	//以下是弹幕用到的代码
	function barrage(str){//当用户在文本框里输入文字时这个函数将接收到。并且保存到数据库里，并实时显示在播放器里
		alert("调用barrage --str="+str)
		if(!str){
			alert('请输入内容后发布');
		}
		if(myid<1){
			alert('您没有登陆，无法发布');
			return;
		}
		CKobject.ajax('post','utf-8','/addAssess.action?con='+str,function(s){
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
		/* CKobject.ajax('get','utf-8','/addAssess.action?tz='+parseInt(nowTime/1000),function(s){ */
		CKobject.ajax('get','utf-8','http://www.ckplayer.com/dm6.4.php?tz='+parseInt(nowTime/1000),function(s){
			
			if(s){
				//alert(s);
				var arr=s.split('++||++');
				for(var i=0;i<arr.length;i++){
					if(arr[i]!=''){
						CKobject.getObjectById('ckplayer_a1').loadBarrage(arr[i]);
					}
				}
			}
		});
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