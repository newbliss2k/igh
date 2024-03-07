clones[0]=0

function _create_clone(_target) {
	if instance_exists(_target) {
		instance=instance_create_depth(x,y,depth,o_solidsemi_clone)
		instance.target=_target
		instance.defy=y
		instance.par=self
		array_push(clones,instance)
	}
}
_create_clone(o_chara)