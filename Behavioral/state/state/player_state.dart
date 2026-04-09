// Importación anticipada para evitar dependencia circular
import '../context/music_player.dart';

abstract class PlayerState {
  void pressPlay(MusicPlayer player);
  void pressPause(MusicPlayer player);
  void pressStop(MusicPlayer player);
}