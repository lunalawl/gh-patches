// Don't automatically enable lefty on keyboard, also don't show battery on laptops
script create_main_menu
	change \{options_autosave_required = 0}
	if iswinport
		shut_down_net_play
		if ($main_menu_created = 0)
			guitarcount = 0
			if isguitarcontroller \{controller = 0}
				guitarcount = (<guitarcount> + 1)
			endif
			if isguitarcontroller \{controller = 1}
				guitarcount = (<guitarcount> + 1)
			endif
			if isguitarcontroller \{controller = 2}
				guitarcount = (<guitarcount> + 1)
			endif
		endif
	endif
	change \{winport_is_in_online_menu_system = 0}
	change \{main_menu_created = 1}
	getglobaltags \{user_options}
	menu_audio_settings_update_guitar_volume vol = <guitar_volume>
	menu_audio_settings_update_band_volume vol = <band_volume>
	menu_audio_settings_update_sfx_volume vol = <sfx_volume>
	setsoundbussparams {crowd = {vol = ($default_bussset.crowd.vol)}}
	if ($main_menu_movie_first_time = 0)
		fadetoblack \{on
			time = 0
			alpha = 1.0
			z_priority = 900}
	endif
	create_main_menu_backdrop
	if ($main_menu_movie_first_time = 0 && $invite_controller = -1)
		playmovieandwait \{movie = 'GH3_Intro'
			noblack
			noletterbox}
		change \{main_menu_movie_first_time = 1}
		fadetoblack \{off
			time = 0}
	endif
	setmenuautorepeattimes \{(0.3, 0.05)}
	kill_start_key_binding
	unpausegame
	change \{current_num_players = 1}
	change structurename = player1_status controller = ($primary_controller)
	change \{player_controls_valid = 0}
	disable_pause
	spawnscriptnow \{menu_music_on}
	if ($is_demo_mode = 1)
		demo_mode_disable = {rgba = [128 128 128 255] not_focusable}
	else
		demo_mode_disable = {}
	endif
	deregisteratoms
	registeratoms \{name = achievement
		$achievement_atoms}
	change \{setlist_previous_tier = 1}
	change \{setlist_previous_song = 0}
	change \{setlist_previous_tab = tab_setlist}
	change \{current_song = welcometothejungle}
	change \{end_credits = 0}
	change \{battle_sudden_death = 0}
	change \{structurename = player1_status
		character_id = axel}
	change \{structurename = player2_status
		character_id = axel}
	change \{default_menu_focus_color = [
			125
			0
			0
			255
		]}
	change \{default_menu_unfocus_color = $menu_text_color}
	safe_create_gh3_pause_menu
	base_menu_pos = (730.0, 90.0)
	main_menu_font = fontgrid_title_gh3
	new_menu scrollid = main_menu_scrolling_menu vmenuid = vmenu_main_menu use_backdrop = (0) menu_pos = (<base_menu_pos>)
	change \{rich_presence_context = presence_main_menu}
	career_text_off = (-30.0, 0.0)
	career_text_scale = (1.55, 1.4499999)
	coop_career_text_off = (<career_text_off> + (30.0, 63.0))
	coop_career_text_scale = (0.8, 0.9)
	quickplay_text_off = (<coop_career_text_off> + (-35.0, 40.0))
	quickplay_text_scale = (1.65, 1.55)
	multiplayer_text_off = (<quickplay_text_off> + (-40.0, 65.0))
	multiplayer_text_scale = (1.2, 1.1)
	training_text_off = (<multiplayer_text_off> + (60.0, 47.0))
	training_text_scale = (1.5, 1.5)
	options_text_off = (<training_text_off> + (-20.0, 63.0))
	options_text_scale = (1.2, 1.1)
	leaderboards_text_off = (<options_text_off> + (20.0, 48.0))
	leaderboards_text_scale = (1.1, 1.0)
	exit_text_off = (<leaderboards_text_off> + (-20.0, 65.0))
	exit_text_scale = (1.1, 1.0)
	debug_menu_text_off = (<exit_text_off> + (0.0, 160.0))
	debug_menu_text_scale = 0.8
	createscreenelement {
		type = textelement
		id = main_menu_career_text
		parent = main_menu_text_container
		text = $main_menu_career
		font = <main_menu_font>
		pos = {(<career_text_off>) relative}
		scale = (<career_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		font_spacing = 0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
		<demo_mode_disable>
	}
	getscreenelementdims id = <id>
	if (<width> > 420)
		setscreenelementprops id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		id = main_menu_coop_career_text
		parent = main_menu_text_container
		text = $main_menu_coop_career
		font = <main_menu_font>
		pos = {(<coop_career_text_off>) relative}
		scale = (<coop_career_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		font_spacing = 0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
		<demo_mode_disable>
	}
	getscreenelementdims id = <id>
	if (<width> > 400)
		setscreenelementprops id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((400.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		id = main_menu_quickplay_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = $main_menu_quickplay
		font_spacing = 0
		pos = {(<quickplay_text_off>) relative}
		scale = (<quickplay_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getscreenelementdims id = <id>
	if (<width> > 400)
		setscreenelementprops id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((400.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		id = main_menu_multiplayer_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = $main_menu_multiplayer
		font_spacing = 1
		pos = {(<multiplayer_text_off>) relative}
		scale = (<multiplayer_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getscreenelementdims id = <id>
	if (<width> > 460)
		setscreenelementprops id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((460.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		id = main_menu_training_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = $main_menu_training
		font_spacing = 0
		pos = {(<training_text_off>) relative}
		scale = (<training_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getscreenelementdims id = <id>
	if (<width> > 345)
		setscreenelementprops id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((345.0, 0.0) + <height> * (0.0, 1.0))
	endif
	getscreenelementdims \{id = main_menu_training_text}
	old_height = <height>
	fit_text_in_rectangle id = main_menu_training_text dims = (350.0, 100.0) pos = {(<training_text_off>) relative} start_x_scale = (<training_text_scale>.(1.0, 0.0)) start_y_scale = (<training_text_scale>.(0.0, 1.0)) only_if_larger_x = 1 keep_ar = 1
	getscreenelementdims \{id = main_menu_training_text}
	offset = ((<old_height> * ((<old_height> -24.0) / <old_height>)) - (<height> * ((<height> - (24.0 * ((1.0 * <height>) / <old_height>))) / <height>)))
	leaderboards_text_off = (<leaderboards_text_off> - <offset> * (0.0, 1.0))
	options_text_off = (<options_text_off> - <offset> * (0.0, 1.0))
	if isxenon
		createscreenelement {
			type = textelement
			id = main_menu_leaderboards_text
			parent = main_menu_text_container
			font = <main_menu_font>
			text = $main_menu_online
			font_spacing = 0
			pos = {(<leaderboards_text_off>) relative}
			scale = (<leaderboards_text_scale>)
			rgba = ($menu_text_color)
			just = [left top]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = 60
			<demo_mode_disable>
		}
		getscreenelementdims id = <id>
		if (<width> > 360)
			setscreenelementprops id = <id> scale = 1
			fit_text_in_rectangle id = <id> dims = ((360.0, 0.0) + <height> * (0.0, 1.0))
		endif
	else
		createscreenelement {
			type = textelement
			id = main_menu_leaderboards_text
			parent = main_menu_text_container
			font = <main_menu_font>
			text = $main_menu_online
			font_spacing = 0
			pos = {(<leaderboards_text_off>) relative}
			scale = (<leaderboards_text_scale>)
			rgba = ($menu_text_color)
			just = [left top]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = 60
			<demo_mode_disable>
		}
		getscreenelementdims id = <id>
		if (<width> > 360)
			setscreenelementprops id = <id> scale = 1
			fit_text_in_rectangle id = <id> dims = ((360.0, 0.0) + <height> * (0.0, 1.0))
		endif
	endif
	createscreenelement {
		type = textelement
		id = main_menu_options_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = $main_menu_options
		font_spacing = 0
		pos = {(<options_text_off>) relative}
		scale = (<options_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getscreenelementdims id = <id>
	if (<width> > 420)
		setscreenelementprops id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		id = main_menu_exit_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = $main_menu_exit_description
		font_spacing = 0
		pos = {(<exit_text_off>) relative}
		scale = (<exit_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getscreenelementdims id = <id>
	if (<width> > 420)
		setscreenelementprops id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	if ($enable_button_cheats = 1)
		createscreenelement {
			type = textelement
			id = main_menu_debug_menu_text
			parent = main_menu_text_container
			font = <main_menu_font>
			text = $main_menu_debug_menu
			pos = {(<debug_menu_text_off>) relative}
			scale = (<debug_menu_text_scale>)
			rgba = ($menu_text_color)
			just = [left top]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = 60
		}
	endif
	offwhite = [255 255 205 255]
	hilite_off = (5.0, 0.0)
	gm_hlinfolist = [
		{
			posl = (<career_text_off> + <hilite_off> + (-40.0, 9.0))
			posr = (<career_text_off> + <hilite_off> + (218.0, 9.0))
			bedims = (40.0, 40.0)
			posh = (<career_text_off> + <hilite_off> + (-14.0, -2.0))
			hdims = (240.0, 57.0)
		} ,
		{
			posl = (<coop_career_text_off> + <hilite_off> + (-33.0, 3.0))
			posr = (<coop_career_text_off> + <hilite_off> + (281.0, 3.0))
			bedims = (32.0, 32.0)
			posh = (<coop_career_text_off> + <hilite_off> + (-14.0, -1.0))
			hdims = (300.0, 37.0)
		} ,
		{
			posl = (<quickplay_text_off> + <hilite_off> + (-34.0, 4.0))
			posr = (<quickplay_text_off> + <hilite_off> + (251.0, 4.0))
			bedims = (40.0, 40.0)
			posh = (<quickplay_text_off> + <hilite_off> + (-14.0, -2.0))
			hdims = (267.0, 47.0)
		} ,
		{
			posl = (<multiplayer_text_off> + <hilite_off> + (-37.0, 4.0))
			posr = (<multiplayer_text_off> + <hilite_off> + (301.0, 4.0))
			bedims = (38.0, 38.0)
			posh = (<multiplayer_text_off> + <hilite_off> + (-14.0, -1.0))
			hdims = (320.0, 43.0)
		} ,
		{
			posl = (<training_text_off> + <hilite_off> + (-31.0, 9.0))
			posr = (<training_text_off> + <hilite_off> + (282.0, 9.0))
			bedims = (42.0, 42.0)
			posh = (<training_text_off> + <hilite_off> + (-13.0, -2.0))
			hdims = (295.0, 61.0)
		} ,
		{
			posl = (<leaderboards_text_off> + <hilite_off> + (-33.0, 3.0))
			posr = (<leaderboards_text_off> + <hilite_off> + (213.0, 3.0))
			bedims = (34.0, 34.0)
			posh = (<leaderboards_text_off> + <hilite_off> + (-13.0, -2.0))
			hdims = (232.0, 40.0)
		} ,
		{
			posl = (<options_text_off> + <hilite_off> + (-36.0, 5.0))
			posr = (<options_text_off> + <hilite_off> + (183.0, 5.0))
			bedims = (36.0, 36.0)
			posh = (<options_text_off> + <hilite_off> + (-14.0, 0.0))
			hdims = (205.0, 43.0)
		} ,
		{
			posl = (<exit_text_off> + <hilite_off> + (-36.0, 5.0))
			posr = (<exit_text_off> + <hilite_off> + (183.0, 5.0))
			bedims = (36.0, 36.0)
			posh = (<exit_text_off> + <hilite_off> + (-12.0, 0.0))
			hdims = (205.0, 43.0)
		}
	]
	<gm_hlindex> = 0
	displaysprite {
		parent = main_menu_text_container
		tex = character_hub_hilite_bookend
		pos = ((<gm_hlinfolist> [<gm_hlindex>]).posl)
		dims = ((<gm_hlinfolist> [<gm_hlindex>]).bedims)
		rgba = <offwhite>
		z = 2
	}
	<bookend1id> = <id>
	displaysprite {
		parent = main_menu_text_container
		tex = character_hub_hilite_bookend
		pos = ((<gm_hlinfolist> [<gm_hlindex>]).posr)
		dims = ((<gm_hlinfolist> [<gm_hlindex>]).bedims)
		rgba = <offwhite>
		z = 2
	}
	<bookend2id> = <id>
	displaysprite {
		parent = main_menu_text_container
		tex = white
		rgba = <offwhite>
		pos = ((<gm_hlinfolist> [<gm_hlindex>]).posh)
		dims = ((<gm_hlinfolist> [<gm_hlindex>]).hdims)
		z = 2
	}
	<whitetexhighlightid> = <id>
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_career_text}}
			{focus setscreenelementprops params = {id = main_menu_career_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlindex = 0
					hlinfolist = <gm_hlinfolist>
					be1id = <bookend1id>
					be2id = <bookend2id>
					wthlid = <whitetexhighlightid>
					text_id = main_menu_career_text
				}
			}
			{unfocus setscreenelementprops params = {id = main_menu_career_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_career_text}}
			{pad_choose main_menu_select_career}
		]
		z_priority = -1
		<demo_mode_disable>
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_coop_career_text}}
			{focus setscreenelementprops params = {id = main_menu_coop_career_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlindex = 1
					hlinfolist = <gm_hlinfolist>
					be1id = <bookend1id>
					be2id = <bookend2id>
					wthlid = <whitetexhighlightid>
					text_id = main_menu_coop_career_text
				}
			}
			{unfocus setscreenelementprops params = {id = main_menu_coop_career_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_coop_career_text}}
			{pad_choose main_menu_select_coop_career}
		]
		z_priority = -1
		<demo_mode_disable>
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_quickplay_text}}
			{focus setscreenelementprops params = {id = main_menu_quickplay_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlindex = 2
					hlinfolist = <gm_hlinfolist>
					be1id = <bookend1id>
					be2id = <bookend2id>
					wthlid = <whitetexhighlightid>
					text_id = main_menu_quickplay_text
				}
			}
			{unfocus setscreenelementprops params = {id = main_menu_quickplay_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_quickplay_text}}
			{pad_choose main_menu_select_quickplay}
		]
		z_priority = -1
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_multiplayer_text}}
			{focus setscreenelementprops params = {id = main_menu_multiplayer_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlindex = 3
					hlinfolist = <gm_hlinfolist>
					be1id = <bookend1id>
					be2id = <bookend2id>
					wthlid = <whitetexhighlightid>
					text_id = main_menu_multiplayer_text
				}
			}
			{unfocus setscreenelementprops params = {id = main_menu_multiplayer_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_multiplayer_text}}
			{pad_choose main_menu_select_multiplayer}
		]
		z_priority = -1
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_training_text}}
			{focus setscreenelementprops params = {id = main_menu_training_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlindex = 4
					hlinfolist = <gm_hlinfolist>
					be1id = <bookend1id>
					be2id = <bookend2id>
					wthlid = <whitetexhighlightid>
					text_id = main_menu_training_text
				}
			}
			{unfocus setscreenelementprops params = {id = main_menu_training_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_training_text}}
			{pad_choose main_menu_select_training}
		]
		z_priority = -1
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_options_text}}
			{focus setscreenelementprops params = {id = main_menu_options_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlindex = 6
					hlinfolist = <gm_hlinfolist>
					be1id = <bookend1id>
					be2id = <bookend2id>
					wthlid = <whitetexhighlightid>
					text_id = main_menu_options_text
				}
			}
			{unfocus setscreenelementprops params = {id = main_menu_options_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_options_text}}
			{pad_choose main_menu_select_options}
		]
		z_priority = -1
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_leaderboards_text}}
			{focus setscreenelementprops params = {id = main_menu_leaderboards_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlindex = 5
					hlinfolist = <gm_hlinfolist>
					be1id = <bookend1id>
					be2id = <bookend2id>
					wthlid = <whitetexhighlightid>
					text_id = main_menu_leaderboards_text
				}
			}
			{unfocus setscreenelementprops params = {id = main_menu_leaderboards_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_leaderboards_text}}
			{pad_choose main_menu_select_winport_online}
		]
		z_priority = -1
		<demo_mode_disable>
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = $main_menu_exit_placeholder
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_exit_text}}
			{focus setscreenelementprops params = {id = main_menu_exit_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlindex = 7
					hlinfolist = <gm_hlinfolist>
					be1id = <bookend1id>
					be2id = <bookend2id>
					wthlid = <whitetexhighlightid>
					text_id = main_menu_exit_text
				}
			}
			{unfocus setscreenelementprops params = {id = main_menu_exit_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_exit_text}}
			{pad_choose main_menu_select_exit}
		]
		z_priority = -1
	}
	if ($enable_button_cheats = 1)
		createscreenelement {
			type = textelement
			parent = vmenu_main_menu
			font = <main_menu_font>
			text = ""
			event_handlers = [
				{focus retail_menu_focus params = {id = main_menu_debug_menu_text}}
				{focus guitar_menu_highlighter params = {
						zpri = -2
						hlindex = 0
						hlinfolist = <gm_hlinfolist>
						be1id = <bookend1id>
						be2id = <bookend2id>
						wthlid = <whitetexhighlightid>
					}
				}
				{unfocus retail_menu_unfocus params = {id = main_menu_debug_menu_text}}
				{pad_choose ui_flow_manager_respond_to_action params = {action = select_debug_menu}}
			]
			z_priority = -1
		}
	endif
	if ($new_message_of_the_day = 1)
		spawnscriptnow \{pop_in_new_downloads_notifier}
	endif
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
	add_user_control_helper \{text = $buttons_up_down
		button = strumbar
		z = 100}
	if NOT ($invite_controller = -1)
		change \{invite_controller = -1}
		ui_flow_manager_respond_to_action \{action = select_xbox_live}
		fadetoblack \{off
			time = 0}
	else
		launchevent \{type = focus
			target = vmenu_main_menu}
	endif
endscript

// No version
script create_main_menu_backdrop 
	change \{coop_dlc_active = 0}
	create_menu_backdrop \{texture = GH3_Main_Menu_BG}
	base_menu_pos = (730.0, 90.0)
	CreateScreenElement {
		type = ContainerElement
		id = main_menu_text_container
		parent = root_window
		pos = (<base_menu_pos>)
		just = [left top]
		z_priority = 3
		scale = 0.8
	}
	CreateScreenElement \{type = ContainerElement
		id = main_menu_bg_container
		parent = root_window
		pos = (0.0, 0.0)
		z_priority = 3}
	main_menu_font = fontgrid_title_gh3
	CreateScreenElement \{type = SpriteElement
		id = main_menu_bg2
		parent = main_menu_bg_container
		texture = main_menu_bg2
		pos = (335.0, 0.0)
		dims = (720.0, 720.0)
		just = [
			left
			top
		]
		z_priority = 1}
	RunScriptOnScreenElement id = main_menu_bg2 glow_menu_element params = {time = 1 id = <id>}
	CreateScreenElement \{type = SpriteElement
		parent = main_menu_bg_container
		texture = main_menu_illustrations
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		just = [
			left
			top
		]
		z_priority = 2}
	CreateScreenElement \{type = SpriteElement
		id = eyes_BL
		parent = main_menu_bg_container
		texture = main_menu_eyesBL
		pos = (93.0, 676.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_BL glow_menu_element params = {time = 1.0 id = <id>}
	CreateScreenElement \{type = SpriteElement
		id = eyes_BR
		parent = main_menu_bg_container
		texture = main_menu_eyesBR
		pos = (1176.0, 659.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_BR glow_menu_element params = {time = 1.0 id = <id>}
	CreateScreenElement \{type = SpriteElement
		id = eyes_C
		parent = main_menu_bg_container
		texture = main_menu_eyesC
		pos = (406.0, 398.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_C glow_menu_element params = {time = 1.5 id = <id>}
	CreateScreenElement \{type = SpriteElement
		id = eyes_TL
		parent = main_menu_bg_container
		texture = main_menu_eyesTL
		pos = (271.0, 215.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_TL glow_menu_element params = {time = 1.7 id = <id>}
	CreateScreenElement \{type = SpriteElement
		id = eyes_TR
		parent = main_menu_bg_container
		texture = main_menu_eyesTR
		pos = (995.0, 71.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_TR glow_menu_element params = {time = 1.0 id = <id>}
endscript