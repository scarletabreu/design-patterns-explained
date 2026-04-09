# Patrón Strategy (Estrategia)

## Descripción general

El Strategy es un patrón de diseño de comportamiento que define una familia de algoritmos, encapsula cada uno en una clase separada y los hace intercambiables. Permite cambiar el algoritmo utilizado por un objeto en tiempo de ejecución sin modificar el objeto que lo usa.

---

## Problema

Considera un carrito de compras que puede aplicar distintos tipos de descuento: sin descuento, descuento porcentual o descuento fijo. Si la lógica de cada descuento vive dentro del carrito mediante condicionales, añadir un nuevo tipo de descuento implica modificar la clase `Carrito`.

**Enfoque sin Strategy (problemático):**

```dart
double total(String tipoDescuento) {
  if (tipoDescuento == 'porcentaje') {
    return subtotal * 0.85;
  } else if (tipoDescuento == 'fijo') {
    return subtotal - 250;
  }
  return subtotal;
}
```

Cada nuevo tipo de descuento exige modificar el carrito y la cadena de condicionales crece sin control.

**Enfoque con Strategy:**

```dart
carrito.estrategia = DescuentoPorcentaje(15);
print(carrito.total()); // delega en la estrategia

carrito.estrategia = DescuentoFijo(250);
print(carrito.total()); // cambia en tiempo de ejecución
```

El carrito delega el cálculo a la estrategia; no sabe ni le importa cómo se implementa.

---

## Estructura

| Componente | Rol |
|---|---|
| Strategy (`EstrategiaDescuento`) | Interfaz común para todos los algoritmos |
| Concrete Strategies | Implementaciones concretas del algoritmo |
| Context (`Carrito`) | Mantiene una referencia a la estrategia activa y la invoca |
| Client (`main`) | Elige e inyecta la estrategia adecuada en el contexto |

---

## Implementación en Dart

**1. Interfaz Strategy**

```dart
abstract class EstrategiaDescuento {
  double aplicar(double total);
}
```

**2. Estrategias concretas**

```dart
class SinDescuento implements EstrategiaDescuento {
  @override
  double aplicar(double total) => total;
}

class DescuentoPorcentaje implements EstrategiaDescuento {
  final double porcentaje;
  DescuentoPorcentaje(this.porcentaje);

  @override
  double aplicar(double total) => total * (1 - porcentaje / 100);
}

class DescuentoFijo implements EstrategiaDescuento {
  final double monto;
  DescuentoFijo(this.monto);

  @override
  double aplicar(double total) => (total - monto).clamp(0, double.infinity);
}
```

**3. Contexto**

```dart
class Carrito {
  final List<double> _items = [];
  EstrategiaDescuento estrategia;

  Carrito(this.estrategia);

  void agregar(double precio) => _items.add(precio);

  double total() {
    final subtotal = _items.fold(0.0, (a, b) => a + b);
    return estrategia.aplicar(subtotal);
  }
}
```

**4. Uso**

```dart
void main() {
  final carrito = Carrito(SinDescuento())
    ..agregar(500)
    ..agregar(1200)
    ..agregar(300);

  print('Sin descuento: RD\$${carrito.total()}');      // 2000.0

  carrito.estrategia = DescuentoPorcentaje(15);
  print('15% off: RD\$${carrito.total()}');            // 1700.0

  carrito.estrategia = DescuentoFijo(250);
  print('RD\$250 off: RD\$${carrito.total()}');        // 1750.0
}
```

**Salida esperada:**

```text
Sin descuento: RD$2000.0
15% off: RD$1700.0
RD$250 off: RD$1750.0
```

---

## Ventajas y desventajas

**Ventajas**
- Aplica el principio abierto/cerrado: nuevas estrategias sin modificar el contexto
- Elimina condicionales complejos al encapsular cada variante en su propia clase
- Permite cambiar el algoritmo en tiempo de ejecución
- Facilita las pruebas unitarias: cada estrategia se testea de forma aislada

**Desventajas**
- Si hay pocas variantes, introduce complejidad innecesaria frente a una simple función
- El cliente debe conocer las diferencias entre estrategias para elegir la correcta
- Puede resultar en muchas clases pequeñas si las estrategias son numerosas

---

## Cuándo utilizarlo

Aplica el patrón Strategy cuando:

- Existen múltiples variantes de un algoritmo y se quiere poder intercambiarlas
- Se quiere eliminar condicionales que seleccionan el comportamiento en tiempo de ejecución
- Los algoritmos usan datos que no deben ser expuestos al cliente
- Se necesitan distintas variantes de comportamiento que puedan combinarse o cambiarse dinámicamente

---

## Aplicaciones en Flutter

- Estrategias de validación en formularios (validar email, teléfono, NIF)
- Algoritmos de ordenación o filtrado intercambiables en listas
- Estrategias de autenticación (OAuth, email/password, biometría)
- Políticas de reintento en peticiones de red (exponential backoff, fixed delay, no retry)

---

## Estructura del proyecto

```
strategy/
│
├── estrategia_descuento.dart
├── sin_descuento.dart
├── descuento_porcentaje.dart
├── descuento_fijo.dart
├── carrito.dart
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart Behavioral/strategy/main.dart
```
