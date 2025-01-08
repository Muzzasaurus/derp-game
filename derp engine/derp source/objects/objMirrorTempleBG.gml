#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(instance_exists(Player)){
    x = min(room_width-800,max(0,global.camera_x - (173*((global.camera_x+400)/room_width))))
}
