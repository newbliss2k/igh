function scr_shake(_amnt,_timer){
	
	var _deathstruct={}
	_deathstruct.timer=_amnt
	_deathstruct.amnt=_timer
	instance_create_layer(x,y,layer,o_shake,_deathstruct)
	
}