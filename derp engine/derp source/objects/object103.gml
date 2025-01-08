#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspdo = 0
yo = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with(Player) {
    if(other.vspdo <= 0 and vspeed > 0) or (other.vspdo >= 0 and vspeed < 0) {
        other.yo = y
    }
    if (y > 304 and vspeed > 0 and vflip != -1) {
        vflip = -1
        if (abs(y - other.yo) > 128) vspeed = (y - other.yo) / 20
        else vspeed -= 2
    }
    else if (y <= 304 and vspeed < 0 and vflip != 1) {
        vflip = 1
        if (abs(y - other.yo) > 128) vspeed = (y - other.yo) / 20
        else vspeed += 2
    }
    other.vspdo = vspeed
}
