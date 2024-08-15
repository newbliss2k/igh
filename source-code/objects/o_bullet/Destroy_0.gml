for(var _i=0;_i<5;_i++){
	var _particle = instance_create_depth(x,y,depth,o_bullet_particle)
	_particle.direction = random_range(0,360)
	_particle.speed = random_range(0,_particle.spd)
}