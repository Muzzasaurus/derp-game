#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(instance_exists(Player)) {
    if(abs(Player.x - x) < 800) {
        o=instance_create_moving(x + random_range(-272,272),0,Cherry,3,270)
        o.sprite_index=sprCherryWhite
        o.image_blend=make_color_hsv_standard(random(360),40,100)
        p=instance_create_moving(o.x,608,Cherry,3,90)
        p.sprite_index=sprCherryWhite
        p.image_blend=o.image_blend
        p.image_yscale=-1

    }
}
