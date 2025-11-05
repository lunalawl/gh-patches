// Unhook ALL battle mode fx from FPS

script menu_select_multiplayer_mode_record_rotate 
	begin
	getscreenelementprops \{id = record}
	new_rot_angle = (<rot_angle> + ($record_angle_change))
	if (<new_rot_angle> > 360.0)
		<new_rot_angle> = (<new_rot_angle> - 360.0)
	elseif (<new_rot_angle> < (-360.0))
		<new_rot_angle> = (<new_rot_angle> + 360.0)
	endif
	setscreenelementprops id = record rot_angle = (<new_rot_angle>)
	wait \{16.683350016683352
		milliseconds}
	repeat
endscript

script test_battle_trigger 
	battlemode_fill
	wait \{5
		seconds}
	battle_trigger_on \{player_status = player2_status}
	wait \{16.683350016683352
		milliseconds}
	battle_trigger_on \{player_status = player2_status}
	wait \{16.683350016683352
		milliseconds}
	battle_trigger_on \{player_status = player1_status}
	wait \{16.683350016683352
		milliseconds}
	battle_trigger_on \{player_status = player1_status}
endscript

script attack_bolt \{bolt_angle = 60}
	bolt_pos_middle = (640.0, 230.0)
	bolt_pos_offset = (330.0, 0.0)
	formattext checksumname = attack_bolt 'attack_bolt%p' p = ($<player_status>.text) addtostringlookup = true
	if screenelementexists id = <attack_bolt>
		destroyscreenelement id = <attack_bolt>
	endif
	if ($<player_status>.player = 1)
		bolt_angle = (-1 * <bolt_angle>)
		bolt_scale = (-1.0, 1.0)
		bolt_just = [middle top]
		bolt_pos = (<bolt_pos_middle> - <bolt_pos_offset>)
	else
		bolt_angle = <bolt_angle>
		bolt_scale = (1.0, 1.0)
		bolt_just = [middle top]
		bolt_pos = (<bolt_pos_middle> + <bolt_pos_offset>)
	endif
	createscreenelement {
		type = spriteelement
		id = <attack_bolt>
		parent = battlemode_container
		material = sys_big_bolt01_red_sys_big_bolt01_red
		rgba = [255 255 255 255]
		pos = <bolt_pos>
		rot_angle = <bolt_angle>
		scale = <bolt_scale>
		just = <bolt_just>
		z_priority = 10
	}
	getsongtimems
	formattext checksumname = attack_bolt_particle 'attack_bolt_particle_%s_%t' s = ($<player_status>.text) t = <time> addtostringlook = true
	if ($<player_status>.player = 1)
		emit_direction = 300
		bolt_hit_pos = (<bolt_pos> + (455.0, 0.0) + (0.0, 250.0))
	else
		emit_direction = -300
		bolt_hit_pos = (<bolt_pos> - (455.0, 0.0) + (0.0, 250.0))
	endif
	create2dparticlesystem {
		id = <attack_bolt_particle>
		pos = (<bolt_hit_pos>)
		parent = battlemode_container
		z_priority = 8.0
		material = sys_particle_spark01_sys_particle_spark01
		start_color = [255 66 0 255]
		end_color = [128 0 0 0]
		start_scale = (2.0, 2.0)
		end_scale = (0.5, 0.5)
		start_angle_spread = 360.0
		min_rotation = -500.0
		max_rotation = 500.0
		emit_start_radius = 0.0
		emit_radius = 1.0
		emit_rate = 0.01
		emit_dir = <emit_direction>
		emit_spread = 90.0
		velocity = 16.0
		friction = (0.0, 24.0)
		time = 1
	}
	wait \{133.46680013346682
		milliseconds}
	if screenelementexists id = <attack_bolt>
		destroyscreenelement id = <attack_bolt>
	endif
	wait \{33.366700033366705
		milliseconds}
	destroy2dparticlesystem id = <attack_bolt_particle> kill_when_empty
endscript

script death_text_wing_flap 
	hover_sim_rot = 7
	wing_count = 0
	wing_up = 0
	begin
	player_health = ($<other_player_status>.current_health)
	if (<player_health> < 1.0)
		<player_health> = (1.0 - <player_health>)
		new_scale = (0.9 + (0.3 * <player_health>))
		new_pos = (<text_start_pos> + ((0.0, 220.0) * <player_health>))
		doscreenelementmorph {id = <text_bg_checksum> pos = <new_pos> scale = <new_scale>}
	endif
	if (<wing_count> = 4)
		getrandomvalue name = random_rot a = (<hover_sim_rot> * -1) b = <hover_sim_rot> integer
		doscreenelementmorph {
			id = <text_bg_checksum>
			rot_angle = <random_rot>
			time = 0.02
		}
		spawnscriptnow bite_particle params = {other_player_status = <other_player_status> random_rot = <random_rot> text_bg_checksum = <text_bg_checksum>}
		if (<wing_up> = 0)
			doscreenelementmorph {
				id = <text_wing_r_checksum>
				rot_angle = -40
				time = 0.02
			}
			doscreenelementmorph {
				id = <text_wing_l_checksum>
				rot_angle = 40
				time = 0.02
			}
			<wing_up> = 1
		else
			doscreenelementmorph {
				id = <text_wing_r_checksum>
				rot_angle = -10
				time = 0.02
			}
			doscreenelementmorph {
				id = <text_wing_l_checksum>
				rot_angle = 10
				time = 0.02
			}
			<wing_up> = 0
		endif
		<wing_count> = 0
	endif
	<wing_count> = (<wing_count> + 1)
	wait \{16.683350016683352
		milliseconds}
	repeat
endscript

script battle_lightning 
	flicker_ammount = 2
	switch <difficulty>
		case easy
		<flicker_ammount> = ($battlemode_powerups [0].easy_flicker)
		case medium
		<flicker_ammount> = ($battlemode_powerups [0].medium_flicker)
		case hard
		<flicker_ammount> = ($battlemode_powerups [0].hard_flicker)
		case expert
		<flicker_ammount> = ($battlemode_powerups [0].expert_flicker)
	endswitch
	if ($<other_player_status>.player = 1)
		change battle_flicker_difficulty_p1 = <flicker_ammount>
		spawnscript gh_battlemode_player1_sfx_shake_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	else
		change battle_flicker_difficulty_p2 = <flicker_ammount>
		spawnscript gh_battlemode_player2_sfx_shake_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	endif
	getsongtimems
	casttointeger \{time}
	if ($<other_player_status>.shake_notes > -1)
		change structurename = <other_player_status> shake_notes = (($<other_player_status>.shake_notes) + <drain_time>)
	else
		change structurename = <other_player_status> shake_notes = (<time> + <drain_time>)
		spawnscriptnow flicker_gems params = {player = <player> other_player_status = <other_player_status>}
		spawnscriptnow shake_highway params = {player_text = <player_text> other_player_status = <other_player_status>}
		begin
		getsongtimems
		if (<time> > $<other_player_status>.shake_notes)
			change structurename = <other_player_status> shake_notes = -1
			break
		endif
		wait \{16.683350016683352
			milliseconds}
		repeat
		guitarevent_battleattackfinished <...>
	endif
endscript

script flicker_gems 
	begin
	if ($<other_player_status>.shake_notes > -1)
		launchgemevent event = flicker_on player = <player>
	else
		launchgemevent event = flicker_off player = <player>
		break
	endif
	wait \{50.050050050050054
		milliseconds}
	repeat
endscript

script shake_highway 
	formattext checksumname = container_id 'gem_container%p' p = <player_text> addtostringlookup = true
	getscreenelementposition id = <container_id>
	original_position = <screenelementpos>
	shake_frequency = 0.05
	begin
	if (<player_text> = 'p1')
		mid_hammer_highway = $battle_p1_highway_hammer
	else
		mid_hammer_highway = $battle_p2_highway_hammer
	endif
	if NOT (<mid_hammer_highway> = 1)
		getscreenelementposition id = <container_id>
		original_position = <screenelementpos>
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	pulse_on = 0
	begin
	if ($<other_player_status>.shake_notes > -1)
		if (<pulse_on> = 0)
			doscreenelementmorph {
				id = <container_id>
				pos = (<original_position> + (0.0, 8.0))
				just = [center bottom]
				time = <shake_frequency>
			}
			wait <shake_frequency> seconds
			<pulse_on> = 1
		else
			doscreenelementmorph {
				id = <container_id>
				pos = (<original_position> - (0.0, 8.0))
				just = [center bottom]
				time = <shake_frequency>
			}
			wait <shake_frequency> seconds
			<pulse_on> = 0
		endif
	else
		doscreenelementmorph {
			id = <container_id>
			pos = <original_position>
			just = [center bottom]
		}
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
endscript

script shake_highway_death 
	formattext checksumname = container_id 'gem_container%p' p = ($<other_player_status>.text) addtostringlookup = true
	getscreenelementposition id = <container_id>
	original_position = <screenelementpos>
	shake_frequency = 0.05
	begin
	if (<player_text> = 'p1')
		mid_hammer_highway = $battle_p1_highway_hammer
	else
		mid_hammer_highway = $battle_p2_highway_hammer
	endif
	if NOT (<mid_hammer_highway> = 1)
		getscreenelementposition id = <container_id>
		original_position = <screenelementpos>
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	pulse_on = 0
	begin
	if (<pulse_on> = 0)
		doscreenelementmorph {
			id = <container_id>
			pos = (<original_position> + (7.0, 0.0))
			just = [center bottom]
			time = <shake_frequency>
		}
		wait <shake_frequency> seconds
		<pulse_on> = 1
	else
		doscreenelementmorph {
			id = <container_id>
			pos = (<original_position> - (7.0, 0.0))
			just = [center bottom]
			time = <shake_frequency>
		}
		wait <shake_frequency> seconds
		<pulse_on> = 0
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
endscript

script hammer_rock_meter 
	if (<other_player_text> = 'p1')
		push_pos = (-75.0, 50.0)
		mid_hammer_highway = $battle_p1_highway_hammer
	else
		push_pos = (70.0, 50.0)
		mid_hammer_highway = $battle_p2_highway_hammer
	endif
	if NOT (<mid_hammer_highway> = 1)
		if (<other_player_text> = 'p1')
			change \{battle_p1_highway_hammer = 1}
		else
			change \{battle_p2_highway_hammer = 1}
		endif
		formattext checksumname = container_id 'HUD2D_rock_container%p' p = <other_player_text> addtostringlookup = true
		getscreenelementposition id = <container_id>
		original_position = <screenelementpos>
		doscreenelementmorph {
			id = <container_id>
			pos = (<original_position> + <push_pos>)
			just = [center bottom]
			time = 0.1
		}
		wait \{0.1
			seconds}
		doscreenelementmorph {
			id = <container_id>
			pos = <original_position>
			just = [center bottom]
			time = 0.1
		}
		if (<other_player_text> = 'p1')
			change \{battle_p1_highway_hammer = 0}
		else
			change \{battle_p2_highway_hammer = 0}
		endif
	endif
endscript

script battle_up_difficulty 
	if ($<other_player_status>.player = 1)
		spawnscript gh_battlemode_player1_sfx_diffup_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	else
		spawnscript gh_battlemode_player2_sfx_diffup_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	endif
	if (<difficulty> = expert)
		battle_double_notes <...>
		return
	endif
	if NOT ($<other_player_status>.diffup_notes = -1)
		change structurename = <other_player_status> diffup_notes = ($<other_player_status>.diffup_notes + <drain_time>)
		return
	endif
	getsongtimems
	casttointeger \{time}
	change structurename = <other_player_status> diffup_notes = (<time> + <drain_time>)
	update_hud_difficulty_up other_player_status = <other_player_status> difficulty = <difficulty>
	hold_difficulty_up = ($<other_player_status>.hold_difficulty_up)
	begin
	getsongtimems
	casttointeger \{time}
	if (<time> > <hold_difficulty_up>)
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	extendcrc change_difficulty <player_text> out = type
	original_difficulty = <difficulty>
	switch <difficulty>
		case easy
		broadcastevent type = <type> data = {difficulty = medium difficulty_text_nl = 'medium'}
		case medium
		broadcastevent type = <type> data = {difficulty = hard difficulty_text_nl = 'hard'}
		case hard
		broadcastevent type = <type> data = {difficulty = expert difficulty_text_nl = 'expert'}
	endswitch
	getsongtimems
	casttointeger \{time}
	change structurename = <other_player_status> diffup_notes = (<time> + <drain_time>)
	begin
	getsongtimems
	if (<time> > $<other_player_status>.diffup_notes)
		printf \{"end battle"}
		extendcrc change_difficulty <player_text> out = type
		original_difficulty = <difficulty>
		switch <original_difficulty>
			case easy
			broadcastevent type = <type> data = {difficulty = easy difficulty_text_nl = 'easy'}
			case medium
			broadcastevent type = <type> data = {difficulty = medium difficulty_text_nl = 'medium'}
			case hard
			broadcastevent type = <type> data = {difficulty = hard difficulty_text_nl = 'hard'}
		endswitch
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	change structurename = <other_player_status> diffup_notes = -1
	guitarevent_battleattackfinished <...>
endscript

script battle_double_notes 
	if ($<other_player_status>.player = 1)
		spawnscript gh_battlemode_player1_sfx_doublenotes_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	else
		spawnscript gh_battlemode_player2_sfx_doublenotes_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	endif
	if NOT ($<other_player_status>.double_notes = -1)
		change structurename = <other_player_status> double_notes = ($<other_player_status>.double_notes + <drain_time>)
		return
	endif
	getsongtimems
	casttointeger \{time}
	change structurename = <other_player_status> double_notes = (<time> + <drain_time>)
	update_hud_double_notes other_player_status = <other_player_status>
	begin
	getsongtimems
	if (<time> > $<other_player_status>.double_notes)
		printf \{"end battle"}
		change structurename = <other_player_status> double_notes = -1
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	guitarevent_battleattackfinished <...>
endscript

script animate_steal 
	if ($<other_player_status>.player = 1)
		hand_scale = (-1.0, 1.0)
		hand_y_offset = (0.0, -10.0)
		hand_x_offset = (-40.0, 0.0)
	else
		hand_scale = (1.0, 1.0)
		hand_y_offset = (0.0, -10.0)
		hand_x_offset = (40.0, 0.0)
	endif
	formattext checksumname = steal_hand_open_checksum 'steal_hand_open_%i_%p' i = ($<other_player_status>.stealing_powerup) p = ($<other_player_status>.player)
	if screenelementexists id = <steal_hand_open_checksum>
		destroyscreenelement id = <steal_hand_open_checksum>
	endif
	formattext checksumname = steal_hand_checksum 'steal_hand_%i_%p' i = ($<other_player_status>.stealing_powerup) p = ($<other_player_status>.player)
	wait \{16.683350016683352
		milliseconds}
	createscreenelement {
		type = spriteelement
		id = <steal_hand_open_checksum>
		parent = battlemode_container
		texture = battle_hud_steal_hand_open
		rgba = [255 255 255 255]
		pos = (<morph_to_pos> + <hand_y_offset>)
		scale = <hand_scale>
		alpha = 0
		just = [center center]
		z_priority = 25
	}
	doscreenelementmorph {
		id = <steal_hand_open_checksum>
		pos = (<start_pos> + <hand_y_offset> - <hand_x_offset>)
		alpha = 1
		time = 0.5
	}
	wait \{0.5
		seconds}
	if screenelementexists id = <steal_hand_open_checksum>
		destroyscreenelement id = <steal_hand_open_checksum>
	endif
	if NOT ($<other_player_status>.current_num_powerups = 0)
		if ($<other_player_status>.player = 1)
			select = ($current_powerups_p1 [($<other_player_status>.current_num_powerups - 1)])
		else
			select = ($current_powerups_p2 [($<other_player_status>.current_num_powerups - 1)])
		endif
		formattext checksumname = card_checksum 'battlecard_%i_%s' i = ($<other_player_status>.current_num_powerups - 1) s = ($<other_player_status>.player)
		if screenelementexists id = <card_checksum>
			destroyscreenelement id = <card_checksum>
		endif
		change structurename = <other_player_status> current_num_powerups = ($<other_player_status>.current_num_powerups - 1)
		printf "animate_steal - decremented p%n's current_num_powerups to %a" n = ($<other_player_status>.player) a = ($<other_player_status>.current_num_powerups)
		update_battlecards_remove player_status = <other_player_status>
		getsongtimems
		formattext checksumname = held_card_checksum 'held_battlecard_%i_%s_%t' i = ($<other_player_status>.current_num_powerups - 1) s = ($<other_player_status>.player) t = <time>
		createscreenelement {
			type = spriteelement
			id = <held_card_checksum>
			parent = battlemode_container
			texture = ($battlemode_powerups [<select>].card_texture)
			rgba = [255 255 255 255]
			pos = <start_pos>
			dims = (64.0, 64.0)
			just = [center center]
			z_priority = (($battle_hud_2d_elements.z) + 19)
		}
		doscreenelementmorph {
			id = <held_card_checksum>
			pos = <morph_to_pos>
			time = 0.5
		}
		if screenelementexists id = <steal_hand_checksum>
			destroyscreenelement id = <steal_hand_checksum>
		endif
		createscreenelement {
			type = spriteelement
			id = <steal_hand_checksum>
			parent = battlemode_container
			texture = battle_hud_steal_hand
			rgba = [255 255 255 255]
			pos = (<start_pos> + <hand_y_offset> - <hand_x_offset>)
			scale = <hand_scale>
			alpha = 1
			just = [center center]
			z_priority = 25
		}
		doscreenelementmorph {
			id = <steal_hand_checksum>
			texture = battle_hud_steal_hand
			pos = (<morph_to_pos> + <hand_y_offset> - <hand_x_offset>)
			time = 0.5
		}
		wait \{0.4
			seconds}
		doscreenelementmorph {
			id = <steal_hand_checksum>
			alpha = 0
			time = 0.1
		}
		wait \{0.1
			seconds}
		if screenelementexists id = <held_card_checksum>
			destroyscreenelement id = <held_card_checksum>
		endif
		if screenelementexists id = <steal_hand_checksum>
			destroyscreenelement id = <steal_hand_checksum>
		endif
		battlemode_ready player_status = <player_status> battle_gem = <select> steal = 1
	endif
endscript

script battle_lefty_notes 
	if ($<other_player_status>.player = 1)
		spawnscript gh_battlemode_player1_sfx_leftynotes_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	else
		spawnscript gh_battlemode_player2_sfx_leftynotes_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	endif
	if NOT ($<other_player_status>.lefty_notes = -1)
		change structurename = <other_player_status> lefty_notes = ($<other_player_status>.lefty_notes + <drain_time>)
		return
	endif
	change structurename = <other_player_status> lefthanded_gems_flip_save = ($<other_player_status>.lefthanded_gems)
	change structurename = <other_player_status> lefthanded_button_ups_flip_save = ($<other_player_status>.lefthanded_button_ups)
	change structurename = <other_player_status> lefthanded_gems = (1 + $<other_player_status>.lefthanded_gems * -1)
	getsongtimems
	casttointeger \{time}
	change structurename = <other_player_status> lefty_notes = (<time> + <drain_time>)
	start_time = (<time> + (($<other_player_status>.scroll_time - $destroy_time) * 1000.0))
	end_time = -1
	update_hud_lefty_notes other_player_status = <other_player_status>
	begin
	getsongtimems
	if NOT (<start_time> = -1)
		if (<time> > (<start_time> - 500))
			animate_lefty_flip other_player_status = <other_player_status> player_text = <player_text>
			change structurename = <other_player_status> lefthanded_button_ups = (1 + $<other_player_status>.lefthanded_button_ups * -1)
			start_time = -1
		endif
	endif
	if (<time> > $<other_player_status>.lefty_notes)
		printf \{"end battle"}
		end_time = (<time> + (($<other_player_status>.scroll_time - $destroy_time) * 1000.0))
		change structurename = <other_player_status> lefthanded_gems = (1 + $<other_player_status>.lefthanded_gems * -1)
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	begin
	getsongtimems
	if NOT (<start_time> = -1)
		if (<time> > <start_time>)
			animate_lefty_flip other_player_status = <other_player_status> player_text = <player_text>
			change structurename = <other_player_status> lefthanded_button_ups = (1 + $<other_player_status>.lefthanded_button_ups * -1)
			start_time = -1
		endif
	endif
	if (<time> > (<end_time> - 500))
		animate_lefty_flip other_player_status = <other_player_status> player_text = <player_text>
		change structurename = <other_player_status> lefthanded_button_ups = (1 + $<other_player_status>.lefthanded_button_ups * -1)
		change structurename = <other_player_status> lefty_notes = -1
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	guitarevent_battleattackfinished <...>
endscript

script battle_whammy_attack 
	repair_ammount = 5
	switch <difficulty>
		case easy
		<repair_ammount> = ($battlemode_powerups [6].easy_repair)
		case medium
		<repair_ammount> = ($battlemode_powerups [6].medium_repair)
		case hard
		<repair_ammount> = ($battlemode_powerups [6].hard_repair)
		case expert
		<repair_ammount> = ($battlemode_powerups [6].expert_repair)
	endswitch
	if ($<other_player_status>.player = 1)
		spawnscript gh_battlemode_player1_sfx_whammy_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	else
		spawnscript gh_battlemode_player2_sfx_whammy_start params = {holdtime = (<drain_time> / 1000.0)} id = battlemode
	endif
	if ($<other_player_status>.whammy_attack < 1)
		change structurename = <other_player_status> whammy_attack = <repair_ammount>
		whammy_on = 0
		shake_on = 0
		frame_count = 0
		shake_frequency = 1
		mask = 65536
		change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask || <mask>)
		mask = 4096
		change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask || <mask>)
		mask = 256
		change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask || <mask>)
		mask = 16
		change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask || <mask>)
		mask = 1
		change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask || <mask>)
		update_training_whammy_bar other_player_status = <other_player_status>
		if ($<other_player_status>.is_local_client)
			begin
			if ($<other_player_status>.whammy_attack = 0)
				break
			endif
			if guitargetanalogueinfo controller = ($<other_player_status>.controller)
				if isguitarcontroller controller = ($<other_player_status>.controller)
					<len> = ((<rightx> + 1.0) / 2.0)
				else
					if (<leftlength> > 0)
						<len> = <leftlength>
					else
						if (<rightlength> > 0)
							<len> = <rightlength>
						else
							<len> = 0
						endif
					endif
				endif
			else
				<len> = 0
			endif
			if ($boss_battle = 1 &&
					<other_player_status>.player = 2)
				getsongtimems
				if (<time> - $boss_lastwhammytime > $current_boss.whammyspeed.($current_difficulty))
					len = 0.5
					change boss_lastwhammytime = <time>
				else
					len = 0
				endif
			endif
			if (<len> >= 0.5)
				if (<whammy_on> = 0)
					change structurename = <other_player_status> whammy_attack = ($<other_player_status>.whammy_attack - 1)
					gh3_battle_play_whammy_pitch_up_sound <...>
					if ($<other_player_status>.whammy_attack <= 5)
						<shake_frequency> = (<shake_frequency> + 1)
					endif
					if (($is_network_game) && ($<other_player_status>.whammy_attack <= 5))
						sendnetmessage {type = whammy_attack_update whammy_count = ($<other_player_status>.whammy_attack)}
					endif
					<whammy_on> = 1
				endif
			else
				if (<whammy_on> = 1)
					<whammy_on> = 0
				endif
			endif
			wait \{16.683350016683352
				milliseconds}
			repeat
		else
			net_whammy_attack player_text = <player_text> other_player_status = <other_player_status> difficulty = <difficulty>
		endif
		getarraysize \{$gem_colors}
		array_count = 0
		begin
		broken_string_id = ($broken_strings [<array_count>])
		if ($<other_player_status>.<broken_string_id> = 0)
			switch <array_count>
				case 0
				mask = 4369
				change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask && <mask>)
				case 1
				mask = 65809
				change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask && <mask>)
				case 2
				mask = 69649
				change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask && <mask>)
				case 3
				mask = 69889
				change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask && <mask>)
				case 4
				mask = 69904
				change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask && <mask>)
			endswitch
		endif
		array_count = (<array_count> + 1)
		repeat <array_size>
		change structurename = <other_player_status> whammy_attack = -1
		guitarevent_battleattackfinished <...>
	else
		if ($<other_player_status>.whammy_attack < 15)
			change structurename = <other_player_status> whammy_attack = ($<other_player_status>.whammy_attack + <repair_ammount>)
		endif
	endif
endscript

script break_string 
	color = ($gem_colors [<id>])
	if ($<other_player_status>.lefthanded_button_ups = 1)
		begin_pos = (($button_up_models.<color>.left_pos_2d) + (0.0, 40.0))
	else
		begin_pos = (($button_up_models.<color>.pos_2d) + (0.0, 40.0))
	endif
	string_rotation = 0
	switch <id>
		case 0
		<string_rotation> = 14
		case 1
		<string_rotation> = 7
		case 2
		<string_rotation> = -2
		case 3
		<string_rotation> = -10
		case 4
		<string_rotation> = -19
	endswitch
	if ($<other_player_status>.player = 1)
		<begin_pos> = (<begin_pos> - (230.0, 0.0))
	else
		<begin_pos> = (<begin_pos> + (230.0, 0.0))
	endif
	formattext checksumname = name 'String_break_%p' p = ($<other_player_status>.text) addtostringlookup = true
	if screenelementexists id = <name>
		destroyscreenelement id = <name>
	endif
	createscreenelement {
		type = spriteelement
		id = <name>
		parent = battlemode_container
		material = sys_bm_snap01_sys_bm_snap01
		rgba = [200 200 200 200]
		pos = (<begin_pos>)
		scale = (1.3, 1.6)
		rot_angle = <string_rotation>
		just = [center bottom]
		z_priority = 2
	}
	if ($<other_player_status>.lefthanded_button_ups = 1)
		switch <color>
			case green
			<color> = orange
			case red
			<color> = blue
			case yellow
			<color> = yellow
			case blue
			<color> = red
			case orange
			<color> = green
		endswitch
	endif
	formattext checksumname = name_string '%s_string%p' s = ($button_up_models.<color>.name_string) p = ($<other_player_status>.text) addtostringlookup = true
	if screenelementexists id = <name_string>
		doscreenelementmorph {
			id = <name_string>
			alpha = 0
		}
	endif
	wait \{250.25025025025028
		milliseconds}
	if screenelementexists id = <id>
		destroyscreenelement id = <id>
	endif
endscript

script battle_broken_string 
	if (($is_network_game = 1) && ($<other_player_status>.player = 1))
		if NOT gotparam \{string_to_break}
			return
		endif
	endif
	repair_ammount = 5
	switch <difficulty>
		case easy
		<repair_ammount> = ($battlemode_powerups [5].easy_repair)
		case medium
		<repair_ammount> = ($battlemode_powerups [5].medium_repair)
		case hard
		<repair_ammount> = ($battlemode_powerups [5].hard_repair)
		case expert
		<repair_ammount> = ($battlemode_powerups [5].expert_repair)
	endswitch
	victim_is_local = 1
	if ($<other_player_status>.player = 1)
		spawnscript gh_battlemode_player1_sfx_brokenstring_start params = {holdtime = <drain_time>} id = battlemode
	else
		if ($is_network_game)
			<victim_is_local> = 0
		endif
		spawnscript gh_battlemode_player2_sfx_brokenstring_start params = {holdtime = <drain_time>} id = battlemode
	endif
	if (<difficulty> = easy)
		highest_value = 3
	else
		if (<difficulty> = medium)
			highest_value = 4
		else
			highest_value = 5
		endif
	endif
	if (($is_network_game) && ($<other_player_status>.player = 1))
		x = <string_to_break>
	else
		getarraysize \{$gem_colors}
		gem_color = 0
		non_broken_index = 0
		non_broken_strings = [-1 -1 -1 -1 -1]
		begin
		switch <gem_color>
			case 0
			if ($<other_player_status>.broken_string_green = 0)
				setarrayelement arrayname = non_broken_strings index = <non_broken_index> newvalue = <gem_color>
				<non_broken_index> = (<non_broken_index> + 1)
			endif
			case 1
			if ($<other_player_status>.broken_string_red = 0)
				setarrayelement arrayname = non_broken_strings index = <non_broken_index> newvalue = <gem_color>
				<non_broken_index> = (<non_broken_index> + 1)
			endif
			case 2
			if ($<other_player_status>.broken_string_yellow = 0)
				setarrayelement arrayname = non_broken_strings index = <non_broken_index> newvalue = <gem_color>
				<non_broken_index> = (<non_broken_index> + 1)
			endif
			case 3
			if ($<other_player_status>.broken_string_blue = 0)
				setarrayelement arrayname = non_broken_strings index = <non_broken_index> newvalue = <gem_color>
				<non_broken_index> = (<non_broken_index> + 1)
			endif
			case 4
			if ($<other_player_status>.broken_string_orange = 0)
				setarrayelement arrayname = non_broken_strings index = <non_broken_index> newvalue = <gem_color>
				<non_broken_index> = (<non_broken_index> + 1)
			endif
		endswitch
		<gem_color> = (<gem_color> + 1)
		repeat <highest_value>
		if (<non_broken_index> = 0)
			getrandomvalue name = x a = 1 b = <highest_value> integer
		else
			getrandomvalue name = random_index a = 0 b = (<non_broken_index> - 1) integer
			x = ((<non_broken_strings> [<random_index>]) + 1)
		endif
	endif
	num_hammers = <repair_ammount>
	switch <x>
		case 1
		change structurename = <other_player_status> broken_string_green = ($<other_player_status>.broken_string_green + <num_hammers>)
		mask = 65536
		case 2
		change structurename = <other_player_status> broken_string_red = ($<other_player_status>.broken_string_red + <num_hammers>)
		mask = 4096
		case 3
		change structurename = <other_player_status> broken_string_yellow = ($<other_player_status>.broken_string_yellow + <num_hammers>)
		mask = 256
		case 4
		change structurename = <other_player_status> broken_string_blue = ($<other_player_status>.broken_string_blue + <num_hammers>)
		mask = 16
		case 5
		change structurename = <other_player_status> broken_string_orange = ($<other_player_status>.broken_string_orange + <num_hammers>)
		mask = 1
	endswitch
	printf "breaking string %s" s = <x>
	spawnscriptnow break_string params = {id = (<x> - 1) other_player_status = <other_player_status>}
	spawnscriptnow update_broken_button params = {id = (<x> - 1) other_player_status = <other_player_status>}
	update_broken_string_arrows id = (<x> - 1) other_player_status = <other_player_status>
	bail = 0
	if NOT ($<other_player_status>.broken_string_mask = 0)
		if ($<other_player_status>.whammy_attack < 1)
			<bail> = 1
		endif
	endif
	change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask || <mask>)
	if (<bail>)
		return
	endif
	getheldpattern controller = ($<other_player_status>.controller) nobrokenstring
	total_broken_strings = 1
	getarraysize \{$gem_colors}
	begin
	last_hold_pattern = <hold_pattern>
	getheldpattern controller = ($<other_player_status>.controller) nobrokenstring
	net_update_flags = 0
	if NOT (<last_hold_pattern> = <hold_pattern>)
		check_button = 65536
		array_count = 0
		begin
		broken_string_id = ($broken_strings [<array_count>])
		if NOT (<last_hold_pattern> && <check_button>)
			if (<hold_pattern> && <check_button>)
				if NOT ($<other_player_status>.<broken_string_id> = 0)
					switch <array_count>
						case 0
						change structurename = <other_player_status> broken_string_green = ($<other_player_status>.broken_string_green - 1)
						mask = 4369
						<net_update_flags> = (<net_update_flags> || <check_button>)
						battle_sfx_repair_broken_string num_strums = ($<other_player_status>.broken_string_green) player_pan = ($<other_player_status>.player) difficulty = <difficulty>
						if ($<other_player_status>.broken_string_green = 0)
							repair_string other_player_status = <other_player_status> id = <array_count>
						endif
						case 1
						change structurename = <other_player_status> broken_string_red = ($<other_player_status>.broken_string_red - 1)
						mask = 65809
						<net_update_flags> = (<net_update_flags> || <check_button>)
						battle_sfx_repair_broken_string num_strums = ($<other_player_status>.broken_string_red) player_pan = ($<other_player_status>.player) difficulty = <difficulty>
						if ($<other_player_status>.broken_string_red = 0)
							repair_string other_player_status = <other_player_status> id = <array_count>
						endif
						case 2
						change structurename = <other_player_status> broken_string_yellow = ($<other_player_status>.broken_string_yellow - 1)
						mask = 69649
						<net_update_flags> = (<net_update_flags> || <check_button>)
						battle_sfx_repair_broken_string num_strums = ($<other_player_status>.broken_string_yellow) player_pan = ($<other_player_status>.player) difficulty = <difficulty>
						if ($<other_player_status>.broken_string_yellow = 0)
							repair_string other_player_status = <other_player_status> id = <array_count>
						endif
						case 3
						change structurename = <other_player_status> broken_string_blue = ($<other_player_status>.broken_string_blue - 1)
						mask = 69889
						<net_update_flags> = (<net_update_flags> || <check_button>)
						battle_sfx_repair_broken_string num_strums = ($<other_player_status>.broken_string_blue) player_pan = ($<other_player_status>.player) difficulty = <difficulty>
						if ($<other_player_status>.broken_string_blue = 0)
							repair_string other_player_status = <other_player_status> id = <array_count>
						endif
						case 4
						change structurename = <other_player_status> broken_string_orange = ($<other_player_status>.broken_string_orange - 1)
						mask = 69904
						<net_update_flags> = (<net_update_flags> || <check_button>)
						battle_sfx_repair_broken_string num_strums = ($<other_player_status>.broken_string_orange) player_pan = ($<other_player_status>.player) difficulty = <difficulty>
						if ($<other_player_status>.broken_string_orange = 0)
							repair_string other_player_status = <other_player_status> id = <array_count>
						endif
					endswitch
					if ($<other_player_status>.<broken_string_id> = 0)
						if ($<other_player_status>.whammy_attack < 1)
							wait \{16.683350016683352
								milliseconds}
							change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask && <mask>)
						endif
					endif
				endif
				total_broken_strings = ($<other_player_status>.broken_string_green +
					$<other_player_status>.broken_string_red +
					$<other_player_status>.broken_string_yellow +
					$<other_player_status>.broken_string_blue +
					$<other_player_status>.broken_string_orange)
			endif
		endif
		<check_button> = (<check_button> / 16)
		array_count = (<array_count> + 1)
		repeat <array_size>
	endif
	if ($is_network_game)
		if NOT (<net_update_flags> = 0)
			if NOT ($<other_player_status>.highway_layout = solo_highway)
				sendnetmessage {
					type = repair_string
					flags = <net_update_flags>
				}
			endif
		endif
	endif
	if (<total_broken_strings> = 0)
		break
	endif
	if ($boss_battle = 1 &&
			<other_player_status>.player = 2)
		if ($<other_player_status>.whammy_attack < 1)
			getsongtimems
			if (<time> - $boss_lastbrokenstringtime > $current_boss.brokenstringspeed.($current_difficulty))
				change boss_pattern = ($<other_player_status>.broken_string_mask)
				change boss_lastbrokenstringtime = <time>
			else
				change \{boss_pattern = 0}
			endif
		endif
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	if ($<other_player_status>.whammy_attack < 1)
		change structurename = <other_player_status> broken_string_mask = 0
	endif
	guitarevent_battleattackfinished <...>
endscript

script update_broken_button 
	broken_string_id = ($broken_strings [<id>])
	color = ($gem_colors [<id>])
	button_up_name = ($button_up_models.<color>.name)
	extendcrc button_up_pixel_array ($<other_player_status>.text) out = pixel_array
	<player_text> = ($<other_player_status>.text)
	begin
	<num_hammers> = 0
	if NOT ($<other_player_status>.<broken_string_id> = 0)
		switch <id>
			case 0
			<num_hammers> = ($<other_player_status>.broken_string_green)
			case 1
			<num_hammers> = ($<other_player_status>.broken_string_red)
			case 2
			<num_hammers> = ($<other_player_status>.broken_string_yellow)
			case 3
			<num_hammers> = ($<other_player_status>.broken_string_blue)
			case 4
			<num_hammers> = ($<other_player_status>.broken_string_orange)
		endswitch
	endif
	if (<num_hammers> = 0)
		break
	endif
	<up_pixels> = (<num_hammers> * 5)
	setarrayelement arrayname = <pixel_array> globalarray index = <id> newvalue = <up_pixels>
	wait \{16.683350016683352
		milliseconds}
	repeat
endscript
