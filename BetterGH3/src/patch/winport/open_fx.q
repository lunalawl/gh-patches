// Open note hit FX for GH3+

whammy_cutoff = 1130.0
whammy_top_width_open_note1 = 130.0
whammy_top_width_open_note2 = 120.0

script GuitarEvent_HitNotes 
	if (GuitarEvent_HitNotes_CFunc)
		UpdateGuitarVolume
	endif
	if (GotParam open)
		if (<whammy_length> > 0)
			ExtendCRC open_sustain_fx ($<player_status>.text) out = scr_name
		endif
		spawnscriptnow Open_NoteFX id = <scr_name> params = {
			array_entry = <array_entry> player = <player> player_status = <player_status> length = <whammy_length>
		}
	endif
endscript

script check_note_hold 
	<index> = (<player> - 1)
	begin
	if ($currently_holding [<index>] = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	SetArrayElement ArrayName = currently_holding GlobalArray index = <index> newvalue = 1
	CheckNoteHoldInit player = <player> player_status = <player_status> array_entry = <array_entry> time = <time> guitar_stream = <guitar_stream> song = <song> pattern = <pattern>
	begin
	if NOT CheckNoteHoldWait player = <player>
		break
	endif
	Wait \{1
		gameframe}
	repeat
	CheckNoteHoldStart player = <player>
	begin
	if NOT CheckNoteHoldPerFrame player = <player>
		break
	endif
	Wait \{1
		gameframe}
	repeat
	ExtendCRC open_sustain_fx ($<player_status>.text) out = scr_name
	KillSpawnedScript id = <scr_name>
	CheckNoteHoldEnd player = <player>
	SetArrayElement ArrayName = currently_holding GlobalArray index = <index> newvalue = 0
endscript

script Open_NoteFX \{player = 1
		player_status = player1_status}
	if ($Cheat_PerformanceMode = 1)
		return
	endif
	if NOT (<sustain> = 1)
		if (<length> > 1)
			spawnscriptnow Open_NoteFX params = {player = <player> player_status = <player_status>}
		endif
		Wait \{$button_sink_time
			seconds}
	endif
	if (<length> > 1)
		flash_interval = 0.08
		ExtendCRC button_up_pixel_array ($<player_status>.text) out = pixel_array
		delta = 0.0
		begin
		GetDeltaTime
		delta = (<delta> + <delta_time>)
		if (<delta> > <flash_interval> / $current_speedfactor)
			spawnscriptnow Open_NoteFX params = {player = <player> player_status = <player_status> sustain = 1}
			delta = 0.0
		endif
		i = 0
		begin
		SetArrayElement ArrayName = <pixel_array> GlobalArray index = <i> newvalue = 1E-07
		Increment \{i}
		repeat 5
		Wait \{1
			gameframe}
		repeat
		return
	endif
	GetSongTimeMs
	if ($<player_status>.star_power_used = 1)
		open_color1_start = [199 252 255 255]
		open_color1_end = [199 252 255 0]
		open_color2_start = [0 247 255 255]
		open_color2_end = [0 247 255 0]
	else
		open_color1_start = [255 255 255 255]
		open_color1_end = [0 0 0 255]
		open_color2_start = [212 0 255 255]
		open_color2_end = [212 0 255 0]
	endif
	FormatText checksumname = container_id 'gem_container%p' p = ($<player_status>.text)
	FormatText checksumname = fx_id 'open_particlep%p_%t' p = <player> t = <time>
	fx1_scale = (1.01, 0.77)
	fx2_scale = (2.2, 2.4)
	if ($current_num_players = 2 || $end_credits = 1)
		fx1_scale = (0.75, 0.9)
		fx2_scale = (1.7, 2.4)
	endif
	pos = ($button_up_models.Yellow.pos_2d)
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		id = <fx_id>
		scale = <fx1_scale>
		just = [center center]
		rgba = <open_color1_start>
		z_priority = 30
		pos = (<pos> - (0.0, 36.0))
		material = sys_openfx1_sys_openfx1
	}
	if NOT (<sustain> = 1)
		ExtendCRC <fx_id> '_2' out = fx2_id
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			id = <fx2_id>
			scale = <fx2_scale>
			rgba = <open_color2_start>
			just = [center center]
			z_priority = 30
			pos = (<pos> - (0.0, 26.0))
			material = sys_openfx2_sys_openfx2
		}
	endif
	time = (0.1 / $current_speedfactor)
	if ScreenElementExists id = <fx_id>
		doScreenElementMorph id = <fx_id> time = <time> rgba = <open_color1_end> scale = (1.0, 1.8) relative_scale
	endif
	if NOT (<sustain> = 1)
		if ScreenElementExists id = <fx2_id>
			doScreenElementMorph id = <fx2_id> time = <time> rgba = <open_color2_end> scale = 1.4 relative_scale
		endif
	endif
	Wait <time> seconds
	if ScreenElementExists id = <fx_id>
		DestroyScreenElement id = <fx_id>
	endif
	if ScreenElementExists id = <fx2_id>
		DestroyScreenElement id = <fx2_id>
	endif
endscript
