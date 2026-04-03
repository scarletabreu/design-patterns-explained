import '../implementation/device.dart';

class RemoteControl {
  final Device device;

  RemoteControl(this.device);

  void togglePower() {
    print("Toggling power...");
    device.turnOn();
  }

  void volumeUp() {
    device.setVolume(10);
  }
}