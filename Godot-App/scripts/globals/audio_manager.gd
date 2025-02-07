extends AudioStreamPlayer

const GAME_MUSIC = preload("res://assets/Musics/Kitchen Dreams.mp3")

func _play_music(music: AudioStream, volume: float = 0.0):
	if stream == music and playing:
		return  # Évite de relancer la même musique
	
	stream = music
	volume_db = volume
	play()

func _play_game_music():
	_play_music(GAME_MUSIC)
