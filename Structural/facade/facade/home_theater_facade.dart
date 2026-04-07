import '../subsystem/dvd_player.dart';
import '../subsystem/projector.dart';
import '../subsystem/amplifier.dart';
import '../subsystem/lights.dart';

class HomeTheaterFacade {
  final DVDPlayer dvd;
  final Projector projector;
  final Amplifier amplifier;
  final Lights lights;

  HomeTheaterFacade(this.dvd, this.projector, this.amplifier, this.lights);

  void watchMovie() {
    print("Preparando cine en casa...");
    lights.dim();
    projector.on();
    amplifier.on();
    amplifier.setVolume(10);
    dvd.on();
    dvd.play();
  }
}