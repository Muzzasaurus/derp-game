#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
effect = false
xs = 1
ys = 1
aa = 1
#define Collision_Player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.max_air_jumps != 1 {
    if (other.max_air_jumps<1) {
        sound_play("sndGainStar")
        other.air_jumps = 1
    }
    else {
        sound_play("sndLoseStar")
        if (other.air_jumps > 0) other.air_jumps -= 1
    }
    other.max_air_jumps = 1
    effect = true
    xs = 1
    ys = 1
    aa = 1

    save_set("StarJumps", 1)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,image_index,x,y)
if effect {
    aa -= .04
    xs += .05
    ys += .05
    draw_sprite_ext(sprite_index,image_index,x+16-16*xs,y+16-16*ys,xs,ys,0,c_white,aa)
    if aa <= 0 effect = false
}
