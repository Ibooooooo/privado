class GestorBD
  attr_reader :archivo

  def initialize(archivo)
    @archivo = archivo
    @tabla = []
    cargar
  end

  def cargar
    return unless File.exist?(@archivo)

    File.readlines(@archivo, chomp: true).each do |linea|
      nombre, edad, ciudad, dinero = linea.split(',').map(&:strip)
      @tabla << {
        nombre: nombre,
        edad: edad.to_i,
        ciudad: ciudad,
        dinero: dinero.to_f
      }
    end
  end

  def guardar
    File.open(@archivo, 'w') do |f|
      @tabla.each do |fila|
        f.puts [fila[:nombre], fila[:edad], fila[:ciudad], fila[:dinero]].join(',')
      end
    end
  end

  def insertar(fila)
    @tabla << fila
    guardar
  end

  def buscar(filtro = nil, transformador = nil)
    resultado = filtro ? @tabla.select(&filtro) : @tabla
    transformador ? resultado.map(&transformador) : resultado
  end

  def actualizar(filtro, transformador)
    modificadas = false
    @tabla.each do |fila|
      if filtro.call(fila)
        transformador.call(fila)
        modificadas = true
      end
    end
    guardar if modificadas
  end

  def eliminar(filtro)
    eliminados = @tabla.select(&filtro)
    eliminados.each do |fila|
      @tabla.delete(fila)
    end
    guardar unless eliminados.empty?
  end
end
