#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0]=20
pos=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(instance_exists(Player)) {
    if(abs(Player.x - x) < 800) {
        xpos = 0
        repeat(6) {
            if(scr_mirror_avd_check()) {
                o=instance_create_moving(x+(xpos*32),0,Cherry,5,270)
                o.sprite_index=sprMirrorCherry2
                p=instance_create_moving(x+(xpos*32),608,Cherry,5,90)
                p.sprite_index=sprMirrorCherry2
                p.image_yscale=-1
            }
            xpos += 1
        }


    }
    alarm[0]=20
    pos = (pos + 1) mod 3
}
