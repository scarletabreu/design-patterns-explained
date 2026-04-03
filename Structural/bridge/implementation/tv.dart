import 'device.dart';

class TV implements Device {
  @override
  void turnOn() {
    print("TV encendida");
  }

  @override
  void turnOff() {
    print("TV apagada");
  }

  @override
  void setVolume(int volume) {
    print("TV volumen: $volume");
  }
}