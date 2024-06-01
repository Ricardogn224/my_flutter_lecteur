import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter_lecteur/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: 'So sick ',
      artistName: 'Neyo',
      albumArtImagePath: 'assets/images/node.png',
      audioPath: 'assets/audios/song.mp3',
    ),
    Song(
      songName: 'Acid Rap',
      artistName: 'Chance The Rapper',
      albumArtImagePath: 'assets/images/node.png',
      audioPath: 'assets/audios/song.mp3',
    ),
    Song(
      songName: 'Phénix',
      artistName: 'Chance The Rapper',
      albumArtImagePath: 'assets/images/node.png',
      audioPath: 'assets/audios/song.mp3',
    ),
  ];

  int? _currentSongIndex;

  /*
  
  A U D I O P L A Y E R 

  */

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

  // play song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); // play new song
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration duration) async {
    await _audioPlayer.seek(duration);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        _currentSongIndex = 0;
      }
    }
  }

  // play previous song

  void playPreviousSong() async {
    // if more than 2 seonds have passed, play from the beginning

    if (_currentDuration.inSeconds > 2) {
    }
    //if it's within first 2 segond of the song, go to previous song
    else {
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
      } else {
        _currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newDuration) {
      _currentDuration = newDuration;
      notifyListeners();
    });

    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose audio player

  //getter
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //setter

  set currentSongIndex(int? newIndex) {
    //update current song index

    _currentSongIndex = newIndex;

    if (newIndex != null) {
      // play the song
      play();
    }

    // update UI
    notifyListeners();
  }
}
