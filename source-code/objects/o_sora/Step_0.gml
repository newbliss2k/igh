if getkey("escape") {
	game_end()
}

if getkey("restart") {
	x=mouse_x
	y=mouse_y
}

xorigin=sprite_get_xoffset(sprite_index)
yorigin=sprite_get_yoffset(sprite_index)
sprite_set_bbox(sprite_index,xorigin-sprite_bbox_width/2,yorigin-sprite_bbox_height,xorigin+sprite_bbox_width/2-1,yorigin-1)

// x movement

