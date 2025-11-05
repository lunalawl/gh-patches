current_crowd = 1.0
average_crowd = 1.0
total_crowd = 0.0
max_crowd = 0.0
crowd_scale = 2.0
health_scale = 2.0
crowd_debug_mode = 0
viewercam_nofail = 0

script crowd_reset 
	if ($game_mode = tutorial)
		return
	endif
	if GetNodeFlag \{LS_ENCORE_POST}
		change \{current_crowd = 1.6666}
		change \{average_crowd = 1.6666}
	else
		change \{current_crowd = 1.0}
		change \{average_crowd = 1.0}
	endif
	change \{total_crowd = 0.0}
	change \{max_crowd = 0.0}
	change \{last_time_in_lead = 0.0}
	change \{last_time_in_lead_player = -1}
	if (<player> = 1)
		StopSoundEvent \{$CurrentlyPlayingOneShotSoundEvent}
		if ($game_mode = training)
			BG_Crowd_Front_End_Silence \{immediate = 1}
		elseif ($end_credits = 1 ||
				GetNodeFlag LS_ENCORE_POST)
			printf \{channel = sfx
				"crowd_reset LS_ENCORE_POST"}
			Change_Crowd_Looping_SFX \{crowd_looping_state = good}
		else
			printf \{channel = sfx
				"NOT - crowd_reset LS_ENCORE_POST"}
			Change_Crowd_Looping_SFX \{crowd_looping_state = neutral}
		endif
	endif
	if GetNodeFlag \{LS_ENCORE_POST}
		if NOT ($game_mode = p2_battle)
			change structurename = <player_status> current_health = 1.6666
		else
			change structurename = <player_status> current_health = 1.0
		endif
	else
		change structurename = <player_status> current_health = 1.0
	endif
	if ($game_mode = p2_battle && $battle_sudden_death = 1)
		change structurename = <player_status> current_health = ($<player_status>.save_health)
	endif
	CrowdReset
endscript

script forcescore 
	switch $debug_forcescore
		case poor
		health = ($health_poor_medium / 2)
		case medium
		health = (($health_poor_medium + $health_medium_good) / 2)
		case good
		health = (($health_medium_good + $health_scale) / 2)
		default
		health = ($health_poor_medium / 2)
	endswitch
	change structurename = <player_status> current_health = <health>
	change current_crowd = <health>
endscript
z_wikker_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Real_Crowd\\Crowd_Ped_01.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_wikker/z_wikker.tex`
		assetcontext = z_wikker
		TriggerScript = Z_Wikker_Crowd_Peds
		params = {
			name = crowd1
		}
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Real_Crowd\\Crowd_Ped_02.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_wikker/z_wikker.tex`
		assetcontext = z_wikker
		TriggerScript = Z_Wikker_Crowd_Peds
		params = {
			name = crowd2
		}
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Real_Crowd\\Crowd_Ped_03.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_wikker/z_wikker.tex`
		assetcontext = z_wikker
		TriggerScript = Z_Wikker_Crowd_Peds
		params = {
			name = crowd3
		}
	}
	{
		name = crowd4
		camera = crowd4_cam
		Model = 'Real_Crowd\\Crowd_Ped_04.skin'
		id = crowd4_cam_viewport
		texture = viewport4
		textureasset = `tex/zones/Demo/tw_billboard04.dds`
		texdict = `zones/z_wikker/z_wikker.tex`
		assetcontext = z_wikker
		TriggerScript = Z_Wikker_Crowd_Peds
		params = {
			name = crowd4
		}
	}
	{
		name = crowd5
		camera = crowd5_cam
		Model = 'Real_Crowd\\crowd_pedF_1.skin'
		id = crowd5_cam_viewport
		texture = viewport5
		textureasset = `tex/zones/Demo/tw_billboard05.dds`
		texdict = `zones/z_wikker/z_wikker.tex`
		assetcontext = z_wikker
		TriggerScript = Z_Wikker_Crowd_Peds
		params = {
			name = crowd5
		}
	}
	{
		name = crowd6
		camera = crowd6_cam
		Model = 'Real_Crowd\\crowd_pedF_2.skin'
		id = crowd6_cam_viewport
		texture = viewport6
		textureasset = `tex/zones/Demo/tw_billboard06.dds`
		texdict = `zones/z_wikker/z_wikker.tex`
		assetcontext = z_wikker
		TriggerScript = Z_Wikker_Crowd_Peds
		params = {
			name = crowd6
		}
	}
]
z_dive_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Real_Crowd\\Crowd_Ped_01.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_dive/z_dive.tex`
		assetcontext = z_dive
		TriggerScript = Z_Dive_Crowd_Peds
		params = {
			name = crowd1
		}
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Real_Crowd\\Crowd_Ped_02.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_dive/z_dive.tex`
		assetcontext = z_dive
		TriggerScript = Z_Dive_Crowd_Peds
		params = {
			name = crowd2
		}
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Real_Crowd\\Crowd_Ped_03.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_dive/z_dive.tex`
		assetcontext = z_dive
		TriggerScript = Z_Dive_Crowd_Peds
		params = {
			name = crowd3
		}
	}
	{
		name = crowd4
		camera = crowd4_cam
		Model = 'Real_Crowd\\Crowd_Ped_04.skin'
		id = crowd4_cam_viewport
		texture = viewport4
		textureasset = `tex/zones/Demo/tw_billboard04.dds`
		texdict = `zones/z_dive/z_dive.tex`
		assetcontext = z_dive
		TriggerScript = Z_Dive_Crowd_Peds
		params = {
			name = crowd4
		}
	}
	{
		name = crowd5
		camera = crowd5_cam
		Model = 'Real_Crowd\\crowd_pedF_1.skin'
		id = crowd5_cam_viewport
		texture = viewport5
		textureasset = `tex/zones/Demo/tw_billboard05.dds`
		texdict = `zones/z_dive/z_dive.tex`
		assetcontext = z_dive
		TriggerScript = Z_Dive_Crowd_Peds
		params = {
			name = crowd5
		}
	}
	{
		name = crowd6
		camera = crowd6_cam
		Model = 'Real_Crowd\\crowd_pedF_2.skin'
		id = crowd6_cam_viewport
		texture = viewport6
		textureasset = `tex/zones/Demo/tw_billboard06.dds`
		texdict = `zones/z_dive/z_dive.tex`
		assetcontext = z_dive
		TriggerScript = Z_Dive_Crowd_Peds
		params = {
			name = crowd6
		}
	}
]
z_artdeco_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Real_Crowd\\Crowd_Ped_01.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_artdeco/z_artdeco.tex`
		assetcontext = z_artdeco
		TriggerScript = Z_ArtDeco_Crowd_Peds
		params = {
			name = crowd1
		}
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Real_Crowd\\Crowd_Ped_02.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_artdeco/z_artdeco.tex`
		assetcontext = z_artdeco
		TriggerScript = Z_ArtDeco_Crowd_Peds
		params = {
			name = crowd2
		}
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Real_Crowd\\Crowd_Ped_03.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_artdeco/z_artdeco.tex`
		assetcontext = z_artdeco
		TriggerScript = Z_ArtDeco_Crowd_Peds
		params = {
			name = crowd3
		}
	}
	{
		name = crowd4
		camera = crowd4_cam
		Model = 'Real_Crowd\\Crowd_Ped_04.skin'
		id = crowd4_cam_viewport
		texture = viewport4
		textureasset = `tex/zones/Demo/tw_billboard04.dds`
		texdict = `zones/z_artdeco/z_artdeco.tex`
		assetcontext = z_artdeco
		TriggerScript = Z_ArtDeco_Crowd_Peds
		params = {
			name = crowd4
		}
	}
	{
		name = crowd5
		camera = crowd5_cam
		Model = 'Real_Crowd\\crowd_pedF_1.skin'
		id = crowd5_cam_viewport
		texture = viewport5
		textureasset = `tex/zones/Demo/tw_billboard05.dds`
		texdict = `zones/z_artdeco/z_artdeco.tex`
		assetcontext = z_artdeco
		TriggerScript = Z_ArtDeco_Crowd_Peds
		params = {
			name = crowd5
		}
	}
	{
		name = crowd6
		camera = crowd6_cam
		Model = 'Real_Crowd\\crowd_pedF_2.skin'
		id = crowd6_cam_viewport
		texture = viewport6
		textureasset = `tex/zones/Demo/tw_billboard06.dds`
		texdict = `zones/z_artdeco/z_artdeco.tex`
		assetcontext = z_artdeco
		TriggerScript = Z_ArtDeco_Crowd_Peds
		params = {
			name = crowd6
		}
	}
]
z_prison_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Real_Crowd\\Crowd_Prison_01.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_prison/z_prison.tex`
		assetcontext = z_prison
		TriggerScript = Z_Prison_Crowd_Peds
		params = {
			name = crowd1
		}
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Real_Crowd\\Crowd_Prison_02.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_prison/z_prison.tex`
		assetcontext = z_prison
		TriggerScript = Z_Prison_Crowd_Peds
		params = {
			name = crowd2
		}
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Real_Crowd\\Crowd_Prison_01.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_prison/z_prison.tex`
		assetcontext = z_prison
		TriggerScript = Z_Prison_Crowd_Peds
		params = {
			name = crowd3
		}
	}
	{
		name = crowd4
		camera = crowd4_cam
		Model = 'Real_Crowd\\Crowd_Prison_02.skin'
		id = crowd4_cam_viewport
		texture = viewport4
		textureasset = `tex/zones/Demo/tw_billboard04.dds`
		texdict = `zones/z_prison/z_prison.tex`
		assetcontext = z_prison
		TriggerScript = Z_Prison_Crowd_Peds
		params = {
			name = crowd4
		}
	}
	{
		name = crowd5
		camera = crowd5_cam
		Model = 'Real_Crowd\\Crowd_Prison_01.skin'
		id = crowd5_cam_viewport
		texture = viewport5
		textureasset = `tex/zones/Demo/tw_billboard05.dds`
		texdict = `zones/z_prison/z_prison.tex`
		assetcontext = z_prison
		TriggerScript = Z_Prison_Crowd_Peds
		params = {
			name = crowd5
		}
	}
	{
		name = crowd6
		camera = crowd6_cam
		Model = 'Real_Crowd\\Crowd_Prison_02.skin'
		id = crowd6_cam_viewport
		texture = viewport6
		textureasset = `tex/zones/Demo/tw_billboard06.dds`
		texdict = `zones/z_prison/z_prison.tex`
		assetcontext = z_prison
		TriggerScript = Z_Prison_Crowd_Peds
		params = {
			name = crowd6
		}
	}
]
z_party_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Real_Crowd\\Crowd_Ped_01.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_party/z_party.tex`
		assetcontext = z_party
		TriggerScript = Z_Party_Crowd_Peds
		params = {
			name = crowd1
		}
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Real_Crowd\\Crowd_Ped_02.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_party/z_party.tex`
		assetcontext = z_party
		TriggerScript = Z_Party_Crowd_Peds
		params = {
			name = crowd2
		}
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Real_Crowd\\Crowd_Ped_03.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_party/z_party.tex`
		assetcontext = z_party
		TriggerScript = Z_Party_Crowd_Peds
		params = {
			name = crowd3
		}
	}
	{
		name = crowd4
		camera = crowd4_cam
		Model = 'Real_Crowd\\Crowd_Ped_04.skin'
		id = crowd4_cam_viewport
		texture = viewport4
		textureasset = `tex/zones/Demo/tw_billboard04.dds`
		texdict = `zones/z_party/z_party.tex`
		assetcontext = z_party
		TriggerScript = Z_Party_Crowd_Peds
		params = {
			name = crowd4
		}
	}
	{
		name = crowd5
		camera = crowd5_cam
		Model = 'Real_Crowd\\crowd_pedF_1.skin'
		id = crowd5_cam_viewport
		texture = viewport5
		textureasset = `tex/zones/Demo/tw_billboard05.dds`
		texdict = `zones/z_party/z_party.tex`
		assetcontext = z_party
		TriggerScript = Z_Party_Crowd_Peds
		params = {
			name = crowd5
		}
	}
	{
		name = crowd6
		camera = crowd6_cam
		Model = 'Real_Crowd\\crowd_pedF_2.skin'
		id = crowd6_cam_viewport
		texture = viewport6
		textureasset = `tex/zones/Demo/tw_billboard06.dds`
		texdict = `zones/z_party/z_party.tex`
		assetcontext = z_party
		TriggerScript = Z_Party_Crowd_Peds
		params = {
			name = crowd6
		}
	}
]
z_hell_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Real_Crowd\\Crowd_Biker_01.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_hell/z_hell.tex`
		assetcontext = z_hell
		TriggerScript = Z_Hell_Crowd_Peds
		params = {
			name = crowd1
		}
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Real_Crowd\\Crowd_Biker_02.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_hell/z_hell.tex`
		assetcontext = z_hell
		TriggerScript = Z_Hell_Crowd_Peds
		params = {
			name = crowd2
		}
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Real_Crowd\\Crowd_Biker_01.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_hell/z_hell.tex`
		assetcontext = z_hell
		TriggerScript = Z_Hell_Crowd_Peds
		params = {
			name = crowd3
		}
	}
	{
		name = crowd4
		camera = crowd4_cam
		Model = 'Real_Crowd\\Crowd_Biker_02.skin'
		id = crowd4_cam_viewport
		texture = viewport4
		textureasset = `tex/zones/Demo/tw_billboard04.dds`
		texdict = `zones/z_hell/z_hell.tex`
		assetcontext = z_hell
		TriggerScript = Z_Hell_Crowd_Peds
		params = {
			name = crowd4
		}
	}
	{
		name = crowd5
		camera = crowd5_cam
		Model = 'Real_Crowd\\crowd_Biker_01.skin'
		id = crowd5_cam_viewport
		texture = viewport5
		textureasset = `tex/zones/Demo/tw_billboard05.dds`
		texdict = `zones/z_hell/z_hell.tex`
		assetcontext = z_hell
		TriggerScript = Z_Hell_Crowd_Peds
		params = {
			name = crowd5
		}
	}
	{
		name = crowd6
		camera = crowd6_cam
		Model = 'Real_Crowd\\crowd_biker_02.skin'
		id = crowd6_cam_viewport
		texture = viewport6
		textureasset = `tex/zones/Demo/tw_billboard06.dds`
		texdict = `zones/z_hell/z_hell.tex`
		assetcontext = z_hell
		TriggerScript = Z_Hell_Crowd_Peds
		params = {
			name = crowd6
		}
	}
]
z_training_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Characters\\Musicians\\Sec_Barker.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_training/z_training.tex`
		assetcontext = z_training
		TriggerScript = Z_Training_Crowd_Peds
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Characters\\Musicians\\Sec_Punk.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_training/z_training.tex`
		assetcontext = z_training
		TriggerScript = Z_Training_Crowd_Peds
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Characters\\Musicians\\Sec_Pro_Stabb.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_training/z_training.tex`
		assetcontext = z_training
		TriggerScript = Z_Training_Crowd_Peds
	}
]
z_Budokan_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Real_Crowd\\Crowd_Ped_01.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_Budokan/z_Budokan.tex`
		assetcontext = z_budokan
		TriggerScript = Z_Budokan_Crowd_Peds
		params = {
			name = crowd1
		}
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Real_Crowd\\Crowd_Ped_02.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_Budokan/z_Budokan.tex`
		assetcontext = z_budokan
		TriggerScript = Z_Budokan_Crowd_Peds
		params = {
			name = crowd2
		}
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Real_Crowd\\Crowd_Ped_03.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_Budokan/z_Budokan.tex`
		assetcontext = z_budokan
		TriggerScript = Z_Budokan_Crowd_Peds
		params = {
			name = crowd3
		}
	}
	{
		name = crowd4
		camera = crowd4_cam
		Model = 'Real_Crowd\\Crowd_Ped_04.skin'
		id = crowd4_cam_viewport
		texture = viewport4
		textureasset = `tex/zones/Demo/tw_billboard04.dds`
		texdict = `zones/z_Budokan/z_Budokan.tex`
		assetcontext = z_budokan
		TriggerScript = Z_Budokan_Crowd_Peds
		params = {
			name = crowd4
		}
	}
	{
		name = crowd5
		camera = crowd5_cam
		Model = 'Real_Crowd\\crowd_pedF_1.skin'
		id = crowd5_cam_viewport
		texture = viewport5
		textureasset = `tex/zones/Demo/tw_billboard05.dds`
		texdict = `zones/z_Budokan/z_Budokan.tex`
		assetcontext = z_budokan
		TriggerScript = Z_Budokan_Crowd_Peds
		params = {
			name = crowd5
		}
	}
	{
		name = crowd6
		camera = crowd6_cam
		Model = 'Real_Crowd\\crowd_pedF_2.skin'
		id = crowd6_cam_viewport
		texture = viewport6
		textureasset = `tex/zones/Demo/tw_billboard06.dds`
		texdict = `zones/z_Budokan/z_Budokan.tex`
		assetcontext = z_budokan
		TriggerScript = Z_Budokan_Crowd_Peds
		params = {
			name = crowd6
		}
	}
]
z_video_crowd_models = [
	{
		name = crowd1
		camera = crowd1_cam
		Model = 'Real_Crowd\\Crowd_Ped_01.skin'
		id = crowd1_cam_viewport
		texture = viewport1
		textureasset = `tex/zones/Demo/tw_billboard01.dds`
		texdict = `zones/z_video/z_video.tex`
		assetcontext = z_video
		TriggerScript = Z_Video_Crowd_Peds
		params = {
			name = crowd1
		}
		roty = -90
	}
	{
		name = crowd2
		camera = crowd2_cam
		Model = 'Real_Crowd\\Crowd_Ped_02.skin'
		id = crowd2_cam_viewport
		texture = viewport2
		textureasset = `tex/zones/Demo/tw_billboard02.dds`
		texdict = `zones/z_video/z_video.tex`
		assetcontext = z_video
		TriggerScript = Z_Video_Crowd_Peds
		params = {
			name = crowd2
		}
		roty = -90
	}
	{
		name = crowd3
		camera = crowd3_cam
		Model = 'Real_Crowd\\Crowd_Ped_03.skin'
		id = crowd3_cam_viewport
		texture = viewport3
		textureasset = `tex/zones/Demo/tw_billboard03.dds`
		texdict = `zones/z_video/z_video.tex`
		assetcontext = z_video
		TriggerScript = Z_Video_Crowd_Peds
		params = {
			name = crowd3
		}
		roty = -90
	}
	{
		name = crowd4
		camera = crowd4_cam
		Model = 'Real_Crowd\\Crowd_Ped_04.skin'
		id = crowd4_cam_viewport
		texture = viewport4
		textureasset = `tex/zones/Demo/tw_billboard04.dds`
		texdict = `zones/z_video/z_video.tex`
		assetcontext = z_video
		TriggerScript = Z_Video_Crowd_Peds
		params = {
			name = crowd4
		}
	}
	{
		name = crowd5
		camera = crowd5_cam
		Model = 'Real_Crowd\\crowd_pedF_1.skin'
		id = crowd5_cam_viewport
		texture = viewport5
		textureasset = `tex/zones/Demo/tw_billboard05.dds`
		texdict = `zones/z_video/z_video.tex`
		assetcontext = z_video
		TriggerScript = Z_Video_Crowd_Peds
		params = {
			name = crowd5
		}
	}
	{
		name = crowd6
		camera = crowd6_cam
		Model = 'Real_Crowd\\crowd_pedF_2.skin'
		id = crowd6_cam_viewport
		texture = viewport6
		textureasset = `tex/zones/Demo/tw_billboard06.dds`
		texdict = `zones/z_video/z_video.tex`
		assetcontext = z_video
		TriggerScript = Z_Video_Crowd_Peds
		params = {
			name = crowd6
		}
	}
	{
		name = crowd7
		camera = crowd7_cam
		Model = 'Real_Crowd\\Crowd_Ped_03.skin'
		id = crowd7_cam_viewport
		texture = viewport7
		textureasset = `tex/zones/Demo/tw_billboard07.dds`
		texdict = `zones/z_video/z_video.tex`
		assetcontext = z_video
		TriggerScript = Z_Video_Crowd_Peds
		params = {
			name = crowd7
		}
		roty = 90
	}
	{
		name = crowd8
		camera = crowd8_cam
		Model = 'Real_Crowd\\Crowd_Ped_04.skin'
		id = crowd8_cam_viewport
		texture = viewport8
		textureasset = `tex/zones/Demo/tw_billboard08.dds`
		texdict = `zones/z_video/z_video.tex`
		assetcontext = z_video
		TriggerScript = Z_Video_Crowd_Peds
		params = {
			name = crowd8
		}
		roty = 90
	}
]

script create_crowd_models 
	if IsWinPort
		WinPortGfxGetOptionValue \{option = 2}
		if (<value> = 0)
			return
		endif
		crowdOption = <value>
	endif
	if ($disable_crowd = 1)
		return
	endif
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = crowd_models '%s_crowd_models' s = <pakname>
	if NOT GlobalExists name = <crowd_models>
		return
	endif
	change crowd_model_array = <crowd_models>
	GetArraySize $<crowd_models>
	if IsWinPort
		if (<crowdOption> = 1)
			<array_size> = (<array_size> / 2)
		endif
	endif
	array_count = 0
	begin
	pos = ((-500.0, -200.0, 0.0) + (0.0, -100.0, 0.0) * <array_count>)
	viewport = ($<crowd_models> [<array_count>].id)
	camera = ($<crowd_models> [<array_count>].camera)
	if NOT StructureContains Structure = ($<crowd_models> [<array_count>]) remap_only
		MemPushContext \{BottomUpHeap}
		CreateFromStructure {
			pos = <pos>
			Quat = (0.0, 1.0, 0.0)
			Class = GameObject
			type = Ghost
			CreatedAtStart
			($<crowd_models> [<array_count>])
			SuspendDistance = 0
			lod_dist1 = 400
			lod_dist2 = 401
			profile = $Profile_Ped_Crowd_Obj
			lightgroup = Crowd
			object_type = Crowd
			ProfileColor = 49344
			profilebudget = 200
			use_jq
		}
		model_id = ($<crowd_models> [<array_count>].name)
		extra_model = 'Real_Crowd\\Crowd_HandL_Lighter.skin'
		<model_id> :AddGeom lhand_lighter Model = <extra_model> lightgroup = Crowd
		extra_model = 'Real_Crowd\\Crowd_HandL_Rock.skin'
		<model_id> :AddGeom lhand_rock Model = <extra_model> lightgroup = Crowd
		extra_model = 'Real_Crowd\\Crowd_HandL_Clap.skin'
		<model_id> :AddGeom lhand_clap Model = <extra_model> lightgroup = Crowd
		extra_model = 'Real_Crowd\\Crowd_HandL_Fist.skin'
		<model_id> :AddGeom lhand_fist Model = <extra_model> lightgroup = Crowd
		extra_model = 'Real_Crowd\\Crowd_HandR_Lighter.skin'
		<model_id> :AddGeom rhand_lighter Model = <extra_model> lightgroup = Crowd
		extra_model = 'Real_Crowd\\Crowd_HandR_Rock.skin'
		<model_id> :AddGeom rhand_rock Model = <extra_model> lightgroup = Crowd
		extra_model = 'Real_Crowd\\Crowd_HandR_Clap.skin'
		<model_id> :AddGeom rhand_clap Model = <extra_model> lightgroup = Crowd
		extra_model = 'Real_Crowd\\Crowd_HandR_Fist.skin'
		<model_id> :AddGeom rhand_fist Model = <extra_model> lightgroup = Crowd
		<model_id> :SwitchOffAtomic lhand_lighter
		<model_id> :SwitchOffAtomic lhand_rock
		<model_id> :SwitchOffAtomic lhand_fist
		<model_id> :SwitchOnAtomic lhand_clap
		<model_id> :SwitchOffAtomic rhand_lighter
		<model_id> :SwitchOffAtomic rhand_rock
		<model_id> :SwitchOffAtomic rhand_fist
		<model_id> :SwitchOnAtomic rhand_clap
		if StructureContains Structure = ($<crowd_models> [<array_count>]) roty
			($<crowd_models> [<array_count>].name) :Obj_SetOrientation y = ($<crowd_models> [<array_count>].roty)
			apply_correction = 0
		else
			apply_correction = 1
		endif
		MemPopContext \{BottomUpHeap}
		style = imposter_rendering
		if (<array_size> <= 6)
			if isXenon
				style = imposter_rendering_highres
			endif
		endif
		CreateScreenElement {
			parent = root_window
			just = [center center]
			type = ViewportElement
			id = <viewport>
			texture = ($<crowd_models> [<array_count>].texture)
			pos = (2000.0, 200.0)
			dims = (64.0, 64.0)
			alpha = 1
			style = <style>
		}
		CreateCompositeObjectInstance {
			priority = $COIM_Priority_Permanent
			heap = generic
			Components = [
				{Component = camera}
			]
			params = {
				name = <camera>
				viewport = <viewport>
				object_type = Crowd
				ProfileColor = 12632064
				profilebudget = 10
				use_jq
				far_clip = 20
			}
		}
		SetActiveCamera viewport = <viewport> id = <camera>
		<camera> :SetHFov hfov = 20.0
		SetViewportProperties viewport = <viewport> no_resolve_depthstencilbuffer = true
		AddCrowdModelCam camera = <camera> pos = <pos> viewport = <viewport> apply_correction = <apply_correction>
	endif
	SetSearchAllAssetContexts
	CreateViewportTextureOverride {
		id = <viewport>
		viewportid = <viewport>
		texture = ($<crowd_models> [<array_count>].textureasset)
		texdict = ($<crowd_models> [<array_count>].texdict)
	}
	SetSearchAllAssetContexts \{off}
	<array_count> = (<array_count> + 1)
	repeat <array_size>
endscript

script update_crowd_model_cam 
	crowd_scaler = 25
	begin
	GetViewportCameraOrient \{viewport = bg_viewport}
	GetVectorComponents <at>
	Angle = (<x> * <crowd_scaler>)
	RotateVector vector = <at> ry = <Angle>
	at = <result_vector>
	RotateVector vector = <left> ry = <Angle>
	left = <result_vector>
	RotateVector vector = <up> ry = <Angle>
	up = <result_vector>
	posdir = (<model_pos> + (0.0, 1.0, 0.0) + (<at> * 3.5))
	<camera> :Obj_SetPosition position = <posdir>
	<camera> :Obj_SetOrientation dir = <at> Only handles upright cameras
	SetViewportCameraOrient viewport = <viewport> at = <at> left = <left> up = <up>
	<camera> :UnPause
	Wait \{1
		gameframe}
	repeat
endscript

script destroy_crowd_models 
	ClearCrowdModelCams
	crowd_models = $crowd_model_array
	if (<crowd_models> = none)
		return
	endif
	GetArraySize <crowd_models>
	array_count = 0
	begin
	if NOT StructureContains Structure = (<crowd_models> [<array_count>]) remap_only
		KillSpawnedScript \{name = update_crowd_model_cam}
		if CompositeObjectExists name = (<crowd_models> [<array_count>].camera)
			(<crowd_models> [<array_count>].camera) :Die
		endif
		if ScreenElementExists id = (<crowd_models> [<array_count>].id)
			SetSearchAllAssetContexts
			DestroyViewportTextureOverride id = (<crowd_models> [<array_count>].id)
			SetSearchAllAssetContexts \{off}
			DestroyScreenElement id = (<crowd_models> [<array_count>].id)
		endif
		if CompositeObjectExists name = (<crowd_models> [<array_count>].name)
			(<crowd_models> [<array_count>].name) :Die
		endif
	endif
	<array_count> = (<array_count> + 1)
	repeat <array_size>
	change \{crowd_model_array = none}
endscript

script set_crowd_hand \{Hand = left
		type = clap}
	Obj_GetID
	name = <ObjID>
	if (<Hand> = left)
		switch (<type>)
			case lighter
			part = lhand_lighter
			case Rock
			part = lhand_rock
			case clap
			part = lhand_clap
			case fist
			part = lhand_fist
		endswitch
		<name> :SwitchOffAtomic lhand_lighter
		<name> :SwitchOffAtomic lhand_rock
		<name> :SwitchOffAtomic lhand_clap
		<name> :SwitchOffAtomic lhand_fist
		<name> :SwitchOnAtomic <part>
	else
		switch (<type>)
			case lighter
			part = rhand_lighter
			case Rock
			part = rhand_rock
			case clap
			part = rhand_clap
			case fist
			part = rhand_fist
		endswitch
		<name> :SwitchOffAtomic rhand_lighter
		<name> :SwitchOffAtomic rhand_rock
		<name> :SwitchOffAtomic rhand_clap
		<name> :SwitchOffAtomic rhand_fist
		<name> :SwitchOnAtomic <part>
	endif
endscript

script Crowd_SetHand \{name = crowd1
		Hand = left
		type = clap}
	if CompositeObjectExists <name>
		<name> :set_crowd_hand Hand = <Hand> type = <type>
	endif
endscript

script Crowd_StartLighters 
	KillSpawnedScript \{name = crowd_monitor_performance}
	spawnscriptnow \{crowd_monitor_performance}
endscript

script crowd_monitor_performance 
	lighters_on = false
	begin
	get_skill_level
	if (<skill> != Bad)
		if (<lighters_on> = false)
			Crowd_AllSetHand \{Hand = right
				type = lighter}
			Crowd_AllPlayAnim \{Anim = special}
			lighters_on = true
			Crowd_ToggleLighters \{on}
		endif
	else
		if (<lighters_on> = true)
			Crowd_AllSetHand \{Hand = right
				type = clap}
			Crowd_AllPlayAnim \{Anim = Idle}
			lighters_on = false
			Crowd_ToggleLighters \{off}
		endif
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script Crowd_StopLighters 
	KillSpawnedScript \{name = crowd_monitor_performance}
	Crowd_AllSetHand \{Hand = right
		type = clap}
	Crowd_AllPlayAnim \{Anim = Idle}
	Crowd_ToggleLighters \{off}
endscript

script Crowd_AllSetHand 
	Crowd_SetHand name = crowd1 Hand = <Hand> type = <type>
	Crowd_SetHand name = crowd2 Hand = <Hand> type = <type>
	Crowd_SetHand name = crowd3 Hand = <Hand> type = <type>
	Crowd_SetHand name = crowd4 Hand = <Hand> type = <type>
	Crowd_SetHand name = crowd5 Hand = <Hand> type = <type>
	Crowd_SetHand name = crowd6 Hand = <Hand> type = <type>
	Crowd_SetHand name = crowd7 Hand = <Hand> type = <type>
	Crowd_SetHand name = crowd8 Hand = <Hand> type = <type>
endscript

script Crowd_AllPlayAnim 
	Wait \{1
		gameframe}
	Crowd_PlayAnim name = crowd1 Anim = <Anim>
	Wait \{1
		gameframe}
	Crowd_PlayAnim name = crowd2 Anim = <Anim>
	Wait \{1
		gameframe}
	Crowd_PlayAnim name = crowd3 Anim = <Anim>
	Wait \{1
		gameframe}
	Crowd_PlayAnim name = crowd4 Anim = <Anim>
	Wait \{1
		gameframe}
	Crowd_PlayAnim name = crowd5 Anim = <Anim>
	Wait \{1
		gameframe}
	Crowd_PlayAnim name = crowd6 Anim = <Anim>
	Wait \{1
		gameframe}
	Crowd_PlayAnim name = crowd7 Anim = <Anim>
	Wait \{1
		gameframe}
	Crowd_PlayAnim name = crowd8 Anim = <Anim>
endscript

script Crowd_PlayAnim \{name = crowd1
		Anim = Idle}
	if NOT CompositeObjectExists <name>
		return
	endif
	if StructureContains Structure = ($Crowd_Profiles) name = <name>
		anim_set = ($Crowd_Profiles.<name>.anim_set)
		<name> :Obj_KillSpawnedScript name = crowd_play_adjusting_random_anims
		<name> :Obj_SpawnScriptNow crowd_play_adjusting_random_anims params = {anim_set = <anim_set> Anim = <Anim>}
	else
		printf channel = Crowd "animset not found for %a......" a = <name>
	endif
endscript

script crowd_create_lighters 
	if IsWinPort
		WinPortGfxGetOptionValue \{option = 2}
		if (<value> = 0)
			return
		endif
	endif
	GetPakManCurrent \{map = zones}
	if (<pak> = z_artdeco)
		return
	endif
	GetPakManCurrentName \{map = zones}
	index = 0
	begin
	if (<index> < 10)
		FormatText checksumname = crowd_lighter '%s_LIGHTER_Geo0%a' s = <pakname> a = <index>
	else
		FormatText checksumname = crowd_lighter '%s_LIGHTER_Geo%a' s = <pakname> a = <index>
	endif
	if CompositeObjectExists name = <crowd_lighter>
		<crowd_lighter> :hide
	else
		if IsInNodeArray <crowd_lighter>
			if NOT IsCreated <crowd_lighter>
				create name = <crowd_lighter>
				if CompositeObjectExists name = <crowd_lighter>
					<crowd_lighter> :hide
				else
					printf "failed to create lighter object %a! ...." a = <crowd_lighter>
				endif
			else
			endif
		else
		endif
	endif
	index = (<index> + 1)
	if (<index> = 15)
		break
	endif
	repeat
endscript

script Crowd_ToggleLighters 
	GetPakManCurrentName \{map = zones}
	index = 0
	begin
	if (<index> < 10)
		FormatText checksumname = crowd_lighter '%s_LIGHTER_Geo0%a' s = <pakname> a = <index>
	else
		FormatText checksumname = crowd_lighter '%s_LIGHTER_Geo%a' s = <pakname> a = <index>
	endif
	if CompositeObjectExists name = <crowd_lighter>
		if GotParam \{on}
			<crowd_lighter> :unhide
		elseif GotParam \{off}
			<crowd_lighter> :hide
		endif
	endif
	index = (<index> + 1)
	if (<index> = 15)
		break
	endif
	repeat
endscript

script Crowd_StageDiver_Hide \{index = 1}
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = stagediver '%s_TRG_Ped_StageDive0%a' s = <pakname> a = <index>
	if CompositeObjectExists name = <stagediver>
		<stagediver> :hide
	endif
endscript

script Crowd_StageDiver_Jump \{index = 1}
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = stagediver '%s_TRG_Ped_StageDive0%a' s = <pakname> a = <index>
	if CompositeObjectExists name = <stagediver>
		<stagediver> :unhide
		GetPakManCurrent \{map = zones}
		if StructureContains Structure = ($stagediver_anims) name = <pak>
			anims = ($stagediver_anims.<pak>)
		else
			anims = ($stagediver_anims.`default`)
		endif
		GetArraySize <anims>
		GetRandomValue name = anim_index Integer a = 0 b = (<array_size> - 1)
		anim_name = (<anims> [<anim_index>])
		printf channel = Crowd "Playing stagedive anim %a ....." a = <anim_name>
		<stagediver> :GameObj_PlayAnim Anim = <anim_name>
		<stagediver> :GameObj_WaitAnimFinished
		<stagediver> :hide
	else
		printf \{channel = Crowd
			"Stagediver not found........."}
	endif
endscript
