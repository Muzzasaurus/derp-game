#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Zero grav variables
entered=false
ho=0
vo=0

// Behavior constants
ground_jump_speed = 8.5;
air_jump_speed = 7;
jump_release_multiplier = 0.45;
grav = 0.4;
max_air_jumps = save_get("StarJumps");
max_vspeed = 9;
run_speed = 3;
ladder=false
ladderjump=false

// State
frozen = false;
gravity = grav * global.grav;
air_jumps = max_air_jumps;
h_input = 0;
x_scale = 1;
has_bow = (save_get("difficulty") == 0);
on_floor = false;
vine_direction = false;
feet_y_prev = 0;

if global.save_autosave {
    save_save();
    global.save_autosave = false;
}

player_set_mask();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///the ladder preceeds all
// I dont make the rules

v_input = input_check(key_down) - input_check(key_up);
if (v_input!=0 && !ladder) if (instance_place(x,y,Ladder)) {
    ladder=true
    air_jumps=max_air_jumps
}

if (ladder) {
    if (!instance_place(x,y,Ladder) || (on_floor && macro_down_flip())) {
        //fall off
        ladder=false
    } else {
        //ride ladder
        if (v_input!=0) {if (place_free(x,y+run_speed*v_input)) {
            vspeed=run_speed*v_input
            gravity=0
        }} else { vspeed=0 gravity=0}

        //jump out of ladder
        if (input_check_pressed(key_jump)) {
            ladderjump=true
            ladder=false
        }
    }
}

if (!ladder) {
    //normal gravity when not in a ladder
    gravity=grav*global.grav
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Movement
var _current_max_vspeed, _ice, _conveyor;

_ice = instance_place(x, y + global.grav, IceBlock);

vine_direction = place_meeting(x + 1, y, VineRight);
if vine_direction == 0 {
    vine_direction = -place_meeting(x - 1, y, VineLeft);
}

// Horizontal movement
if !place_meeting(x,y,ZeroGravField) {
    h_input = 0;
    if !frozen {
        h_input = input_check(key_right);
        if h_input == 0 {
            h_input = -input_check(key_left);
        }
    }
}

if h_input != 0 if vine_direction == 0 {
    x_scale = h_input;
}

if _ice == noone {
    hspeed = h_input * run_speed;
}
else {
    if h_input != 0 {
        hspeed += h_input * _ice.slip;
        hspeed = clamp(hspeed, -run_speed, run_speed);
    }
    else {
        hspeed -= sign(hspeed) * min(_ice.slip, abs(hspeed));
    }
}

_conveyor = instance_place(x, y + global.grav, ConveyorLeft);
if _conveyor != noone {
    hspeed += _conveyor.spd;
}
_conveyor = instance_place(x, y + global.grav, ConveyorRight);
if _conveyor != noone {
    hspeed += _conveyor.spd;
}

// Vertical movement
_current_max_vspeed = max_vspeed;
if place_meeting(x, y, WaterCatharsis) {
    _current_max_vspeed = 2;
    if place_meeting(x, y, WaterRefreshing) {
        air_jumps = max_air_jumps;
    }
}
if global.grav * vspeed > _current_max_vspeed {
    vspeed = global.grav * _current_max_vspeed;
}

if on_floor {
    if place_free(x, y + global.grav) && !place_meeting(x, y + 2 * global.grav, Platform) {
        on_floor = false;
    }
}

if(!ladder) gravity = global.grav * grav;
feet_y_prev = ternary(global.grav == 1, bbox_bottom, bbox_top);
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Actions

if !frozen {
    if input_check_pressed(key_jump) {
        player_try_jump();
    }
    if input_check_released(key_jump) {
        player_release_jump();
    }
    if input_check_pressed(key_shoot) {
        player_shoot();
    }
    if input_check_pressed(key_suicide) {
        player_kill();
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Vines

if vine_direction != 0 {
    if vine_direction == 1 {
        x_scale = -1;
    }
    else {
        x_scale = 1;
    }

    vspeed = 2 * global.grav;

    if (vine_direction == -1 && input_check_pressed(key_right)) || (vine_direction == 1 && input_check_pressed(key_left)) {
        if input_check(key_jump) {
            hspeed = 15;
            vspeed = -9 * global.grav;
            sound_play("player_wall_jump");
        }
        else {
            hspeed = 3;
        }

        if vine_direction == 1 {
            hspeed *= -1;
        }

        vine_direction = 0;
        if place_meeting(x,y,ZeroGravField) {
            ho=hspeed
            h_input *= -1
        }
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Slope collision
var _landed, _sign, _was_on_slope, _is_going_into_slope, _store_y;

_landed = false;
_sign = esign(vspeed + gravity, global.grav);
_was_on_slope = false;
_is_going_into_slope = false;

if _sign == global.grav {
    _was_on_slope = place_meeting(x, y + 2 * global.grav, Slope);
    if !_was_on_slope {
        _is_going_into_slope = place_meeting(x + hspeed, y + 2 * global.grav, Slope);
    }
    if _was_on_slope || _is_going_into_slope {
        x += hspeed;

        if place_free(x, y) {
            if _was_on_slope if !place_free(x, y + 8 * global.grav) {
                while(place_free(x, y + global.grav)) {
                    _store_y = round(y);
                    do {
                        y += gravity;
                    }
                    until round(y) != _store_y;
                }
                y -= gravity;
                _landed = true;
            }
        }
        else {
            _store_y = y;
            move_outside_solid(180 - 90 * global.grav, abs(6));
            if !place_free(x, y) {
                y = _store_y;
            }
            else {
                y -= gravity;
                _landed = true;
            }
        }

        x -= hspeed;
    }
}

if _landed {
    player_land();
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Solid collision
var _dist, _dir;

// Gravity will be added by the time the player moves, but it hasn't been yet.
// We temporarily add it now to correct for this.
vspeed += gravity;

if !place_free(x + hspeed, y + vspeed) {
    if !place_free(x + hspeed, y) {
        // Horizontal collision
        _dist = abs(hspeed);
        _dir = 180 * (hspeed < 0);
        
        move_contact_solid(_dir, _dist);
        hspeed = 0;
    }
    
    if !place_free(x, y + vspeed) {
        // Vertical collision
        _dist = abs(vspeed);
        _dir = 90 + 180 * (vspeed > 0);
        
        move_contact_solid(_dir, _dist);
        
        if global.grav * vspeed < 0 {
            player_hit_ceiling();
        }
        else {
            player_land();
        }
    }
    
    if !place_free(x + hspeed, y + vspeed) {
        // If there is still a collision after the previous checks, the player
        // is moving against a corner.
        hspeed = 0;
    }
}

vspeed -= gravity;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///nang fields
run_speed = 3
grav = 0.4

if (instance_place(x,y,LowSpeedField)) {
    run_speed = 1
} else if (instance_place(x,y,HighSpeedField)) {
    run_speed = 6
}

if (instance_place(x,y,HighGravField)) {
    grav = 0.7
} else if (instance_place(x,y,LowGravField)) {
    grav = 0.2
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Zero grav step event
if (instance_place(x,y,ZeroGravField) and entered) {
    hspeed = ho
    grav = 0
    gravity = 0
    if(on_floor and vspeed != -global.grav * ground_jump_speed and vspeed != 0) {
        vspeed = 0
    }
    if (place_meeting(x+hspeed,y+vspeed,Block) and !place_meeting(x+hspeed,y,Block) and vspeed < 0) {
        vspeed=0
    }
    // Potential fix, may cause other bugs
    if (place_meeting(x,y+global.grav,Block)) and (!on_floor) {
        on_floor=true
        vspeed=0
    }
    if (place_meeting(x+hspeed,y,Block)) {
        ho=0
        hspeed=0
    }
    //vspeed = vo
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Zero grav begin step
if (instance_place(x,y,ZeroGravField) and !entered) {
    entered = true
    ho = hspeed
    vo = vspeed
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Platform collision
var yy, _dir, _feet_y, _feet_y_prev, _platform_floor, _platform_floor_prev;
var _upwards_platform_vspeed, _downwards_platform_vspeed;
var _above_platform_prev, _on_or_below_platform_now, _landed_on_platform;
var _below_platform_prev, _on_or_above_platform_now, _jumped_out;
var _is_forcefully_pushed, _can_freely_snap;

with(Platform) {
    if is_undefined(platform_floor_prev) {
        // Platform didn't exist one frame ago
        continue;
    }

    if other.bbox_right < bbox_left || other.bbox_left > bbox_right {
        continue;
    }

    _feet_y = ternary(global.grav == 1, other.bbox_bottom, other.bbox_top);
    _platform_floor = ternary(global.grav == 1, bbox_top, bbox_bottom);
    _upwards_platform_vspeed = global.grav * min(global.grav * vspeed, 0);
    _downwards_platform_vspeed = global.grav * max(global.grav * vspeed, 0);

    // Whether the player just landed on the platform from above.
    _above_platform_prev = global.grav * (other.feet_y_prev) < global.grav * (platform_floor_prev);
    _on_or_below_platform_now = global.grav * (_feet_y) >= global.grav * (_platform_floor - global.grav);
    _landed_on_platform = _above_platform_prev && _on_or_below_platform_now;
    // Whether the player just jumped through the platform from below.
    _below_platform_prev = global.grav * (other.feet_y_prev) >= global.grav * (platform_floor_prev);
    _on_or_above_platform_now = global.grav * (_feet_y) < global.grav * (_platform_floor);
    _jumped_out = _below_platform_prev && _on_or_above_platform_now;

    if _landed_on_platform || (_jumped_out && snap) {
        // Try to snap to platform
        with(other) {
            // Target y position to snap to
            yy = floor(_platform_floor + round(y) - _feet_y - global.grav);

            _is_forcefully_pushed = global.strong_platforms && _landed_on_platform;
            _can_freely_snap = place_free(x, yy);
            
            if _is_forcefully_pushed || _can_freely_snap {
                // Snap to platform
                y = yy;
                player_land();
            }
            else {
                // Block in the way, move against it
                _dir = 90 + 180 * (yy > y);
                move_contact_solid(_dir, abs(yy - y));
            }
            
            if other.hspeed != 0 {
                if !place_free(x + other.hspeed, y) {
                    move_contact_solid(180 * (other.hspeed < 0), abs(other.hspeed));
                }
                else {
                    x += other.hspeed;
                }
            }

            vspeed = _downwards_platform_vspeed;

            with(other) {
                player_check_crush();
            }
        }
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Killer collision, outside room checks
var _warp;

if place_meeting(x, y, PlayerKiller) {
    player_kill();
}

if bbox_right < 0 || bbox_left >= room_width || bbox_bottom < 0 || bbox_top >= room_height {
    _warp = noone;
    with(RoomChanger) {
        if type == type_outside || type == type_wrap_around if place_meeting(x, y, Player) {
            _warp = id;
        }
    }

    if _warp != noone {
        with(_warp) {
            event_user(0);
        }
    }
    else if global.killer_room_border {
        player_kill();
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Player animation
if ladder {
    if (hspeed!=0) {
        sprite_index=sprPlayerLadderLR
        image_speed=0.2
    } else if (vspeed!=0) {
        sprite_index=sprPlayerLadderUD
        image_speed=0.2
    } else {
        sprite_index=sprPlayerBack
        image_speed=0.1
    }
}
else if on_floor {
    if h_input != 0 {
        sprite_index = sprPlayerRun;
        image_speed = 0.5;
    }
    else {
        sprite_index = sprPlayerIdle;
        image_speed = 0.2;
    }
}
else if vine_direction != 0 {
    sprite_index = sprPlayerSlide;
    image_speed = 0.5;
}
else {
    if vspeed * global.grav < 0 {
        sprite_index = sprPlayerJump;
        image_speed = 0.5;
    }
    else {
        sprite_index = sprPlayerFall;
        image_speed = 0.5;
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Zero grav end step
if (!instance_place(x,y,ZeroGravField) and entered) {
    entered = false
    grav = 0.4
    hspeed=ho
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !is_in_game() {
    instance_destroy();
    exit;
}

if global.save_autosave {
    save_save();
    global.save_autosave = false;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Prevent some drawing issues
var _draw_x, _draw_y, _draw_sprite, _draw_alpha, _draw_color, _draw_yscale;

// Round draw coordinates to prevent jitter.
_draw_x = floor(x + 0.5);
_draw_y = floor(y + 0.5);

// Debug visuals
_draw_sprite = sprite_index;
_draw_alpha = image_alpha;
_draw_color = image_blend;
_draw_y_scale = image_yscale * global.grav;

if global.debug_god_mode {
    _draw_alpha *= 0.75;
}
if global.debug_infinite_jump {
    _draw_color = color_blend(_draw_color, c_aqua);
}
if global.debug_show_mask {
    _draw_sprite = mask_index;
    _draw_y_scale = image_yscale;
}

// Draw the player
draw_sprite_ext(_draw_sprite, image_index, _draw_x, _draw_y, x_scale, _draw_y_scale, image_angle, _draw_color, _draw_alpha);

// Draw the bow
if has_bow {
    draw_sprite_ext(sprPlayerBow, image_index, _draw_x, _draw_y, x_scale, image_yscale * global.grav, image_angle, image_blend, image_alpha);
}

if(instance_exists(objMirrorController)){
    draw_sprite_ext(_draw_sprite, image_index, _draw_x, (304-_draw_y)+304, x_scale, _draw_y_scale*-1, image_angle, _draw_color, _draw_alpha);
    if has_bow draw_sprite_ext(sprPlayerBow, image_index, _draw_x, ((_draw_y-304)*-1)+304, x_scale, image_yscale * -global.grav, image_angle, image_blend, image_alpha);
}
if(room==rmFloor27) {
    draw_sprite_ext(_draw_sprite, image_index, (2800-_draw_x)+2800, _draw_y, x_scale*-1, _draw_y_scale, image_angle, _draw_color, _draw_alpha);
    if has_bow draw_sprite_ext(sprPlayerBow, image_index, (2800-_draw_x)+2800, _draw_y, x_scale*-1, image_yscale * global.grav, image_angle, image_blend, image_alpha);
    draw_sprite_ext(_draw_sprite, image_index, (2800-_draw_x)+2800, (304-_draw_y)+304, x_scale*-1, _draw_y_scale*-1, image_angle, _draw_color, _draw_alpha);
    if has_bow draw_sprite_ext(sprPlayerBow, image_index, (2800-_draw_x)+2800, ((_draw_y-304)*-1)+304, x_scale*-1, image_yscale * -global.grav, image_angle, image_blend, image_alpha);
}
