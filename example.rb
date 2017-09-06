# Todo es un Objeto
# Ruby permite agregar metodos y variables de instancia
# a todos sus tipos de datos.
100.zero?

# String
'Hello'.reverse

# Todo Todo es un Objeto
nil.nil?

# String	    '   "	      "mi string"
# Simbolo	    :	          :symbol
# Array	      [ ]	        [1, 2, 3, 4, 5]
# Hash	      { }	        { key: 'value', other_key: 1234 }
# Rango	      ..          1..7
# Regex	      /	          /([0-9]+)/

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

juan = Hombre.new('Juan')
pedro = Persona.new('Pedro')
conversar juan, pedro

juan.respond_to? :hablar
# => true

juan.instance_of? Persona
# => false
juan.instance_of? Hombre
# => true

# Definicion de la Clase
class Chileno < Persona
  attr_accessor :id
  attr_reader :nombre

  def self.new_id
    rand 1000
  end

  # metodo inicializar
  def initialize(nombre = nil)
    self.id = Chileno.new_id
    super nombre || "NONAME#{id}"
  end
end

daniel = Chileno.new('Daniel')
# => #<Chileno:0x007ff4c2163280 @nombre="Daniel", @id=151>
puts daniel.id
puts daniel.nombre

# Permite jugar
module Jugador
  def jugar!
    p 'Jugando'
    @jugando = true
  end

  def jugando?
    @jugando || false
  end

  def descansar
    @jugando = false
  end
end

# Definicion de la Clase
class Futbolista < Chileno
  include Jugador
end

alexis = Futbolista.new('Alexis')
alexis.jugando?
alexis.jugar!
