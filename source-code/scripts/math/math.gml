function ease_in(_t){
	return 1-cos(_t * pi / 2)
}

function ease_out(_t){
	return sin(t * pi / 2)
}