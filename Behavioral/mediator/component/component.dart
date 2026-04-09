import '../mediator/mediator.dart';

abstract class Component {
  late Mediator mediator;

  void setMediator(Mediator m) => mediator = m;
}