import 'player_state.dart';
import '../context/music_player.dart';
import 'paused_state.dart';
import 'stopped_state.dart';

class PlayingState implements PlayerState {
  @override
  void pressPlay(MusicPlayer player) {
    print("⚠ Ya se está reproduciendo '${player.currentTrack}'.");
  }

  @override
  void pressPause(MusicPlayer player) {
    print("⏸ Pausando reproducción...");
    player.setState(PausedState());
  }

  @override
  void pressStop(MusicPlayer player) {
    print("⏹ Deteniendo reproducción...");
    player.setState(StoppedState());
  }
}