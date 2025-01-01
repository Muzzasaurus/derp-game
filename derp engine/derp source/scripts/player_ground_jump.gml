///player_ground_jump()

vspeed = -global.grav * ground_jump_speed;
air_jumps = max_air_jumps;
sound_play("player_ground_jump");

if instance_exists(Player) {

    with(Platform) {
        if(instance_place(x,y,Player) and onetime) {
            sound_play("sndPlatformBreak")
            instance_destroy()
        }
    }
}
