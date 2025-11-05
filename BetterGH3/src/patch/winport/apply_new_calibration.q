script start_gem_scroller \{starttime = 0
		practice_intro = 0
		training_mode = 0
		endtime = 99999999
		devil_finish_restart = 0
		end_credits_restart = 0}
	if (<devil_finish_restart> = 1)
		printf \{"FINISH DEVIL RESTART"}
	else
		change \{devil_finish = 0}
		if ($current_song = bossdevil)
			<starttime> = 0
		endif
	endif
	if (<end_credits_restart> = 1)
		printf \{"END CREDITS RESTART"}
	else
		if NOT ($current_song = thrufireandflames)
			change \{end_credits = 0}
		endif
	endif
	change \{playing_song = 1}
	mark_unsafe_for_shutdown
	dragonforce_hack_off
	menu_music_off
	guitarevent_entervenue
	init_play_log
	load_songqpak song_name = <song_name> async = 1
	if iswinport
		// Use new offsets
		change \{default_gem_offset = $winport_gem_offset}
		change \{default_input_offset = $winport_input_offset}
		change \{default_drums_offset = $winport_drums_offset}
		change \{default_practice_mode_audio_offset = $winport_practice_mode_audio_offset}
		change \{default_practice_mode_pitchshift_offset_song = $winport_practice_mode_pitchshift_offset_song}
	else
		if isxenon
			change \{default_gem_offset = $xenon_gem_offset}
			change \{default_input_offset = $xenon_input_offset}
			change \{default_drums_offset = $xenon_drums_offset}
			change \{default_practice_mode_pitchshift_offset_song = $xenon_practice_mode_pitchshift_offset_song}
		else
			if isps3
				change \{default_gem_offset = $ps3_gem_offset}
				change \{default_input_offset = $ps3_input_offset}
				change \{default_drums_offset = $ps3_drums_offset}
				change \{default_practice_mode_pitchshift_offset_song = $ps3_practice_mode_pitchshift_offset_song}
			else
				change \{default_gem_offset = $ps2_gem_offset}
				change \{default_input_offset = $ps2_input_offset}
				change \{default_drums_offset = $ps2_drums_offset}
				change \{default_practice_mode_pitchshift_offset_song = $ps2_practice_mode_pitchshift_offset_song}
			endif
		endif
	endif
	begin_singleplayer_game
	get_song_struct song = <song_name>
	if structurecontains structure = <song_struct> boss
		<difficulty2> = <difficulty>
	endif
	change current_song = <song_name>
	change current_difficulty = <difficulty>
	change current_difficulty2 = <difficulty2>
	change current_starttime = <starttime>
	change current_endtime = <endtime>
	change \{boss_play = 0}
	change \{showing_raise_axe = 0}
	progression_setprogressionnodeflags
	get_song_struct song = <song_name>
	if structurecontains structure = <song_struct> boss
		change current_boss = (<song_struct>.boss)
		change \{boss_battle = 1}
		change \{current_num_players = 2}
		change boss_oldcontroller = ($player2_status.controller)
		getinputhandlerbotindex \{player = 2}
		change structurename = player2_status controller = <controller>
		if structurecontains \{structure = $current_boss
				name = character_profile}
			profile = ($current_boss.character_profile)
			change structurename = player2_status character_id = <profile>
			change \{structurename = player2_status
				outfit = 1}
			change \{structurename = player2_status
				style = 1}
		endif
		printf \{channel = log
			"Starting bot for boss"}
	else
		if (($player2_status.bot_play = 1) || ($new_net_logic))
			change boss_oldcontroller = ($player2_status.controller)
			getinputhandlerbotindex \{player = 2}
			change structurename = player2_status controller = <controller>
			printf \{channel = log
				"Starting bot for player 2"}
		endif
	endif
	if ($player1_status.bot_play = 1)
		getinputhandlerbotindex \{player = 1}
		change structurename = player1_status controller = <controller>
		printf \{channel = log
			"Starting bot for player 1"}
	endif
	if ($game_mode = p2_battle)
		printf \{"Initiating Battlemode"}
		battlemode_init
	endif
	if ($boss_battle = 1)
		printf \{"Initiating BossBattle"}
		bossbattle_init
	endif
	if ($new_net_logic)
		new_net_logic_init
	endif
	printf \{"-------------------------------------"}
	printf \{"-------------------------------------"}
	printf \{"-------------------------------------"}
	printf \{"Now playing %s %d"
		s = $current_song
		d = $current_difficulty}
	printf \{"-------------------------------------"}
	printf \{"-------------------------------------"}
	printf \{"-------------------------------------"}
	song_start_time = <starttime>
	call_startup_scripts <...>
	setup_bg_viewport
	create_cameracuts <...>
	starttimeafterintro = <starttime>
	printf "Current Transition = %s" s = ($current_transition)
	if ($current_transition = none)
		change \{current_transition = fastintro}
	endif
	transition_gettime type = ($current_transition)
	starttime = (<starttime> - <transition_time>)
	setslomo \{0.001}
	reset_song_time starttime = <starttime>
	if NOT ($use_character_debug_cam = 1)
	endif
	create_movie_viewport
	create_crowd_models
	crowd_create_lighters
	crowd_stagediver_hide
	change \{structurename = guitarist_info
		stance = stance_a}
	change \{structurename = guitarist_info
		next_stance = stance_a}
	change \{structurename = guitarist_info
		current_anim = idle}
	change \{structurename = guitarist_info
		cycle_anim = true}
	change \{structurename = guitarist_info
		next_anim = none}
	change \{structurename = guitarist_info
		playing_missed_note = false}
	change \{structurename = guitarist_info
		waiting_for_cameracut = false}
	change \{structurename = bassist_info
		stance = stance_a}
	change \{structurename = bassist_info
		next_stance = stance_a}
	change \{structurename = bassist_info
		current_anim = idle}
	change \{structurename = bassist_info
		cycle_anim = true}
	change \{structurename = bassist_info
		next_anim = none}
	change \{structurename = bassist_info
		playing_missed_note = false}
	change \{structurename = bassist_info
		waiting_for_cameracut = false}
	change \{structurename = vocalist_info
		stance = stance_a}
	change \{structurename = vocalist_info
		next_stance = stance_a}
	change \{structurename = vocalist_info
		current_anim = idle}
	change \{structurename = vocalist_info
		cycle_anim = true}
	change \{structurename = vocalist_info
		next_anim = none}
	change \{structurename = drummer_info
		stance = stance_a}
	change \{structurename = drummer_info
		next_stance = stance_a}
	change \{structurename = drummer_info
		current_anim = idle}
	change \{structurename = drummer_info
		cycle_anim = true}
	change \{structurename = drummer_info
		next_anim = none}
	change \{structurename = drummer_info
		twist = 0.0}
	change \{structurename = drummer_info
		desired_twist = 0.0}
	change \{structurename = drummer_info
		last_left_arm_note = 0}
	change \{structurename = drummer_info
		last_right_arm_note = 0}
	if (<training_mode> = 0)
		if NOT create_band \{async = 1}
			downloadcontentlost
		endif
	endif
	if ($game_mode = training)
		practicemode_init
	endif
	preload_song song_name = <song_name> starttime = <song_start_time>
	calc_score = true
	if NOT (<devil_finish_restart> = 1 || $end_credits = 1)
		if ($use_last_player_scores = 0)
			reset_score \{player_status = player1_status}
		else
			change \{use_last_player_scores = 0}
			<calc_score> = false
		endif
	endif
	reset_score \{player_status = player2_status}
	getglobaltags \{user_options}
	setarrayelement \{arrayname = currently_holding
		globalarray
		index = 0
		newvalue = 0}
	setarrayelement \{arrayname = currently_holding
		globalarray
		index = 1
		newvalue = 0}
	player = 1
	begin
	if (<player> = 2)
		if gotparam \{difficulty2}
			<difficulty> = <difficulty2>
		endif
	endif
	formattext checksumname = player_status 'player%i_status' i = <player> addtostringlookup
	formattext textname = player_text 'p%i' i = <player> addtostringlookup
	change structurename = <player_status> guitar_volume = 0
	updateguitarvolume
	getglobaltags \{user_options}
	if (<player> = 1)
		change structurename = <player_status> lefthanded_gems = (<lefty_flip_p1>)
		change structurename = <player_status> lefthanded_button_ups = (<lefty_flip_p1>)
	else
		if ($is_network_game = 0)
			change structurename = <player_status> lefthanded_gems = (<lefty_flip_p2>)
			change structurename = <player_status> lefthanded_button_ups = (<lefty_flip_p2>)
		endif
	endif
	get_resting_whammy_position controller = ($<player_status>.controller)
	if gotparam \{resting_whammy_position}
		change structurename = <player_status> resting_whammy_position = <resting_whammy_position>
	endif
	get_star_power_position controller = ($<player_status>.controller)
	if gotparam \{star_power_position}
		change structurename = <player_status> star_tilt_threshold = <star_power_position>
	endif
	if ($tutorial_disable_hud = 0)
		setup_hud <...>
	endif
	if ($output_gpu_log = 1)
		textoutputstart
	endif
	if NOT gotparam \{no_score_update}
		spawnscriptlater update_score_fast params = {<...>}
	endif
	if (($is_network_game) && ($player1_status.highway_layout = solo_highway))
		spawnscriptlater \{update_score_fast
			params = {
				player_status = player2_status
			}}
	endif
	if (<training_mode> = 0)
		if NOT (<devil_finish_restart> = 1)
			crowd_reset <...>
		endif
	endif
	star_power_reset <...>
	difficulty_setup <...>
	setup_highway <...>
	if (<training_mode> = 0)
		reset_hud <...>
	endif
	spawnscriptnow gem_scroller params = {<...>}
	if ((<player> = 1) || ($new_net_logic) || ($is_network_game = 0))
		spawnscriptnow button_checker params = {<...>}
	endif
	if NOT (($is_network_game) && (<player> = 2))
		spawnscriptlater check_for_star_power params = {<...>}
	endif
	if (<calc_score> = true)
		calc_songscoreinfo player_status = <player_status>
	endif
	player = (<player> + 1)
	repeat $current_num_players
	getpakmancurrent \{map = zones}
	if ($boss_battle = 1)
		if should_play_boss_intro
			if ($current_transition = boss)
				gh_sfx_preload_boss_intro_audio
			endif
		endif
	endif
	gh3_set_guitar_verb_and_echo_to_dry
	transition_play type = ($current_transition)
	change \{current_transition = none}
	change \{check_for_unplugged_controllers = 1}
	wait \{1
		gameframe}
	if ($is_network_game)
		syncandlaunchnetgame
		begin
		if (($net_ready_to_start) || ($player2_present = 0))
			ui_flow_manager_respond_to_action \{action = net_begin_song}
			ui_print_gamertags \{pos1 = (365.0, 50.0)
				pos2 = (940.0, 50.0)
				dims = (310.0, 25.0)
				just1 = [
					center
					top
				]
				just2 = [
					center
					top
				]
				offscreen = 1}
			break
		endif
		wait \{1
			gameframe}
		repeat
	endif
	stoprendering
	destroy_loading_screen
	setslomo \{$current_speedfactor}
	if (($player2_present = 0) && ($is_network_game = 1))
		if NOT ((screenelementexists id = net_popup_container) || (scriptisrunning create_connection_lost_dialog))
			spawnscriptnow \{create_connection_lost_dialog}
		endif
	endif
	spawnscriptnow begin_song_after_intro params = {starttimeafterintro = <starttimeafterintro>}
	if ($boss_battle = 1)
		if ($show_boss_helper_screen = 1)
			disable_bg_viewport
			if screenelementexists \{id = battlemode_container}
				battlemode_container :setprops \{alpha = 0}
			endif
			getpakmancurrent \{map = zones}
			if should_play_boss_intro
				spawnscriptnow \{wait_and_show_boss_helper_after_intro}
			else
				spawnscriptlater \{show_boss_helper_now}
			endif
		else
			enable_bg_viewport
		endif
	endif
	mark_safe_for_shutdown
endscript

script gem_scroller \{player = 1
		training_mode = 0}
	setup_gemarrays song_name = <song_name> difficulty = <difficulty> player_status = <player_status>
	calc_health_invincible_time song = <song_name> player_status = <player_status>
	if ($cheat_easyexpert = 1)
		if ($is_network_game || $game_mode = p1_career || $game_mode = p2_coop)
			change \{check_time_early = $original_check_time_early}
			change \{check_time_late = $original_check_time_late}
		endif
	endif
	if ($cheat_precisionmode = 1)
		if ($is_network_game)
			change \{check_time_early = $original_check_time_early}
			change \{check_time_late = $original_check_time_late}
		endif
	endif
	change structurename = <player_status> check_time_early = ($check_time_early * $current_speedfactor)
	change structurename = <player_status> check_time_late = ($check_time_late * $current_speedfactor)
	formattext checksumname = input_array 'input_array%p' p = <player_text>
	printf \{"-----------------------------------"}
	printf \{"-----------------------------------"}
	printf \{"-----------------------------------"}
	printf \{"-----------------------------------"}
	printf \{"-----------------------------------"}
	printf "Creating array for %p" p = <player_text>
	printf \{"-----------------------------------"}
	printf \{"-----------------------------------"}
	printf \{"-----------------------------------"}
	printf \{"-----------------------------------"}
	printf \{"-----------------------------------"}
	inputarraycreate name = <input_array>
	if (<player> = 1)
		if ($input_mode = record)
			cleardatabuffer \{name = replay}
			databufferputchecksum name = replay value = <song_name>
			databufferputchecksum name = replay value = ($current_transition)
			databufferputint \{name = replay
				value = $current_num_players}
			databufferputint name = replay value = ($player1_status.controller)
			databufferputint name = replay value = ($player2_status.controller)
			databufferputchecksum name = replay value = <difficulty> bytes = 16
			databufferputchecksum name = replay value = <difficulty2> bytes = 16
			getrandomseeds
			databufferputint name = replay value = <seed1>
			databufferputint name = replay value = <seed2>
			databufferputint name = replay value = <seed3>
			databufferputint name = replay value = <seed4>
			databufferputint name = replay value = <seed5>
			databufferputint name = replay value = <seed6>
		endif
	endif
	<gem_offset> = ($time_gem_offset)
	<input_offset> = ($time_input_offset)

	// Apply new audio/video calibration
	getglobaltags \{user_options}
	<gem_offset> = (<gem_offset> - <lag_audio> + <lag_video>)
	<input_offset> = (<input_offset> - <lag_audio>)
	change default_drums_offset = ($default_drums_offset + <lag_audio>)

	if (<training_mode> = 0)
		spawnscriptlater strum_iterator params = {song_name = <song_name> difficulty = expert
			time_offset = (<gem_offset> + $strum_anim_lead_time) skipleadin = 0
			part = <part> target = (<player_status>.band_member)}
		spawnscriptlater fretfingers_iterator params = {song_name = <song_name> difficulty = expert
			time_offset = (<gem_offset> + $strum_anim_lead_time) skipleadin = 0
			part = <part> target = (<player_status>.band_member)}
		spawnscriptlater fretpos_iterator params = {song_name = <song_name>
			time_offset = (<gem_offset> + $strum_anim_lead_time) skipleadin = 0
			part = ($<player_status>.part) target = (<player_status>.band_member)}
		if (<player> = 1)
			spawnscriptlater drum_iterator params = {song_name = <song_name> difficulty = <difficulty>
				time_offset = (<gem_offset> + $drum_anim_lead_time) skipleadin = 0
				player = <player> player_status = <player_status> player_text = <player_text>}
			spawnscriptlater drum_cymbal_iterator params = {song_name = <song_name> difficulty = <difficulty>
				time_offset = <gem_offset> skipleadin = 0
				player = <player> player_status = <player_status> player_text = <player_text>}
			if ($current_num_players = 1)
				bassist_song_part = 'rhythm_'
				bassist_part = rhythm
				get_song_struct song = <song_name>
				if structurecontains structure = <song_struct> name = bassist
					if ((<song_struct>.bassist = 'Morello') || (<song_struct>.bassist = 'slash'))
						bassist_song_part = ''
						bassist_part = guitar
					endif
				endif
				spawnscriptlater strum_iterator params = {song_name = <song_name> difficulty = expert
					time_offset = (<gem_offset> + $strum_anim_lead_time) skipleadin = 0
					part = <bassist_song_part> target = bassist}
				spawnscriptlater fretfingers_iterator params = {song_name = <song_name> difficulty = expert
					time_offset = (<gem_offset> + $strum_anim_lead_time) skipleadin = 0
					part = <bassist_song_part> target = bassist}
				spawnscriptlater fretpos_iterator params = {song_name = <song_name> difficulty = <difficulty>
					time_offset = (<gem_offset> + $strum_anim_lead_time) skipleadin = 0
					part = <bassist_part> target = bassist}
			endif
		endif
	endif
	formattext checksumname = input_array 'input_array%p' p = <player_text>
	spawnscriptlater gem_iterator params = {iterator_text = 'fill_array' song_name = <song_name> difficulty = <difficulty> part = <part> input_array = <input_array>
		time_offset = ((($<player_status>.scroll_time - $destroy_time) * 1000.0) + <gem_offset> + 1000.0) strum_function = fill_input_array skipleadin = ($<player_status>.scroll_time * 1000.0)
		player = <player> player_status = <player_status> player_text = <player_text>}
	if ($game_mode = p2_faceoff)
		spawnscriptlater faceoff_init params = {song_name = <song_name> difficulty = <difficulty> part = <part>
			time_offset = ((($<player_status>.scroll_time - $destroy_time) * 1000.0) + <gem_offset> + 1000.0) skipleadin = ($<player_status>.scroll_time * 1000.0)
			player = <player> player_status = <player_status> player_text = <player_text>}
		spawnscriptlater faceoff_volumes_init params = {song_name = <song_name> difficulty = <difficulty> part = <part>
			time_offset = ((($<player_status>.check_time_early) * 1000.0) + <input_offset>) skipleadin = ($<player_status>.scroll_time * 1000.0)
			player = <player> player_status = <player_status> player_text = <player_text>}
	endif
	<do_bot> = 0
	if ($boss_battle = 1)
		if (<player> = 2)
			formattext checksumname = bossresponse_array 'bossresponse_array%p' p = <player_text>
			inputarraycreate name = <bossresponse_array>
			spawnscriptlater gem_iterator params = {iterator_text = 'fill_bossarray' song_name = <song_name> difficulty = <difficulty> part = <part> input_array = <bossresponse_array>
				time_offset = ((($<player_status>.scroll_time - $destroy_time) * 1000.0) + <gem_offset> + 1000.0) strum_function = fill_input_array skipleadin = ($<player_status>.scroll_time * 1000.0)
				player = <player> player_status = <player_status> player_text = <player_text>}
			spawnscriptlater gem_iterator params = {iterator_text = 'boss' song_name = <song_name> difficulty = <difficulty> part = <part> use_input_array = 'bossresponse_array'
				time_offset = ((($<player_status>.check_time_early) * 1000.0) + <input_offset>) strum_function = check_buttons_boss skipleadin = ($<player_status>.scroll_time * 1000.0)
				player = <player> player_status = <player_status> player_text = <player_text>}
		elseif ($<player_status>.bot_play = 1)
			<do_bot> = 1
		endif
	elseif ($<player_status>.bot_play = 1)
		<do_bot> = 1
	endif
	if (<do_bot> = 1)
		spawnscriptlater gem_iterator params = {iterator_text = 'bot' song_name = <song_name> difficulty = <difficulty> part = <part> use_input_array = 'input_array' one_event_per_frame
			time_offset = ((($<player_status>.check_time_early) * 1000.0) + <input_offset>) strum_function = check_buttons_bot skipleadin = ($<player_status>.scroll_time * 1000.0)
			player = <player> player_status = <player_status> player_text = <player_text>}
		printf \{channel = log
			"Spawned bot!"}
	endif
	if ($new_net_logic)
		if (<player> = 2)
			formattext checksumname = bossresponse_array 'bossresponse_array%p' p = <player_text>
			inputarraycreate name = <bossresponse_array>
			spawnscriptlater gem_iterator params = {iterator_text = 'fill_bossarray' song_name = <song_name> difficulty = <difficulty> part = <part> input_array = <bossresponse_array>
				time_offset = ((($<player_status>.scroll_time - $destroy_time) * 1000.0) + <gem_offset> + 1000.0) strum_function = fill_input_array skipleadin = ($<player_status>.scroll_time * 1000.0)
				player = <player> player_status = <player_status> player_text = <player_text>}
			spawnscriptlater gem_iterator params = {iterator_text = 'boss' song_name = <song_name> difficulty = <difficulty> part = <part> use_input_array = 'bossresponse_array'
				time_offset = ((($<player_status>.check_time_early) * 1000.0) + <input_offset>) strum_function = check_buttons_boss skipleadin = ($<player_status>.scroll_time * 1000.0)
				player = <player> player_status = <player_status> player_text = <player_text>}
		endif
	endif
	spawnscriptlater fretbar_iterator params = {song_name = <song_name> difficulty = <difficulty> thin_fretbars
		time_offset = ((($<player_status>.scroll_time - $destroy_time) * 1000.0) + <gem_offset>) fretbar_function = create_fretbar skipleadin = ($<player_status>.scroll_time * 1000.0)
		player = <player> player_status = <player_status> player_text = <player_text>}
	spawnscriptlater gem_iterator params = {iterator_text = 'create_gem' song_name = <song_name> difficulty = <difficulty> part = <part> use_input_array = 'input_array'
		time_offset = ((($<player_status>.scroll_time - $destroy_time) * 1000.0) + <gem_offset>) gem_function = create_gem skipleadin = ($<player_status>.scroll_time * 1000.0)
		player = <player> player_status = <player_status> player_text = <player_text>}
	if ((<player_status>.is_local_client) || ($new_net_logic))
		spawnscriptlater check_buttons_fast params = {song_name = <song_name> difficulty = <difficulty>
			time_offset = ((($<player_status>.check_time_early) * 1000.0) + <input_offset>) player = <player>
			player_status = <player_status> player_text = <player_text>}
	else
		spawnscriptlater net_check_buttons params = {song_name = <song_name> player_status = <player_status>
			time_offset = ((($<player_status>.check_time_early) * 1000.0) + <input_offset>)}
	endif
	spawnscriptlater fretbar_update_tempo params = {song_name = <song_name> difficulty = <difficulty>
		time_offset = ((($<player_status>.check_time_early) * 1000.0) + <gem_offset>) player = <player> skipleadin = ($<player_status>.scroll_time * 1000.0)
		player_status = <player_status> player_text = <player_text>}
	spawnscriptlater fretbar_update_hammer_on_tolerance params = {song_name = <song_name> difficulty = <difficulty>
		time_offset = ((($<player_status>.scroll_time - $destroy_time) * 1000.0) + <gem_offset> + 1000.0) player = <player> skipleadin = ($<player_status>.scroll_time * 1000.0)
		player_status = <player_status> player_text = <player_text>}
	if (<player> = 1)
		if ($is_network_game)
			spawnscriptlater dispatch_player_state params = {player_status = <player_status>}
			spawnscriptlater \{network_events}
		endif
		spawnscriptlater fretbar_iterator params = {song_name = <song_name> difficulty = <difficulty>
			time_offset = (($prefretbar_time * 1000.0) + <gem_offset>) fretbar_function = guitarevent_prefretbar skipleadin = 0
			player = <player> player_status = <player_status> player_text = <player_text>}
		spawnscriptlater fretbar_iterator params = {song_name = <song_name> difficulty = <difficulty>
			time_offset = <gem_offset> fretbar_function = guitarevent_fretbar skipleadin = 0
			player = <player> player_status = <player_status> player_text = <player_text>}
		if ($debug_audible_downbeat = 1)
			spawnscriptlater fretbar_iterator params = {song_name = <song_name> difficulty = <difficulty>
				time_offset = (<gem_offset> + ($check_time_early * 1000.0)) fretbar_function = guitarevent_fretbar_early skipleadin = 0
				player = <player> player_status = <player_status> player_text = <player_text>}
			spawnscriptlater fretbar_iterator params = {song_name = <song_name> difficulty = <difficulty>
				time_offset = (<gem_offset> - ($check_time_late * 1000.0)) fretbar_function = guitarevent_fretbar_late skipleadin = 0
				player = <player> player_status = <player_status> player_text = <player_text>}
		endif
		spawnscriptlater lightshow_iterator params = {song_name = <song_name> time_offset = (<gem_offset> + $lightshow_offset_ms) skipleadin = 0}
		spawnscriptlater cameracuts_iterator params = {song_name = <song_name> time_offset = <gem_offset> skipleadin = 0}
		getarraysize \{$scripts_array}
		array_count = 0
		begin
		<lead_ms> = ($scripts_array [<array_count>].lead_ms)
		spawnscriptlater event_iterator params = {song_name = <song_name> difficulty = <difficulty>
			event_string = ($scripts_array [<array_count>].name) time_offset = (<gem_offset> + <lead_ms>) skipleadin = 0
			player = <player> player_status = <player_status> player_text = <player_text>}
		spawnscriptlater notemap_startiterator params = {song_name = <song_name> difficulty = <difficulty>
			event_string = ($scripts_array [<array_count>].name) time_offset = (<gem_offset> + <lead_ms>) skipleadin = 0
			player = <player> player_status = <player_status> player_text = <player_text>}
		array_count = (<array_count> + 1)
		repeat <array_size>
	endif
	spawnscriptlater win_song params = {<...>}
endscript

script call_startup_scripts 
	change \{current_startup_script = default_startup}
	change \{time_gem_offset = $default_gem_offset}
	getglobaltags \{user_options}
	change \{time_input_offset = $default_input_offset}
	get_song_struct song = <song_name>
	if structurecontains structure = <song_struct> name = startup_script
		change current_startup_script = (<song_struct>.startup_script)
	endif
	if structurecontains structure = <song_struct> name = exit_script
		change current_exit_script = (<song_struct>.exit_script)
	else
	endif
	if structurecontains structure = <song_struct> name = gem_offset
		change time_gem_offset = ($time_gem_offset + (<song_struct>.gem_offset))
	endif
	if structurecontains structure = <song_struct> name = input_offset
		change time_input_offset = ($time_input_offset + (<song_struct>.input_offset))
	endif
	if structurecontains structure = <song_struct> name = hammer_on_measure_scale
		change hammer_on_measure_scale = (<song_struct>.hammer_on_measure_scale)
	else
		change \{hammer_on_measure_scale = $default_hammer_on_measure_scale}
	endif
	if ($game_mode = training && $in_menu_choose_practice_section = 0)
		change time_gem_offset = ($time_gem_offset + ($default_practice_mode_audio_offset / $current_speedfactor))
		change time_input_offset = ($time_input_offset + ($default_practice_mode_audio_offset / $current_speedfactor))
		change default_drums_offset = ($default_drums_offset - ($default_practice_mode_audio_offset / $current_speedfactor))
	endif
	spawnscriptnow ($current_startup_script) params = {<...>}
endscript
