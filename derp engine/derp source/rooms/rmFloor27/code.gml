if(instance_exists(Player)){
    if(Player.y<304){
        global.grav = 1;

        with(Player) {
            gravity = global.grav * grav;
            player_set_mask();
        }
    }
}
instance_create(0,0,objMirrorTempleBG)
instance_create(0,0,objMirrorTempleBG2)