import kotlin.reflect.KProperty

// --------- Interfaces ---------

interface Sonido 
{
    fun hacerSonido()
}

interface Errante 
{
    fun caminar()
}

// --------- Implementaciones concretas ---------

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

// --------- Delegación de propiedades ---------

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

// --------- Clase principal: Animal ---------

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