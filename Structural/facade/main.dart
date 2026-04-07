import 'facade/home_theater_facade.dart';
import 'subsystem/dvd_player.dart';
import 'subsystem/projector.dart';
import 'subsystem/amplifier.dart';
import 'subsystem/lights.dart';

void main() {
  final facade = HomeTheaterFacade(
    DVDPlayer(),
    Projector(),
    Amplifier(),
    Lights(),
  );

  facade.watchMovie();
}