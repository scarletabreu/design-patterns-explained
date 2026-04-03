class House {
  int windows = 0;
  int doors = 0;
  bool hasGarage = false;
  bool hasSwimmingPool = false;
  String wallColor = "White";

  void showDetails() {
    print("--- Detalles de la Casa ---");
    print("Ventanas: $windows | Puertas: $doors");
    print("Color de paredes: $wallColor");
    print("Garaje: ${hasGarage ? 'Sí' : 'No'}");
    print("Piscina: ${hasSwimmingPool ? 'Sí' : 'No'}");
    print("---------------------------\n");
  }
}