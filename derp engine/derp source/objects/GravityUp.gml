#define Collision_Player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with Player {
    if global.grav==1 {
        player_flip(-1)
        sound_play("sndFlip")
    }
}
