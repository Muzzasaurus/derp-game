#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
#define Collision_Bullet
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!image_index) {
    image_index=1
    sound_play("sndShootRefresh")
    //with (Player) air_jumps=min(air_jumps,max_air_jumps+1)
}
