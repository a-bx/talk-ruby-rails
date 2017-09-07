=begin
  Ruby es un lenguaje creado para la felicidad del Programador
  Es un lenguaje
    * Dinámico
    * Interpretado
    * Reflexivo
    * Orientado a Objetos
=end

# Todo es un Objeto
# Ruby permite agregar metodos y variables de instancia
# a todos sus tipos de datos.
100.zero?

# String
'Hello'.reverse

# Todo Todo es un Objeto
nil.nil?

# Shortcuts para crear objetos:
#
# String	    '   "	      "mi string"
# Simbolo	    :	          :symbol
# Array	      [ ]	        [1, 2, 3, 4, 5]
# Hash	      { }	        { key: 'value', other_key: 1234 }
# Rango	      ..          1..7
# Regex	      /	          /([0-9]+)/

########################################################################

# Definicion de la Clase
class Persona
  # metodo inicializar (equivalente al constructor)
  def initialize(nombre = 'NONAME001') # pasando un argumento con valor default
    @nombre = nombre # @ se utiliza para crear variables de instancia
  end

  # los metodos de instancia se crean con def
  def hablar
    # El objeto string permite interpolacion
    # puts es equivalente a System.Out.print()
    puts "Hola soy #{@nombre}"
  end
end

# Los objetos se instancian con Clase.new(argumentos-del-constructor)
pedro = Persona.new('Pedro')
# En ruby no se necesitan parentesis para invocar un metodo
pedro.hablar

# Class es un Objeto y se pueden crear nuevas clases de esta forma
Hombre = Class.new Persona # Hombre hereda de Persona
yo = Hombre.new
yo.hablar
# => Hola soy NONAME001

# Consultando los antecesores
Hombre.ancestors
# => [Hombre, Persona, Object, Kernel, BasicObject]

# Interfaces?
# No existen, en su defecto se utiliza el concepto
# de duck typing:
#   si habla como pato, si nada como pato, es un pato
def conversar(person_one, person_two)
  person_one.hablar
  person_two.hablar
end

juan = Hombre.new('Juan')
pedro = Persona.new('Pedro')
# Invocando el metodo conversar con 2 personas
conversar juan, pedro

# Si queremos verificar si un objeto responde a cierto mensaje (metodo)
juan.respond_to? :hablar
# => true

# Si queremos verificar si un objeto es de una determinada Clase
juan.instance_of? Persona
# => false
juan.instance_of? Hombre
# => true

# Definicion de la Clase
class Chileno < Persona
  # define getters y setters para el atributo id
  attr_accessor :id
  # define un getter para el atributo nombre
  attr_reader :nombre

  # self dentro de la clase se utiliza para crear
  # un metodo de clase accesible como Chileno.generate_id
  # en otros lenguajes: static method
  def self.generate_id
    rand 1000
  end

  def initialize(nombre = nil)
    # se genera un id con el metodo de la clase
    self.id = Chileno.generate_id
    # se invoca a super (el consutrctor de la clase persona)
    # si nombre es nulo, la evaluacion booleana
    # pasara a ese constructor nombre = 'NONAME<ID>'
    super nombre || "NONAME#{id}"
  end
end

daniel = Chileno.new('Daniel')
# => #<Chileno:0x007ff4c2163280 @nombre="Daniel", @id=151>
puts daniel.id
puts daniel.nombre

# MIXINS en vez de Herencia multiple
# Los modulos permiten, entre otras cosas, definir comportamientos
# Dentro de un modulo se pueden definir metodos y atributos
# que finalmente seran incluidos en otras clases, es la forma que ruby
# tiene para componer.

# Modulo Jugador: Permite jugar
module Jugador
  # por convencion el signo de exclamacion al final
  # nos indica que este mensaje cambiara al objeto
  # no hay ninguna diferencia tecnica
  def jugar!
    p 'Jugando' # p es equivalente a puts
    @jugando = true
  end

  # por convencion el signo de interrogacion al final
  # nos indica que este mensaje devuelve boolenao
  def jugando?
    # || es un OR; en este caso se evalua @jugando
    # si @jugando es nil, se evalua false
    # ruby devuelve siempre lo ultimo que evalua
    # no es necesario hacer return
    @jugando || false
  end

  def descansar
    @jugando = false
  end
end

# Definicion de la Clase
class Futbolista < Chileno
  include Jugador # incluye el comportamiento de un jugador
end

alexis = Futbolista.new('Alexis')
alexis.jugando?
alexis.jugar!
alexis.jugando?

# Azucar sintactico
class Estudiante < Chileno
  # getter para atributo carrera
  attr_reader :carrera

  # en este caso ambos argumentos son obligatorios para la construccion
  def initialize(nombre, carrera)
    # se ejecuta el consutrctor de la clase Chileno que solo recibe nombre
    super nombre
    # se asigna carrera
    @carrera = carrera
  end

  # se pueden definir metodos setters de esta forma
  # utilizando el signo = como parte del nobmre del metodo
  def carrera=(value)
    @carrera = value
  end
end

juanito = Estudiante.new('Juanito', 'ing. en computacion')
juanito.carrera
# se invoca de esta manera el setter
juanito.carrera=('nueva carrera')
# El azucar sintactico de ruby nos permite ir simplificando est allamada
# elimninar parentesis
juanito.carrera= 'nueva carrera'
# separar el caracter =
juanito.carrera = 'nueva carrera'

###################################
# Bloques
# son Trozos de codigo que se envuelven
# entre { .. } (singleline)
# o     do .. end  (multiline)

n = 10
# el metodo times de la clase FixNum
# recibe como parametro un bloque
# y lo ejecuta n veces
n.times do
  p "esto se repetirá #{n} veces"
end

# el metodo times ejecuta el bloque tambien pasandole argumentos
# en este caso se puede ver que los argumentos de los bloques
# se pueden recibir entre | argumentos.., .. |
# para el caso de times es un unico argumento de tipo FixNum
# que corresponde al index de la llamada
5.times { |i| puts i }

# La programacion funcional es bienvenida en Ruby
# y se aprovechan de los bloques
[1, 2, 3].reduce { |s, m| s + m }

#################################
# Ejemplo de utilizacion de bloques
# un metodo times que ejecuta un bloque
# pasado implicitamente
# este metodo aparentemente no recibe ningun parametro
# pero en ruby se pueden pasar implicitamente

def times
  if block_given? # metodo de kernel para verificar si viene un bloque
    p yield(1, 100) # yield ejecuta el bloque que se paso por parametros
  end
end

# aca ejecutamos a times pasandole un bloque
times do |num_one, num_two|
  puts "#{num_one} #{num_two}"
  # operar los dos numeros
  num_one + num_two
end

# lambda crea Procs que es basicamente convertir un bloque en un objeto
bloque = lambda { |i| puts i }
# este bloque de codigo puede ser invocado posteriormente
bloque.call 'parametro'
