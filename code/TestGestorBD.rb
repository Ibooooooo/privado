require 'minitest/autorun'
require_relative 'GestorBD'

class TestGestorBD < Minitest::Test
  def setup # Se insertan los mismos datos siempre antes de cada test
    @archivo = "BD_test.txt"
    File.delete(@archivo) if File.exist?(@archivo)

    @bd = GestorBD.new(@archivo)
    @bd.insertar({ nombre: "Ana", edad: 45, ciudad: "Madrid", dinero: 1500.0 })
    @bd.insertar({ nombre: "Luis", edad: 28, ciudad: "Valencia", dinero: 700.0 })
    @bd.insertar({ nombre: "Marta", edad: 33, ciudad: "Bilbao", dinero: 1100.0 })
    @bd.insertar({ nombre: "Carlos", edad: 39, ciudad: "Sevilla", dinero: 800.0 })
  end

  def test_insertar
    assert_equal 4, @bd.buscar.size
  end

  def test_buscar_por_dinero
    ricos = @bd.buscar(->(f) { f[:dinero] > 1000 })
    assert_equal 2, ricos.size
    assert ricos.all? { |f| f[:dinero] > 1000 }
  end

  def test_actualizar_dinero
    @bd.actualizar(->(f) { f[:ciudad] == "Madrid" }, ->(f) { f[:dinero] += 200 })
    madrid = @bd.buscar(->(f) { f[:ciudad] == "Madrid" }).first
    assert_equal 1700.0, madrid[:dinero]
  end

  def test_eliminar
    @bd.eliminar(->(f) { f[:nombre] == "Luis" })
    todos = @bd.buscar
    assert_equal 3, todos.size
    refute todos.any? { |f| f[:nombre] == "Luis" }
  end

  def test_total_dinero_mayores_30
    # Se calcula el total de dinero de las personas mayores de 30 años (sin ordenar)
    total = @bd.buscar
      .select { |f| f[:edad] > 30 }
      .map { |f| f[:dinero] }
      .reduce(0.0, :+)
  
    totalEsperado = 1500.0 + 1100.0 + 800.0 
    assert_in_delta totalEsperado, total, 0.01
  end

  def test_ordenar_por_ciudad
    ordenadas = @bd.buscar
      .sort_by { |f| f[:ciudad] }
      .map { |f| f[:ciudad] }
    ordenEsperado = ["Bilbao", "Madrid", "Sevilla", "Valencia"]
    assert_equal ordenEsperado, ordenadas
  end
end