import 'player_state.dart';
import '../context/music_player.dart';
import 'playing_state.dart';

class StoppedState implements PlayerState {
  @override
  void pressPlay(MusicPlayer player) {
    print("▶ Iniciando reproducción de '${player.currentTrack}'...");
    player.setState(PlayingState());
  }

  @override
  void pressPause(MusicPlayer player) {
    print("⚠ No hay reproducción en curso para pausar.");
  }

  @override
  void pressStop(MusicPlayer player) {
    print("⚠ El reproductor ya está detenido.");
  }
}