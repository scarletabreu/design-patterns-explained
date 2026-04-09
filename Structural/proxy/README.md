# Patrón Proxy

## Descripción general

El Proxy es un patrón de diseño estructural que proporciona un sustituto o representante de otro objeto. El proxy controla el acceso al objeto real, permitiendo ejecutar acciones antes o después de que la solicitud llegue a él.

Los tipos más comunes son:
- **Proxy virtual**: difiere la creación costosa hasta que sea necesaria (lazy loading).
- **Proxy de protección**: controla el acceso según permisos.
- **Proxy remoto**: representa un objeto en otro espacio de memoria o red.
- **Proxy de caché**: almacena resultados para evitar operaciones repetidas.

---

## Problema

Considera una galería de imágenes que carga archivos de disco. Cargar cada imagen en el momento de crearla es costoso y lento, especialmente si el usuario nunca llega a verla.

**Enfoque sin Proxy (problemático):**

```dart
// Cada imagen se carga del disco al instanciarse, aunque no se muestre
final img1 = ImagenReal('foto1.png'); // carga inmediata
final img2 = ImagenReal('foto2.png'); // carga inmediata
```

Se desperdician recursos cargando imágenes que quizás nunca se visualizan.

**Enfoque con Proxy:**

```dart
final imagen = ProxyImagen('retrato.png');
// La imagen real no se carga aún

imagen.mostrar(); // solo aquí se carga del disco
imagen.mostrar(); // ya está en memoria, no recarga
```

El proxy difiere la carga hasta que sea estrictamente necesaria.

---

## Estructura

| Componente | Rol |
|---|---|
| Subject (`ServicioImagenes`) | Interfaz común para el objeto real y el proxy |
| Real Subject (`ImagenReal`) | Objeto costoso que realiza el trabajo real |
| Proxy (`ProxyImagen`) | Controla el acceso y crea el objeto real bajo demanda |
| Client (`main`) | Trabaja con la interfaz Subject, sin importarle si es proxy o real |

---

## Implementación en Dart

**1. Interfaz común (Subject)**

```dart
abstract class ServicioImagenes {
  void mostrar();
}
```

**2. Objeto real**

```dart
class ImagenReal implements ServicioImagenes {
  final String ruta;

  ImagenReal(this.ruta) {
    _cargarDesdeDisco();
  }

  void _cargarDesdeDisco() {
    print('Cargando $ruta desde disco...');
  }

  @override
  void mostrar() {
    print('Mostrando $ruta');
  }
}
```

**3. Proxy con lazy loading**

```dart
class ProxyImagen implements ServicioImagenes {
  final String ruta;
  ImagenReal? _imagen;

  ProxyImagen(this.ruta);

  @override
  void mostrar() {
    _imagen ??= ImagenReal(ruta); // crea el objeto real solo cuando se necesita
    _imagen!.mostrar();
  }
}
```

**4. Uso**

```dart
void main() {
  final imagen = ProxyImagen('retrato.png');
  print('Proxy creado, aún sin cargar.');

  imagen.mostrar(); // carga y muestra
  imagen.mostrar(); // solo muestra (ya está en memoria)
}
```

**Salida esperada:**

```text
Proxy creado, aún sin cargar.
Cargando retrato.png desde disco...
Mostrando retrato.png
Mostrando retrato.png
```

---

## Ventajas y desventajas

**Ventajas**
- Permite controlar el acceso al objeto real sin modificarlo
- Aplica lazy loading: el objeto costoso solo se crea cuando se necesita
- Puede añadir caché, logging o validación de forma transparente al cliente
- Aplica el principio abierto/cerrado: el proxy extiende comportamiento sin tocar el original

**Desventajas**
- Introduce una capa de indirección que puede añadir latencia
- Aumenta la complejidad del código con clases adicionales
- Si el proxy asume demasiadas responsabilidades, puede violar el principio de responsabilidad única

---

## Cuándo utilizarlo

Aplica el patrón Proxy cuando:

- Se necesita inicialización diferida (lazy initialization) de objetos pesados
- Se quiere controlar el acceso a un objeto según permisos o estado
- Se requiere logging, auditoría o caché transparente alrededor de un objeto
- El objeto real está en un servidor remoto y se necesita un representante local

---

## Aplicaciones en Flutter

- Lazy loading de imágenes en listas largas (similar a `CachedNetworkImage`)
- Proxies de repositorio que añaden caché local antes de consultar la red
- Proxies de autenticación que verifican sesión antes de llamar a servicios
- Wrappers de servicios remotos que manejan reintentos y timeouts de forma transparente

---

## Estructura del proyecto

```
proxy/
│
├── servicio_imagenes.dart
├── imagen_real.dart
├── proxy_imagen.dart
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart Structural/proxy/main.dart
```
