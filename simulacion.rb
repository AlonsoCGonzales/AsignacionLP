require './individuo'
# Esta es la simulacion oficial que genera 100 individuos, hace las 100 interacciones
# y elimina los que no tengan la base U dentrode sus componentes
object = Array.new
myArray = Array.new(2)

# Construccion y generacion de los individuos dentro del ecosistema
for i in 0..99
  object[i] = Individuo.new
  object[i].generarV2
end

# Este array almacenara temporalmente los individuos generados
for i in 0..myArray.length-1
  myArray[i] = Individuo.new
end

n = 1
generados = 0
interacciones = 0
eliminados = 0
#printArrayIndv(object)

while n <= 100
  # Si hay mas de 2 individuos dentro del arrya se procede a realizar el intercambio
  if object.length >= 2
    i1, i2 = object.sample(2) 
    # La funcion sample lo que hace es arrojar, en este caso, 2 indivuos dentro del array
    # aleatoriamente para que hagan la interaccion o shift de los extremos de sus bases
    myArray = i1.shiftBases(i2) # Aqui se capturan los indivduos generados
    interacciones=interacciones+1
  end
  object = object+ myArray
  n=n+1
end

# Finalmente se eliminan los individuos que tengan la base U en su estructura
eliminados = DeleteInd(object)

puts "Individuos resultantes"
printArrayIndv(object)
puts "\nCantidad de individuos eliminados"
puts "#{eliminados}"
puts "\nCantidad de interacciones"
puts "#{interacciones}"

# Nota no se utilizo el metodo setUBase la cual cambia una base a 'U' con una probabilidad 
# del 5% por que de todos modos la posibilidad que se genere esta base es del 15% lo cual es
# relativamente alto