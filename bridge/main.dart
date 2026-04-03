import 'abstraction/advanced_remote.dart';
import 'implementation/tv.dart';
import 'implementation/radio.dart';

void main() {
  final tv = TV();
  final radio = Radio();

  final remote1 = AdvancedRemote(tv);
  remote1.togglePower();
  remote1.volumeUp();
  remote1.mute();

  print("------");

  final remote2 = AdvancedRemote(radio);
  remote2.togglePower();
  remote2.volumeUp();
  remote2.mute();
}