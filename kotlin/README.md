# Ejemplo de Delegación con Kotlin
---

## Implementación

Este ejemplo muestra los mecanismos de delegación en Kotlin 
usando un sistema de clases y comportamientos para simular un zoológico.

### `Animal.kt`

```kotlin
import kotlin.reflect.KProperty

interface Sonido 
{
    fun hacerSonido()
}

interface Errante 
{
    fun caminar()
}

// --------- CLASES ---------

class Rugido: Sonido 
{
    override fun hacerSonido() = println("¡ROOAAARR!")
}

class Canto: Sonido 
{
    override fun hacerSonido() = println("cantando...")
}

class CaminataPesada: Errante 
{
    override fun caminar() = println("Caminando con pasos pesados.")
}

class CaminataLigera: Errante
{
    override fun caminar() = println("Caminando ágilmente.")
}

class Observacion<T>(private var valor: T) 
{
    operator fun getValue(thisRef: Any?, property: KProperty<*>): T 
    {
        println("Observando '${property.name}': $valor")
        return valor
    }

    operator fun setValue(thisRef: Any?, property: KProperty<*>, nuevoValor: T) 
    {
        println("Cambiando '${property.name}' a: $nuevoValor")
        valor = nuevoValor
    }
}

// --------- Clase principal ---------
class Animal(sonido: Sonido, private val Errante: Errante): Sonido by sonido 
{
    var nombre: String by Observacion("Desconocido")
    var habitat: String by Observacion("Sin definir")

    fun moverse()
    {
        println("El animal se prepara para moverse...")
        Errante.caminar()
    }

    fun describir() 
    {
        println("* Ficha del animal:")
        println("\t- Nombre: $nombre")
        println("\t- Hábitat: $habitat")
    }
}
```
Este archivo contiene toda la lógica central del modelo. Incluye:

#### 1. **Interfaces de comportamiento**
Se definen dos interfaces:  
- `Sonido`: representa el comportamiento de emitir un sonido.  
- `Errante`: representa el comportamiento de moverse o caminar.

#### 2. **Implementaciones concretas**
Clases que implementan los comportamientos anteriores para representar animales distintos:

- `Rugido` y `Canto` implementan `Sonido`.  
- `CaminataPesada` y `CaminataLigera` implementan `Errante`.

#### 3. **Delegación de propiedades**
Se define una clase genérica `Observacion<T>`, que actúa como **delegado de propiedades** usando los operadores `getValue` y `setValue`. Esta clase imprime mensajes cuando una propiedad se accede o se modifica.

```kotlin
var nombre: String by Observacion("Desconocido")
var habitat: String by Observacion("Sin definir")
```
Estas propiedades **delegan** su lógica de lectura/escritura a una instancia de **Observacion**, permitiendo observar cambios sin alterar el diseño del **Animal**.

#### 4. **Clase *Animal***
Es la clase principal donde se puede ver reflejado el uso de la **delegación** de 3 formas distintas:

```kotlin
class Animal(sonido: Sonido, private val Errante: Errante) : Sonido by sonido
```

* *Delegación automática*

    El método **hacerSonido()** no se define en **Animal**, se delegará automáticamente al objeto **Sonido** recibido en el constructor.

* *Composición manual*

    El objeto **Errante** se almacena como atributo privado y se invoca manualmente.

* *Delegación de propiedades*

    Las propiedades **nombre** y **habitat** usan **Observacion** para imprimir acciones cada vez que se modifican o consultan.

### `AnimalTest.kt`

```kotlin
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assertions.assertEquals

class AnimalTest 
{
    @Test
    fun `el leon debe rugir y caminar pesadamente`() 
    {
        val leon = Animal(Rugido(), CaminataPesada())
        leon.nombre = "León"
        leon.habitat = "Sabana"

        // Comprobamos que los valores se asignaron correctamente
        assertEquals("León", leon.nombre)
        assertEquals("Sabana", leon.habitat)

        println("\n> Test: Rugido y caminata pesada")
        leon.hacerSonido()
        leon.moverse()
        leon.describir()
    }

    @Test
    fun `el pajaro debe cantar y caminar ligeramente`() 
    {
        val pajaro = Animal(Canto(), CaminataLigera())
        pajaro.nombre = "Periquito"
        pajaro.habitat = "Bosque"

        assertEquals("Periquito", pajaro.nombre)
        assertEquals("Bosque", pajaro.habitat)

        println("\n> Test: Canto y caminata ligera")
        pajaro.hacerSonido()
        pajaro.moverse()
        pajaro.describir()
    }
}
```
Este archivo contiene pruebas unitarias utilizando **JUnit 5**. Se realizan pruebas sobre diferentes instancias de `Animal`, verificando que los valores de propiedades se actualizan correctamente y que los métodos delegados funcionan como se espera.
Cada test:

* Crea un `Animal` con distintos comportamientos.
* Modifica **nombre** y **habitat**.
* Llama a `hacerSonido()`, `moverse()` y `describir()`.
* Verifica los valores con `assertEquals`.

Esto asegura que la delegación se comporta correctamente tanto en ejecución como en pruebas automatizadas.

---

## Implantación
