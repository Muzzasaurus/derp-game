#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spike_down = noone
spike_right = noone
spike_left = noone
spike_up = noone
mini_spike_down = noone
mini_spike_right = noone
mini_spike_left = noone
mini_spike_up = noone

fruit = noone

vineleft = noone
vineright = noone

blend = $ffffff
alpha = 1
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field spike_down: sprite
//field spike_right: sprite
//field spike_left: sprite
//field spike_up: sprite
//field mini_spike_down: sprite
//field mini_spike_right: sprite
//field mini_spike_left: sprite
//field mini_spike_up: sprite
//field fruit: sprite
//field vineleft: sprite
//field vineright: sprite
//field blend: color
//field alpha: number(0,1)

//spikes
if (spike_down!=noone) {
    with (SpikeDown) {sprite_index=other.spike_down image_blend=other.blend image_alpha=other.alpha}
    //with (SpikeTrapD) {sprite_index=other.spike_down image_blend=other.blend image_alpha=other.alpha}
}
if (spike_left!=noone) {
    with (SpikeLeft) {sprite_index=other.spike_left image_blend=other.blend image_alpha=other.alpha}
    //with (SpikeTrapL) {sprite_index=other.spike_left image_blend=other.blend image_alpha=other.alpha}
}
if (spike_right!=noone) {
    with (SpikeRight) {sprite_index=other.spike_right image_blend=other.blend image_alpha=other.alpha}
    //with (SpikeTrapR) {sprite_index=other.spike_right image_blend=other.blend image_alpha=other.alpha}
}
if (spike_up!=noone) {
    with (SpikeUp) {sprite_index=other.spike_up image_blend=other.blend image_alpha=other.alpha}
   //with (SpikeTrapU) {sprite_index=other.spike_up image_blend=other.blend image_alpha=other.alpha}
}

// minispikes
if (mini_spike_down!=noone) {
    with (MiniSpikeDown) {sprite_index=other.mini_spike_down image_blend=other.blend image_alpha=other.alpha}
}
if (mini_spike_left!=noone) {
    with (MiniSpikeLeft) {sprite_index=other.mini_spike_left image_blend=other.blend image_alpha=other.alpha}
}
if (mini_spike_right!=noone) {
    with (MiniSpikeRight) {sprite_index=other.mini_spike_right image_blend=other.blend image_alpha=other.alpha}
}
if (mini_spike_up!=noone) {
    with (MiniSpikeUp) {sprite_index=other.mini_spike_up image_blend=other.blend image_alpha=other.alpha}
}

// fruit
if (fruit!=noone) {
    with (Cherry) {sprite_index=other.fruit image_blend=other.blend image_alpha=other.alpha}
    //with (FruitTrap) {sprite_index=other.fruit image_blend=other.blend image_alpha=other.alpha}
}

//vines

if (vineleft!=noone) {
    with (VineLeft) {sprite_index=other.vineleft image_blend=other.blend image_alpha=other.alpha}
}

if (vineright!=noone) {
    with (VineRight) {sprite_index=other.vineright image_blend=other.blend image_alpha=other.alpha}
}
