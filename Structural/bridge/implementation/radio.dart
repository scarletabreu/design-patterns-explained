import 'device.dart';

class Radio implements Device {
  @override
  void turnOn() {
    print("Radio encendida");
  }

  @override
  void turnOff() {
    print("Radio apagada");
  }

  @override
  void setVolume(int volume) {
    print("Radio volumen: $volume");
  }
}