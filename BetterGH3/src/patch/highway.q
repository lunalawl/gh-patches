// Fix 2p hyperspeed
p2_scroll_time_factor = 1
p2_game_speed_factor = 1

// Allow hyperspeed online
// Additional speeds are unused
script difficulty_setup 
	scroll_time_factor = 1
	game_speed_factor = 1
	if ($current_num_players = 2 || $end_credits = 1)
		scroll_time_factor = ($p2_scroll_time_factor)
		game_speed_factor = ($p2_game_speed_factor)
	endif
	if ($cheat_hyperspeed > 0)
		hyperspeed_scale = -1
		switch $cheat_hyperspeed
			case 1
			<hyperspeed_scale> = 0.88
			case 2
			<hyperspeed_scale> = 0.83
			case 3
			<hyperspeed_scale> = 0.78
			case 4
			<hyperspeed_scale> = 0.72999996
			case 5
			<hyperspeed_scale> = 0.68
			case 6
			<hyperspeed_scale> = 0.63
			case 7
			<hyperspeed_scale> = 0.58
			case 8
			<hyperspeed_scale> = 0.53
			case 9
			<hyperspeed_scale> = 0.48
		endswitch
		if (<hyperspeed_scale> > 0)
			scroll_time_factor = (<scroll_time_factor> * <hyperspeed_scale>)
			game_speed_factor = (<game_speed_factor> * <hyperspeed_scale>)
		endif
	endif
	addparams ($difficulty_list_props.<difficulty>)
	change structurename = <player_status> scroll_time = (<scroll_time> * <scroll_time_factor>)
	change structurename = <player_status> game_speed = (<game_speed> * <game_speed_factor>)
endscript

// Show early timing
script kill_object_later
	if ScreenElementExists Id = <gem_id>
		DestroyGem Name = <gem_id>
	endif
endscript

// High FPS flames fix
script hit_note_fx 
	notefx <...>
	wait \{100.10010010010011
		milliseconds}
	destroy2dparticlesystem id = <particle_id> kill_when_empty
	wait \{166.83350016683352
		milliseconds}
	if screenelementexists id = <fx_id>
		destroyscreenelement id = <fx_id>
	endif
endscript

// High FPS highway anim
script move_highway_2d 
	change \{start_2d_move = 0}
	begin
	if ($start_2d_move = 1)
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
	highway_start_y = 720
	pos_start_orig = 0
	pos_add = -720
	pos_sub = 1.0
	pos_sub_add = -0.00044
	begin
	<pos> = (((<container_pos>.(1.0, 0.0)) * (1.0, 0.0)) + (<highway_start_y> * (0.0, 1.0)))
	setscreenelementprops id = <container_id> pos = <pos>
	<highway_start_y> = (<highway_start_y> + (<pos_add> * 0.016683350016683352))
	<pos_add> = (<pos_add> * <pos_sub>)
	<pos_sub> = (<pos_sub> + <pos_sub_add>)
	if (<highway_start_y> <= <pos_start_orig>)
		<pos> = (((<container_pos>.(1.0, 0.0)) * (1.0, 0.0)) + (<pos_start_orig> * (0.0, 1.0)))
		setscreenelementprops id = <container_id> pos = <pos>
		break
	endif
	wait \{16.683350016683352
		milliseconds}
	repeat
endscript
