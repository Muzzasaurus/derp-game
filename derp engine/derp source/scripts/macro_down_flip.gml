///macro_down_flip()
//macro for the down key taking into account if the player is flipped

if (global.grav < 0) return input_check(key_up)
return input_check(key_down)
