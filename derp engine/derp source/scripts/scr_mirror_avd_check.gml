//scr_mirror_avd_check()
switch(pos){
    case(0):
        if(xpos mod 3 == 0){
            return false
        }
        break
    case(1):
        if(xpos mod 3 == 1){
            return false
        }
        break
    case(2):
        if(xpos mod 3 == 2){
            return false
        }
        break
    default:
        return false
        break
}
return true
