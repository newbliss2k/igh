image_xscale=par.image_xscale
image_yscale=par.image_yscale
if image_yscale>0 {
	if ((target.y-1)>defy or target.y_speed<0) or (target = o_chara and getkey("down")) y=9999 else y=defy
}
else {
	if ((target.y+1)<defy or target.y_speed>0) or (target = o_chara and getkey("down")) y=9999 else y=defy
}