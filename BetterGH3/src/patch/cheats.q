// Allow hyperspeed saving
script toggle_hyperspeed 
	GetGlobalTags \{user_options}
	if ($<cheat> >= 0)
		if ($<cheat> = 5)
			new_value = 0
			Change GlobalName = <cheat> NewValue = <new_value>
			SetGlobalTags user_options Params = {Cheat_HyperSpeed = <new_value>}
			change \{options_autosave_required = 1}
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [<index>].name_text)
			setscreenelementprops id = <id> text = <text>
		else
			new_value = ($<cheat> + 1)
			Change GlobalName = <cheat> NewValue = ($<cheat> + 1)
			SetGlobalTags user_options Params = {Cheat_HyperSpeed = <new_value>}
			change \{options_autosave_required = 1}
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [<index>].name_text)
			formattext textname = text "%c, %d" c = <text> d = (<new_value>)
			setscreenelementprops id = <id> text = <text>
		endif
	endif
endscript

// Add new cheats
guitar_hero_cheats = [
	{
		name = airguitar
		name_text = $cheats_air_guitar
		var = cheat_airguitar
		unlock_pattern = [
			272
			65792
			65792
			4112
			4112
			4352
			4352
			272
			65792
			65792
			4112
			4112
			4352
			4352
			65792
			65792
			4352
			4352
		]
	}
	{
		name = performancemode
		name_text = $cheats_performance_mode
		var = cheat_performancemode
		unlock_pattern = [
			4352
			4112
			4097
			4112
			4352
			65552
			4352
			4112
		]
	}
	{
		name = hyperspeed
		name_text = $cheats_hyperspeed
		var = cheat_hyperspeed
		unlock_pattern = [
			1
			16
			1
			256
			1
			16
			1
			256
		]
	}
	{
		name = nofail
		name_text = $cheats_no_fail
		var = cheat_nofail
		unlock_pattern = [
			69632
			16
			69632
			65792
			16
			65792
			4352
			1
			4352
			65792
			256
			65792
			69632
		]
	}
	{
		name = easyexpert
		name_text = $cheats_easy_expert
		var = cheat_easyexpert
		unlock_pattern = [
			69632
			65792
			272
			4112
			17
			257
			4352
			4112
		]
	}
	{
		name = precisionmode
		name_text = $cheats_precision_mode
		var = cheat_precisionmode
		unlock_pattern = [
			69632
			69632
			69632
			4352
			4352
			4112
			4112
			272
			257
			257
			69632
			69632
			69632
			4352
			4352
			4112
			4112
			272
			257
			257
		]
	}
	{
		name = largegems
		name_text = $cheats_large_gems
		var = cheat_largegems
		unlock_pattern = [
			65536
			4096
			65536
			256
			65536
			16
			65536
			1
			65536
			16
			65536
			256
			65536
			4096
			65536
			69632
			4352
			69632
			272
			69632
			17
			69632
			272
			69632
			4352
			69632
			65792
		]
	}
	{
		name = bretmichaels
		name_text = $cheats_bret_michaels
		var = cheat_bretmichaels
		unlock_pattern = [
			69632
			69632
			69632
			65552
			65552
			65552
			4112
			4096
			4096
			4096
			4112
			4096
			4096
			4096
			4112
			4096
			4096
			4096
		]
	}
	{
		name = unlockall
		name_text = $cheats_unlocked_all_songs
		var = cheat_unlockall
		unlock_pattern = [
			257
			4112
			4097
			65552
			4352
			257
			4352
			4112
			65792
			65792
			272
			272
			257
			257
			272
			256
			4096
			4352
			4096
			256
			1
		]
	}
	{
		name = unlockalleverything
		name_text = $cheats_unlocked_everything
		var = cheat_unlockall_everything
		unlock_pattern = [
			69649
			69904
			69889
			65809
			69904
			4369
			69904
			65809
			69904
			69889
			69889
			69904
			69889
		]
	}
	{
		name = superuser
		name_text = $cheats_debug_mode_enabled
		var = cheat_superuser
		unlock_pattern = [
			69888
			4368
			273
		]
	}
	{
		name = viewercheat
		name_text = $cheats_viewer_launched
		var = cheat_viewer
		unlock_pattern = [
			273
			4368
			69888
		]
	}
]
guitar_hero_cheats_completed = [
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
]

script clear_cheats 
	change \{cheat_airguitar = -1}
	change \{cheat_hyperspeed = -1}
	change \{cheat_performancemode = -1}
	change \{cheat_nofail = -1}
	change \{cheat_easyexpert = -1}
	change \{cheat_precisionmode = -1}
	change \{cheat_largegems = -1}
	change \{cheat_bretmichaels = -1}
endscript

script writeperformance \{band_id = default_band_id
		venue = 'test venue'
		mode = 'test mode'
		submode = 'test submode'
		cheats = 'all cheats'
		title = 'killing me softly'
		difficulty = 'test'
		speed = 'test'
		star_power_available = 0
		player_id = 0
		part = 'guitar'
		score = 1
		stars = 0
		notes_hit = 2
		notes_missed = 0
		best_streak = 5
		star_power_achieved = 1
		lefty = true
		character_name = 'test'
		character_color = 1
		guitar = 'test'
		skin = 'test'
		outfit = 'test'}
	if ($cheat_airguitar = 1)
		air_guitar_active = air_guitar_active
	endif
	if ($cheat_performancemode = 1)
		performance_mode = performance_mode
	endif
	if ($cheat_hyperspeed > 0)
		hyper_speed = hyper_speed
	endif
	if ($cheat_nofail = 1)
		no_fail = no_fail
	endif
	if ($cheat_easyexpert = 1)
		easy_expert = easy_expert
	endif
	if ($cheat_precisionmode = 1)
		precision_mode = precision_mode
	endif
	if ($cheat_largegems = 1)
		large_gems = large_gems
	endif
	if ($cheat_bretmichaels = 1)
		bret_michaels = bret_michaels
	endif
	printf \{"WritePerformance"}
	netsessionfunc obj = stats func = write_performance params = {<...>}
endscript

script create_cheats_menu 
	disable_pause
	if ($entering_cheat = 0)
		createscreenelement \{type = containerelement
			id = cheats_container
			parent = root_window
			pos = (0.0, 0.0)}
		create_menu_backdrop \{texture = venue_bg}
		displaysprite \{parent = cheats_container
			tex = options_video_poster
			rot_angle = 1
			pos = (640.0, 215.0)
			dims = (820.0, 440.0)
			just = [
				center
				center
			]
			z = 1
			font = $video_settings_menu_font}
		displaytext \{parent = cheats_container
			pos = (910.0, 402.0)
			just = [
				right
				center
			]
			text = $cheats_cheats
			scale = 1.5
			rgba = [
				240
				235
				240
				255
			]
			font = text_a5
			noshadow}
		displaysprite \{parent = cheats_container
			tex = tape_h_03
			pos = (270.0, 185.0)
			rot_angle = -50
			scale = 0.5
			z = 20}
		displaysprite {
			parent = <id>
			tex = tape_h_03
			pos = (5.0, 5.0)
			rgba = [0 0 0 128]
			z = 19
		}
		displaysprite \{parent = cheats_container
			tex = tape_h_04
			pos = (930.0, 380.0)
			rot_angle = -120
			scale = 0.5
			z = 20}
		displaysprite {
			parent = <id>
			tex = tape_h_04
			pos = (5.0, 5.0)
			rgba = [0 0 0 128]
			z = 19
		}
		createscreenelement \{type = containerelement
			id = cheats_warning_container
			parent = root_window
			alpha = 0
			scale = 0.5
			pos = (640.0, 540.0)}
		displaysprite \{parent = cheats_warning_container
			id = cheats_warning
			tex = control_pill_body
			pos = (0.0, 0.0)
			just = [
				center
				center
			]
			rgba = [
				96
				0
				0
				255
			]
			z = 100}
		getplatform
		switch <platform>
			case xenon
			warning = $cheats_warning_career_modes
			warning_cont = $cheats_achievement_leaderboard_off
			case ps3
			warning = $cheats_warning_career_modes
			warning_cont = $cheats_leaderboard_off
			case ps2
			warning = $cheats_warning_some_cheats
			warning_cont = ""
			default
			warning = $cheats_warning_career_modes
			warning_cont = $cheats_leaderboard_off
		endswitch
		formattext textname = warning_text "%a %b" a = <warning> b = <warning_cont>
		createscreenelement {
			type = textblockelement
			id = first_warning
			parent = cheats_warning_container
			font = text_a6
			scale = 1
			text = <warning_text>
			rgba = [186 105 0 255]
			just = [center center]
			z_priority = 101.0
			pos = (0.0, 0.0)
			dims = (1400.0, 100.0)
			allow_expansion
		}
		getscreenelementdims \{id = first_warning}
		bg_dims = (<width> * (1.0, 0.0) + (<height> * (0.0, 1.0) + (0.0, 40.0)))
		cheats_warning :setprops dims = <bg_dims>
		displaysprite {
			parent = cheats_warning_container
			tex = control_pill_end
			pos = (-1 * <width> * (0.5, 0.0))
			rgba = [96 0 0 255]
			dims = ((64.0, 0.0) + (<height> * (0.0, 1.0) + (0.0, 40.0)))
			just = [right center]
			flip_v
			z = 100
		}
		displaysprite {
			parent = cheats_warning_container
			tex = control_pill_end
			pos = (<width> * (0.5, 0.0))
			rgba = [96 0 0 255]
			dims = ((64.0, 0.0) + (<height> * (0.0, 1.0) + (0.0, 40.0)))
			just = [left center]
			z = 100
		}
		cheats_create_guitar
	endif
	show_cheat_warning
	displaysprite \{parent = cheats_container
		id = cheats_hilite
		tex = white
		rgba = [
			40
			60
			110
			255
		]
		rot_angle = 1
		pos = (349.0, 382.0)
		dims = (230.0, 30.0)
		z = 2}
	new_menu \{scrollid = cheats_scroll
		vmenuid = cheats_vmenu
		menu_pos = (360.0, 168.0)
		text_left
		spacing = -12
		rot_angle = 1}
	text_params = {parent = cheats_vmenu type = textelement font = text_a3 rgba = [255 245 225 255] z_priority = 50 rot_angle = 0 scale = 1}
	text_params2 = {parent = cheats_vmenu type = textelement font = text_a5 rgba = [255 245 225 255] z_priority = 50 rot_angle = 0 scale = 0.63}
	getglobaltags \{user_options}
	<text> = $cheats_locked
	if (<unlock_cheat_nofail> > 0)
		if ($cheat_nofail = 1)
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [3].name_text)
		else
			if ($cheat_nofail < 0)
				change \{cheat_nofail = 2}
			endif
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [3].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = cheat_nofail_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 183.0) id = cheat_nofail_text}}
			{pad_choose toggle_cheat params = {cheat = cheat_nofail id = cheat_nofail_text index = 3}}
		]
	}
	<text> = $cheats_locked
	if (<unlock_cheat_airguitar> > 0)
		if ($cheat_airguitar = 1)
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [0].name_text)
		else
			if ($cheat_airguitar < 0)
				change \{cheat_airguitar = 2}
			endif
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [0].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = cheat_airguitar_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 206.0) id = cheat_airguitar_text}}
			{pad_choose toggle_cheat params = {cheat = cheat_airguitar id = cheat_airguitar_text index = 0}}
		]
	}
	<text> = $cheats_locked
	if (<unlock_cheat_hyperspeed> > 0)
		if ($cheat_hyperspeed > 0)
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [2].name_text)
			formattext textname = text "%c, %d" c = <text> d = ($cheat_hyperspeed)
		else
			if ($cheat_hyperspeed < 0)
				change \{cheat_hyperspeed = 0}
			endif
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [2].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = cheat_hyperspeed_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 229.0) id = cheat_hyperspeed_text}}
			{pad_choose toggle_hyperspeed params = {cheat = cheat_hyperspeed id = cheat_hyperspeed_text index = 2}}
		]
	}
	<text> = $cheats_locked
	if (<unlock_cheat_performancemode> > 0)
		if ($cheat_performancemode = 1)
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [1].name_text)
		else
			if ($cheat_performancemode < 0)
				change \{cheat_performancemode = 2}
			endif
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [1].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = cheat_performancemode_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 252.0) id = cheat_performancemode_text}}
			{pad_choose toggle_cheat params = {cheat = cheat_performancemode id = cheat_performancemode_text index = 1}}
		]
	}
	<text> = $cheats_locked
	if (<unlock_cheat_easyexpert> > 0)
		if ($cheat_easyexpert = 1)
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [4].name_text)
		else
			if ($cheat_easyexpert < 0)
				change \{cheat_easyexpert = 2}
			endif
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [4].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = cheat_easyexpert_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 275.0) id = cheat_easyexpert_text}}
			{pad_choose toggle_cheat params = {cheat = cheat_easyexpert id = cheat_easyexpert_text index = 4}}
		]
	}
	<text> = $cheats_locked
	if (<unlock_cheat_precisionmode> > 0)
		if ($cheat_precisionmode = 1)
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [5].name_text)
		else
			if ($cheat_precisionmode < 0)
				change \{cheat_precisionmode = 2}
			endif
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [5].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = cheat_precisionmode_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 298.0) id = cheat_precisionmode_text}}
			{pad_choose toggle_cheat params = {cheat = cheat_precisionmode id = cheat_precisionmode_text index = 5}}
		]
	}
	<text> = $cheats_locked
	if (<unlock_cheat_largegems> > 0)
		if ($cheat_largegems = 1)
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [6].name_text)
		else
			if ($cheat_largegems < 0)
				change \{cheat_largegems = 2}
			endif
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [6].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = cheat_largegems_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 321.0) id = cheat_largegems_text}}
			{pad_choose toggle_cheat params = {cheat = cheat_largegems id = cheat_largegems_text index = 6}}
		]
	}
	<text> = $cheats_locked
	if (<unlock_cheat_bretmichaels> > 0)
		if ($cheat_bretmichaels = 1)
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [7].name_text)
		else
			if ($cheat_bretmichaels < 0)
				change \{cheat_bretmichaels = 2}
			endif
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [7].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = cheat_bretmichaels_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 344.0) id = cheat_bretmichaels_text}}
			{pad_choose toggle_cheat params = {cheat = cheat_bretmichaels id = cheat_bretmichaels_text index = 7}}
		]
	}
	createscreenelement {
		<text_params>
		text = $cheats_enter_cheat
		id = cheat_entercheat_text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 375.0) id = cheat_entercheat_text}}
			{pad_choose enter_new_cheat}
		]
	}
	clean_up_user_control_helpers
	change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	add_user_control_helper \{text = $buttons_select
		button = green
		z = 100}
	add_user_control_helper \{text = $buttons_back
		button = red
		z = 100}
	add_user_control_helper \{text = $buttons_up_down
		button = strumbar
		z = 100}
	change \{entering_cheat = 0}
	change \{guitar_hero_cheats_completed = [
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
		]}
endscript

script updateunlockedcheats 
	if ($cheat_airguitar > 0)
		setglobaltags \{user_options
			params = {
				unlock_cheat_airguitar = 1
			}}
	endif
	if ($cheat_performancemode > 0)
		setglobaltags \{user_options
			params = {
				unlock_cheat_performancemode = 1
			}}
	endif
	if ($cheat_hyperspeed > 0)
		setglobaltags \{user_options
			params = {
				unlock_cheat_hyperspeed = 1
			}}
	endif
	if ($cheat_nofail > 0)
		setglobaltags \{user_options
			params = {
				unlock_cheat_nofail = 1
			}}
	endif
	if ($cheat_easyexpert > 0)
		setglobaltags \{user_options
			params = {
				unlock_cheat_easyexpert = 1
			}}
	endif
	if ($cheat_precisionmode > 0)
		setglobaltags \{user_options
			params = {
				unlock_cheat_precisionmode = 1
			}}
	endif
	if ($cheat_largegems > 0)
		setglobaltags \{user_options
			params = {
				unlock_cheat_largegems = 1
			}}
	endif
	if ($cheat_bretmichaels > 0)
		setglobaltags \{user_options
			params = {
				unlock_cheat_bretmichaels = 1
			}}
	endif
endscript

script unlock_cheat
	change \{options_autosave_required = 1}
	if (<cheat> = cheat_superuser)
		change \{enable_button_cheats = 1}
		soundevent \{event = crowd_oneshots_cheer_close}
		spawnscriptnow cheat_award_text params = {index = <index> show_unlock = 0}
		return
	endif
	if (<cheat> = cheat_viewer)
		launchviewer
		change \{select_shift = 1}
		soundevent \{event = crowd_oneshots_cheer_close}
		spawnscriptnow cheat_award_text params = {index = <index> show_unlock = 0}
		return
	endif
	if (<cheat> = cheat_unlockall)
		globaltags_unlockall \{songlist = gh3_general_songs
			songs_only = 1}
		globaltags_unlockall \{songlist = gh3_generalp2_songs
			songs_only = 1}
		globaltags_unlockall \{songlist = gh3_bonus_songs
			songs_only = 1}
		getarraysize ($gh3_bonus_songs.tier1.songs)
		i = 0
		begin
		setglobaltags ($gh3_bonus_songs.tier1.songs [<i>]) params = {unlocked = 1}
		<i> = (<i> + 1)
		repeat <array_size>
		soundevent \{event = crowd_oneshots_cheer_close}
		spawnscriptnow cheat_award_text params = {index = <index> show_unlock = 0}
		return
	endif
	if (<cheat> = cheat_unlockall_everything)
		globaltags_unlockall \{songlist = gh3_general_songs}
		globaltags_unlockall \{songlist = gh3_generalp2_songs}
		globaltags_unlockall \{songlist = gh3_bonus_songs}
		getarraysize ($gh3_bonus_songs.tier1.songs)
		i = 0
		begin
		setglobaltags ($gh3_bonus_songs.tier1.songs [<i>]) params = {unlocked = 1}
		<i> = (<i> + 1)
		repeat <array_size>
		soundevent \{event = crowd_oneshots_cheer_close}
		spawnscriptnow cheat_award_text params = {index = <index> show_unlock = 0}
		return
	endif
	if (<cheat> = cheat_easyexpert)
		if NOT ($cheat_precisionmode = 1)
			change \{check_time_early = $original_check_time_early}
			change \{check_time_late = $original_check_time_late}
		endif
	endif
	if (<cheat> = cheat_precisionmode)
		if NOT ($cheat_easyexpert = 1)
			change \{check_time_early = $original_check_time_early}
			change \{check_time_late = $original_check_time_late}
		endif
	endif
	if NOT (<cheat> > 0)
		soundevent \{event = crowd_oneshots_cheer_close}
		change globalname = <cheat> newvalue = 2
		updateunlockedcheats
		spawnscriptnow cheat_award_text params = {index = <index>}
	endif
endscript

script toggle_cheat 
	if ($<cheat> > 0)
		if ($<cheat> = 1)
			change globalname = <cheat> newvalue = 2
			formattext textname = text $cheats_off c = ($guitar_hero_cheats [<index>].name_text)
			setscreenelementprops id = <id> text = <text>
			if ($cheat_easyexpert = 2 || $cheat_precisionmode = 2)
				change \{check_time_early = $original_check_time_early}
				change \{check_time_late = $original_check_time_late}
			endif
			if ($cheat_largegems = 2)
				change \{gem_start_scale1 = 0.25}
				change \{gem_end_scale1 = 0.8}
				change \{gem_start_scale2 = 0.27}
				change \{gem_end_scale2 = 0.8}
				change \{whammy_top_width1 = 10.0}
				change \{whammy_top_width2 = 9.2}
			endif
		else
			change globalname = <cheat> newvalue = 1
			formattext textname = text $cheats_on c = ($guitar_hero_cheats [<index>].name_text)
			turnon_cheat = ($guitar_hero_cheats [<index>].name)
			setscreenelementprops id = <id> text = <text>
			if (<turnon_cheat> = easyexpert)
				change check_time_early = ($original_check_time_early * 2)
				change check_time_late = ($original_check_time_late * 2)
				if ($cheat_precisionmode = 1)
					formattext textname = text $cheats_off c = ($guitar_hero_cheats [5].name_text)
					change \{globalname = cheat_precisionmode
						newvalue = 2}
					setscreenelementprops id = cheat_precisionmode_text text = <text>
				endif
			endif
			if (<turnon_cheat> = precisionmode)
				change check_time_early = ($original_check_time_early / 2)
				change check_time_late = ($original_check_time_late / 2)
				if ($cheat_easyexpert = 1)
					formattext textname = text $cheats_off c = ($guitar_hero_cheats [4].name_text)
					change \{globalname = cheat_easyexpert
						newvalue = 2}
					setscreenelementprops id = cheat_easyexpert_text text = <text>
				endif
			endif
			if (<turnon_cheat> = largegems)
				change gem_start_scale1 = (0.5)
				change gem_end_scale1 = (1.6)
				change gem_start_scale2 = (0.54)
				change gem_end_scale2 = (1.6)
				change whammy_top_width1 = (20.0)
				change whammy_top_width2 = (18.4)
			endif
		endif
	else
		setscreenelementprops id = <id> text = $cheats_locked
	endif
	show_cheat_warning
endscript
