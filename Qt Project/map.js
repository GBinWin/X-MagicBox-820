
 function map_chart(){
	 
	//初始位置
	var pointx, pointy;		
	var point = [];
    var isPoint = true;   
	var bPoints = new Array();
	
	var map = new BMapGL.Map("map");		
	//这里的webChannel是全局的变量，可以在其它位置访问
	var webChannel = new QWebChannel(qt.webChannelTransport,    
	function(channel){
	var webobj = channel.objects.webobj;
  
		webobj.contentChanged.connect(updateattribute);
	});
  
	var updateattribute=function(text)
	{  
		var str = [];
		str = text.split(',');
		pointx = str[0].slice(1);
		pointy = str[1].slice(1);
		
		if(isPoint){
			isPoint = false;
			//初始位置
			var pinit = new BMapGL.Point(pointx, pointy); 
			map.centerAndZoom(pinit, 15); 
		}else{
			
		}		
		
		var data = [];
		data[0] = pointx;
		data[1] = pointy;
		point.push(data);
		
		var rPoint = new BMapGL.Point(point[point.length-1][0],point[point.length-1][1]);
		bPoints.push(rPoint);
		//更新标记点
		marker = new BMapGL.Marker(rPoint); // 创建点 
		map.addOverlay(marker);
		
		//更新连线
		if(point.length > 1){
			var polyline = new BMapGL.Polyline([ 
				new BMapGL.Point(point[point.length-2][0],point[point.length-2][1]),
				new BMapGL.Point(point[point.length-1][0],point[point.length-1][1]),
			], {strokeColor:"red", strokeWeight:5, strokeOpacity:0.5});   //创建折线 
			map.addOverlay(polyline);
		}	

		setZoom(bPoints);		
	
	}
	
	
	// 根据点的数组自动调整缩放级别
    function setZoom(bPoints) {
        var view = map.getViewport(eval(bPoints));
        var mapZoom = view.zoom;
        var centerPoint = view.center;
        map.centerAndZoom(centerPoint, mapZoom);
    }
    map.addControl(new BMapGL.MapTypeControl());
    map.enableScrollWheelZoom(true);
  
	
	// setInterval(function () {
		// setZoom(bPoints);
		
	// }, 1000);
	
	//console.log(data);
	
	//console.log(point);
	
	
// setInterval(function () {

	// var data = [];
	// data[0] = pointx;
	// data[1] = pointy;
	
	// pointy = pointy + 0.01;
	//console.log(data);
	// point.push(data);
	//console.log(point);
	// marker = new BMapGL.Marker(new BMapGL.Point(point[point.length-1][0],point[point.length-1][1])); // 创建点 
	// map.addOverlay(marker);

	// if(point.length > 1){
		// var polyline = new BMapGL.Polyline([ 
			// new BMapGL.Point(point[point.length-2][0],point[point.length-2][1]),
			// new BMapGL.Point(point[point.length-1][0],point[point.length-1][1]),
		// ], {strokeColor:"red", strokeWeight:5, strokeOpacity:0.5});   //创建折线 
		// map.addOverlay(polyline);
	// }		

// }, 1000);

	 // //清除覆盖物 
	// function remove_overlay(){ 
		// map.clearOverlays();       
	 // } 
 }