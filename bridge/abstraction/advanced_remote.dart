import 'remote_control.dart';

class AdvancedRemote extends RemoteControl {
  AdvancedRemote(super.device);

  void mute() {
    print("Muting device...");
    device.setVolume(0);
  }
}