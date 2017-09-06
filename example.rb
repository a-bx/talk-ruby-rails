# Todo es un Objeto
# Ruby permite agregar metodos y variables de instancia
# a todos sus tipos de datos.
100.zero?

# String
'Hello'.reverse

# Todo Todo es un Objeto
nil.nil?

########################################################################

# Definicion de la Clase
class Persona
  # metodo inicializar
  def initialize(nombre = 'NONAME001')
    @nombre = nombre
  end

  def hablar
    puts "Hola soy #{@nombre}"
  end
end

pedro = Persona.new('Pedro')
pedro.hablar

# Class es un Objeto 💥💥💥💥
Hombre = Class.new Persona
yo = Hombre.new
yo.hablar
# => Hola soy NONAME001
Hombre.ancestors
# => [Hombre, Persona, Object, Kernel, BasicObject]

# Interfaces?
def conversar(person_one, person_two)
  person_one.hablar
  person_two.hablar
end

conversar Hombre.new('Juan'), Persona.new('Pedro')
