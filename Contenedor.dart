import 'Personaje.dart';
export 'Personaje.dart';

class Contenedor<T extends Personaje> 
{
  final List<T> _personajes = [];

  void add(T personaje) => _personajes.add(personaje);

  void mostrarDetalles() 
  {
    for (var p in _personajes) 
    {
      print("> ${p.describir()}");
      print("INFO: ${infoPoderDelPersonaje(p)}");

      if(p is Nadador) hacerNadar(p as Nadador);
      if(p is Terrestre) hacerCaminar(p as Terrestre);
      if(p is Volador) hacerVolar(p as Volador);

      print("═" * 40);
    }
  }

  int totalPersonajes() => _personajes.length;
}
