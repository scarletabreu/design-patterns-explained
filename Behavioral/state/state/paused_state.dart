import 'player_state.dart';
import '../context/music_player.dart';
import 'playing_state.dart';
import 'stopped_state.dart';

class PausedState implements PlayerState {
  @override
  void pressPlay(MusicPlayer player) {
    print("▶ Reanudando reproducción de '${player.currentTrack}'...");
    player.setState(PlayingState());
  }

  @override
  void pressPause(MusicPlayer player) {
    print("⚠ La reproducción ya está pausada.");
  }

  @override
  void pressStop(MusicPlayer player) {
    print("⏹ Deteniendo desde pausa...");
    player.setState(StoppedState());
  }
}