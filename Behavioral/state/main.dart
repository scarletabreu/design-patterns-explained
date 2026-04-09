import 'context/music_player.dart';

void main() {
  final player = MusicPlayer();
  player.currentTrack = "Bohemian Rhapsody";

  player.pressPlay();
  player.pressPlay();   // sin efecto
  player.pressPause();
  player.pressPlay();   // reanuda
  player.pressStop();
  player.pressPause();  // sin efecto
}