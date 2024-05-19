other.image_index=1
scr_shake(1,15)
var _dead
_dead = instance_create_layer(x,y,layer,o_chara_dead)
_dead.force_dir=point_direction(x,y,other.x,other.y)
log_push("Player died!")
instance_destroy(self)