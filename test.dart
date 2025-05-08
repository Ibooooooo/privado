import 'package:test/test.dart';
import 'Contenedor.dart';

void main() 
{
  group('Contenedor<Personaje>', () {
    test('Añadir personajes y contar total', () {
      final contenedor = Contenedor<Personaje>();
      contenedor.add(Elfo("Legolas", 80, 100, 90.0));
      contenedor.add(Orco("Thrall", 100, 150, 120.0));
      contenedor.add(Humano("Aragorn", 85, 110, 60.0, 70.0));
      expect(contenedor.totalPersonajes(), equals(3));
    });

    test('Descripción de Elfo', () {
      final elfo = Elfo("Legolas", 80, 100, 90.0);
      expect(
        elfo.describir(),
        equals("Elfo Legolas: 80 de ataque, 100 de vida, daño mágico de 90.0."),
      );
    });

    test('Poder del Orco', () {
      final orco = Orco("Thrall", 100, 150, 120.0);
      expect(infoPoderDelPersonaje(orco), equals("Poder físico de: 120.0"));
    });

    test('Poder del Humano', () {
      final humano = Humano("Aragorn", 85, 110, 60.0, 70.0);
      expect(infoPoderDelPersonaje(humano),
          equals("Poder físico de 70.0 y mágico de 60.0"));
    });

    test('Habilidades del Elfo', () {
      final elfo = Elfo("Elrond", 90, 110, 80.0);
      expect(elfo.nadar(), contains("nadando"));
      expect(elfo.caminar(), contains("caminando"));
      expect(elfo.volar(), contains("volando"));
    });

    test('Habilidades del Orco', () {
      final orco = Orco("Grom", 100, 130, 100.0);
      expect(orco.caminar(), contains("caminando"));
    });

    test('Habilidades del Humano', () {
      final humano = Humano("Gandalf", 95, 120, 150.0, 50.0);
      expect(humano.caminar(), contains("caminando"));
      expect(humano.volar(), contains("volando"));
    });
  });
}
