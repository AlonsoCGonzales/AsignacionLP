#!/usr/bin/ruby -w

# Codigo de prueba No hacer caso
require './individuo'

BEGIN {
  puts "Initializing Ruby Program\n"
}

END {
  puts "Terminating Ruby Program"
}

object = Array.new

for i in 0..1
  object[i] = Individuo.new
  object[i].generarV2
end

printArrayIndv(object)

#condicion = object[0].containUinBase
#puts "#{condicion}"

myArray = Array.new(2)

for i in 0..myArray.length-1
  myArray[i] = Individuo.new
end
#myArray =  object[0].shiftBases(object[1])

i1, i2 = object.sample(2)

myArray = i1.shiftBases(i2)

puts "\nResultado del Cambiazo"
printArrayIndv(myArray)

object = object + myArray

puts "\nNueva Poblacion"
printArrayIndv(object)

DeleteInd(object)
#Test(object)

puts "\n"

printArrayIndv(object)