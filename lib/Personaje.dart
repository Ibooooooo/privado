mixin Nadador 
{
  String nadar() => throw UnimplementedError("Debe implementar el método en la clase que use este mixin");
}

mixin Terrestre 
{
  String caminar() => throw UnimplementedError("Debe implementar el método en la clase que use este mixin");
}

mixin Volador 
{
  String volar() => throw UnimplementedError("Debe implementar el método en la clase que use este mixin");
}

sealed class Personaje
{
  String _nombre;
  int _ataque;
  int _vida;

  Personaje(this._nombre, this._ataque, this._vida);

  get getNombre => _nombre;
  get getVida => _vida;
  get getAtaque => _ataque;
  String describir();
}

class Elfo extends Personaje with Nadador, Terrestre, Volador 
{
  double _poderMagico;

  Elfo(String nombre, int ataque, int vida, this._poderMagico): super(nombre, ataque, vida);

  get getPoder => _poderMagico;

  @override
  String describir() => "Elfo $_nombre: $_ataque de ataque, $_vida de vida, daño mágico de $_poderMagico.";

  @override
  String nadar() => "$_nombre está nadando (Elfo)";

  @override
  String caminar() => "$_nombre está caminando (Elfo)";

  @override
  String volar() => "$_nombre está volando (Elfo)";
}

class Orco extends Personaje with Terrestre 
{
  double _poderFisico;

  get getPoder => _poderFisico;

  Orco(String nombre, int ataque, int vida, this._poderFisico): super(nombre, ataque, vida);

  @override
  String describir() => "Orco $_nombre: $_ataque de ataque, $_vida de vida, daño físico de $_poderFisico.";

  @override
  String caminar() => "$_nombre está caminando (Orco)";
}

class Humano extends Personaje with Terrestre, Volador 
{
  double _poderFisico;
  double _poderMagico;

  get getPoderFisico => _poderFisico;
  get getPoderMagico => _poderMagico;

  Humano(String nombre, int ataque, int vida, this._poderMagico, this._poderFisico): super(nombre, ataque, vida);

  @override
  String describir() => "Humano $_nombre: $_ataque de ataque, $_vida de vida, daño mágico de $_poderMagico, daño físico de $_poderFisico.";

  @override
  String caminar() => "$_nombre está caminando (Humano)";

  @override
  String volar() => "$_nombre está volando (Humano)";
}

void hacerNadar(Nadador nadador) => print(nadador.nadar());
void hacerCaminar(Terrestre terrestre) => print(terrestre.caminar());
void hacerVolar(Volador volador) => print(volador.volar());

// Cuando una clase es sealed, el compilador conoce todas sus subclases. Esto le permite: Verificar en tiempo de compilación que el switch cubre todas las posibilidades
String infoPoderDelPersonaje(Personaje p) 
{
  return switch (p) {
    Elfo e => "Poder mágico de: ${e.getPoder}",
    Orco o => "Poder físico de: ${o.getPoder}",
    Humano h => "Poder físico de ${h.getPoderFisico} y mágico de ${h.getPoderMagico}"
  };
}