# Patrón Adapter (Adaptador)

## Descripción general

El Adapter es un patrón de diseño estructural que permite que objetos con interfaces incompatibles trabajen juntos. Actúa como un "traductor" que convierte la interfaz de una clase existente en la interfaz que el cliente espera, sin modificar el código original.

---

## Problema

Considera un sistema de pagos que trabaja con una interfaz moderna `ProcesadorPago`. En algún momento se necesita integrar una pasarela de pago heredada (`PasarelaLegacy`) que tiene una API completamente distinta: recibe el monto en centavos como entero y requiere un código de moneda explícito.

**Enfoque sin Adapter (problemático):**

```dart
// El cliente tiene que conocer los detalles de la API legacy
final legacy = PasarelaLegacy();
final centavos = (monto * 100).round();
legacy.realizarCobro(centavos, 'DOP');
```

El cliente acumula lógica de adaptación y no puede tratar ambas pasarelas de forma uniforme.

**Enfoque con Adapter:**

```dart
final List<ProcesadorPago> procesadores = [
  PasarelaModerna(),
  AdaptadorLegacy(PasarelaLegacy()),
];

for (final p in procesadores) {
  p.pagar(1500.50); // misma interfaz para ambas
}
```

El adaptador envuelve la clase legacy y traduce las llamadas; el cliente nunca sabe la diferencia.

---

## Estructura

| Componente | Rol |
|---|---|
| Target (`ProcesadorPago`) | Interfaz que el cliente espera usar |
| Adaptee (`PasarelaLegacy`) | Clase existente con interfaz incompatible |
| Adapter (`AdaptadorLegacy`) | Implementa la interfaz Target y delega en el Adaptee |
| Client (`main`) | Usa la interfaz Target sin conocer el Adaptee |

---

## Implementación en Dart

**1. Interfaz objetivo (Target)**

```dart
abstract class ProcesadorPago {
  void pagar(double monto);
}
```

**2. Clase incompatible (Adaptee)**

```dart
class PasarelaLegacy {
  void realizarCobro(int montoEnCentavos, String moneda) {
    print('Legacy: cobrando $montoEnCentavos centavos $moneda');
  }
}
```

**3. Adaptador**

```dart
class AdaptadorLegacy implements ProcesadorPago {
  final PasarelaLegacy _legacy;

  AdaptadorLegacy(this._legacy);

  @override
  void pagar(double monto) {
    final centavos = (monto * 100).round();
    _legacy.realizarCobro(centavos, 'DOP');
  }
}
```

**4. Implementación moderna (no necesita adaptador)**

```dart
class PasarelaModerna implements ProcesadorPago {
  @override
  void pagar(double monto) {
    print('Moderna: cobrando RD\$$monto');
  }
}
```

**5. Uso**

```dart
void main() {
  final List<ProcesadorPago> procesadores = [
    PasarelaModerna(),
    AdaptadorLegacy(PasarelaLegacy()),
  ];

  for (final p in procesadores) {
    p.pagar(1500.50);
  }
}
```

**Salida esperada:**

```text
Moderna: cobrando RD$1500.5
Legacy: cobrando 150050 centavos DOP
```

---

## Ventajas y desventajas

**Ventajas**
- Permite integrar clases incompatibles sin modificar su código fuente
- Aplica el principio de responsabilidad única: la lógica de traducción queda en el adaptador
- Aplica el principio abierto/cerrado: se pueden añadir adaptadores sin tocar el cliente
- Facilita la migración gradual de sistemas legacy

**Desventajas**
- Añade una capa adicional de indirección que puede complicar la lectura del código
- Si se necesitan adaptar muchos métodos, el adaptador puede volverse complejo
- No resuelve diferencias semánticas profundas entre interfaces

---

## Cuándo utilizarlo

Aplica el patrón Adapter cuando:

- Se necesita usar una clase existente cuya interfaz no es compatible con el resto del sistema
- Se quiere integrar código legacy o de terceros sin modificarlo
- Se requiere una capa de traducción entre dos sistemas con distintas convenciones
- Se está migrando gradualmente de una API antigua a una nueva

---

## Aplicaciones en Flutter

- Adaptar SDKs de terceros (Firebase, Stripe, etc.) a interfaces propias del dominio
- Integrar APIs REST con modelos de datos locales mediante repositorios adaptadores
- Conectar paquetes de almacenamiento distintos (SharedPreferences, Hive) bajo una misma interfaz
- Reutilizar widgets de librerías externas ajustándolos a la API de diseño propia

---

## Estructura del proyecto

```
adapter/
│
├── procesador_pago.dart
├── pasarela_legacy.dart
├── adaptador_legacy.dart
├── pasarela_moderna.dart
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart Structural/adapter/main.dart
```
