import '../state/player_state.dart';
import '../state/stopped_state.dart';

class MusicPlayer {
  late PlayerState _state;
  String currentTrack = "Sin pista";

  MusicPlayer() {
    _state = StoppedState();
  }

  void setState(PlayerState state) => _state = state;

  void pressPlay() => _state.pressPlay(this);
  void pressPause() => _state.pressPause(this);
  void pressStop() => _state.pressStop(this);
}