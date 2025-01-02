///macro_up_flip()
//macro for the up key taking into account if the player is flipped

if (global.grav < 0) return input_check_pressed(key_down)
return input_check_pressed(key_up)
