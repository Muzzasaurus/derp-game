#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
respawn_delay = 100;
tag=0;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible = true;
#define Collision_Player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if visible {
    with(Player) {
        air_jumps += 1;
        air_jumps = min(air_jumps, max_air_jumps);
    }

    visible = false;
    alarm[0] = respawn_delay;
    with(tag) {
        visible = false;
        alarm[0] = respawn_delay;
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field tag: instance
