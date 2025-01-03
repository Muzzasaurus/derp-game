///player_release_jump()
if !place_meeting(x,y,ZeroGravField) {
    if global.grav * vspeed < 0 {
        vspeed *= jump_release_multiplier;
    }
}
