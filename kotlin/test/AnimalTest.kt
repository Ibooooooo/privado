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
