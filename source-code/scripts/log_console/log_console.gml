//display_set_gui_size(1280,720)
global.console={}
with global.console {
	timeout=4
	log=[
		["Welcome to IGH!",timeout,c_white,c_white,c_white,c_white,0,display_get_gui_height()],
	]
}

//	0:STRING
//	1:ALPHA
//	2:COLOR1
//	3:COLOR2
//	4:COLOR3
//	5:COLOR4
//	6:X
//	7:Y

function log_console(){
	for (var _i=0; _i<array_length(global.console.log); _i+=1) {
		draw_text_color(global.console.log[_i][6], global.console.log[_i][7], global.console.log[_i][0], global.console.log[_i][2], global.console.log[_i][3], global.console.log[_i][4], global.console.log[_i][5], global.console.log[_i][1]*0.5)
		global.console.log[_i][1]-=0.01
		global.console.log[_i][7]=lerp(global.console.log[_i][7],display_get_gui_height()-20-_i*20,0.5)
	}
}

function log_push(_string,_c1=c_white,_c2=c_white,_c3=c_white,_c4=c_white){
	
	//array_push(global.console.log,)
	array_insert(global.console.log,0,[_string,global.console.timeout,_c1,_c2,_c3,_c4,0,display_get_gui_height()])
}