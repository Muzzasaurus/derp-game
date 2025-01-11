#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspdo = 0
yo = 0
ihaveadegree=0
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
    if (y > 304 and vspeed > 0 and global.grav != -1) {
        global.grav = -1
        other.ihaveadegree = (y - other.yo)/(1.30 - (abs(y - other.yo)/1216))
        if(other.ihaveadegree>0){
            vspeed = 0
            while(other.ihaveadegree > 0) {
                vspeed += 0.4
                other.ihaveadegree -= vspeed
            }
        }
        gravity = global.grav * grav;

        player_set_mask();
        y += 4 * global.grav;
    }
    else if (y < 304 and vspeed < 0 and global.grav != 1) {
        global.grav = 1
        other.ihaveadegree = (y - other.yo)/(1.30 - (abs(y - other.yo)/1216))
        if(other.ihaveadegree<0){
            vspeed = 0
            while(other.ihaveadegree < 0) {
                vspeed -= 0.4
                other.ihaveadegree -= vspeed
            }
        }
        gravity = global.grav * grav;

        player_set_mask();
        y += 4 * global.grav;
    }
    other.vspdo = vspeed
}
