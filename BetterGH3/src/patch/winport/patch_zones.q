script PlayMovieAndWait
	patch_zones
	if NotCD
		if ($show_movies = 0)
			return
		endif
	endif
	mark_unsafe_for_shutdown
	if NOT GotParam \{noblack}
		fadetoblack \{on
			time = 0
			alpha = 1.0
			z_priority = -10}
	endif
	if NOT GotParam \{noletterbox}
		GetDisplaySettings
		if (<widescreen> = true)
			SetScreen \{hardware_letterbox = 0}
		else
			SetScreen \{hardware_letterbox = 1}
		endif
	endif
	printf "Playing Movie %s" s = <movie>
	PlayMovie {TextureSlot = 0
		TexturePri = 1000
		no_looping
		no_hold
		<...>}
	Wait \{2
		gameframes}
	if GotParam \{noblack}
		fadetoblack \{off
			time = 0}
	endif
	NotHeld = 0
	begin
	if NOT IsMoviePlaying \{TextureSlot = 0}
		break
	endif
	GetButtonsPressed \{StartAndA}
	if NOT (<makes> = 0)
		if (<NotHeld> = 1)
			KillMovie \{TextureSlot = 0}
			break
		endif
	else
		NotHeld = 1
	endif
	Wait \{1
		gameframes}
	repeat
	if NOT GotParam \{noblack}
		Wait \{2
			gameframes}
		printf "Finished Playing Movie %s" s = <movie>
		fadetoblack \{off
			time = 0}
	endif
	if NOT GotParam \{noletterbox}
		SetScreen \{hardware_letterbox = 0}
	endif
	mark_safe_for_shutdown
endscript

zones_patched = 0

script patch_zones
	if ($zones_patched = 0)
		LoadPak \{'zones/_DONOTDELETE.pak'
			splitfile}
	endif
	change \{zones_patched = 1}
endscript
