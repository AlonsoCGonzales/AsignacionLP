
# Esta funcion elimina los individuos que se componen de al menos una base de tipo 'U'
# dentro del arreglo definido como argumento y retorna la cantidad que fueron eliminados
def DeleteInd(indvs)
  deleted = 0
  for value in indvs do
    if value.containUinBase == true
      indvs.delete_at(getIndex(indvs,value.getNitrogenado))
      deleted = deleted + 1
      deleted = deleted + DeleteInd(indvs)
    end
  end

  return deleted
end

# Esta funcion devuelve el indice de una base nitrogenada dentro del arreglo del Nitrogenado
def getIndex(array, string)
  for i in 0..array.length-1
    if array[i].getNitrogenado == string
      return i
    end
  end
end

# Aqui se imprimen las bases de todos los individuos dentro del argumento 'array'
def printArrayIndv(array)
  for i in 0..array.length-1
    array[i].printBases
    puts "\n"
  end
end

class Individuo

  # Este metodo para generar las bases nitrogenadas es de prueba no constituye la version definitiva
  def generar
    @nitrogenado = []

    while @nitrogenado.length<30
      prob = rand(100)
      if prob <= 50
        @nitrogenado.push('A')
      elsif prob > 50 and prob <= 80
        @nitrogenado.push('T')
      else
        prob = rand(100)
        if prob <=30
          @nitrogenado.push('U')
        elsif prob > 30 and prob <= 70
          @nitrogenado.push('C')
        else
          @nitrogenado.push('G')
        end
      end
    end
  end
  
  # Metodo para generar las bases Nitrogenadas que se distribuyen de la sgte manera:
  # A => 0.40
  # T => 0.30
  # U => 0.15
  # C => 0.10
  # G => 0.05
  def generarV2
    @nitrogenado = []

    while @nitrogenado.length<30
      prob = rand(100) # esta operacion no debuelve un numero al azar <0;100>
      if prob <= 40 # 0.40
        @nitrogenado.push('A')
      elsif prob > 40 and prob <= 70 # 0.30
        @nitrogenado.push('T')
      elsif prob > 70 and prob <= 85 # 0.15
        @nitrogenado.push('U')
      elsif prob > 85 and prob <= 95 # 0.10
        @nitrogenado.push('C')
      else # 0.05
        @nitrogenado.push('G')
      end
    end
  end

  # Getters y Setters
  def getBase(i)
    return @nitrogenado[i]
  end

  def getNitrogenado
    @nitrogenado
  end

  def setNitrogenado(array)
    @nitrogenado = array
  end

  # Este metodo cambia de manera al azar con una probabilidad del 5% una base nitrogenada a la
  # bae se 'U'
  def setUBase
    for i in 0..@nitrogenado.length-1
      prob = rand(100)

      if prob <= 5
        @nitrogenado[i] = 'U'
      end
    end
  end

  # Esta funcion devuelve true si el individuo contiene mas del 40% de su estructura
  # Compuesta por 'A' o 'T'
  def baseContainMinAT
    n = 0
    for value in self.getNitrogenado do
      if value == 'A' or value == 'T'
        n=n+1
      end
    end

    if n < 12
      return false
    else
      return true
    end
  end

  # Este metodo imprime las bases nitrogenadas del individuo
  def printBases
    for value in self.getNitrogenado do
      putc "#{value}"
    end
  end

  # Con este otro metodo verificamos si el individuo tiene el componente U en su estructura
  # nitrogenada
  def containUinBase
    containU = false
    for value in @nitrogenado do
      if value == 'U'
        containU = true
        break
      end
    end
    
    return containU
  end

  # En este apartado se realiza el intercambio de los extremos al azar de las bases
  # entre dos individuos si es que estos cumplen la condicion de estar conformados por bases
  # A y T en su estructura
  def shiftBases(inv)
    if baseContainMinAT and inv.baseContainMinAT
      #puts "\nSe puede hacer el cambiazo\n"
      newInv = Array.new(2)
      newInv[0] = []
      newInv[1] = []

      # Se realiza los cortes al azar de los extremos de las bases de los individuos que haran
      # el intercambio para generar otros 2 nuevos individuos con las extremos de estas bases
      # alternadas

      # Ej: ACATT | CTTTAAGAATAATATTTTTA | TAAAA
      #        Corte b                Corte a
      cuta = rand(10) + 20
      cutb = rand(10)
      # Se captura los arrays de los nitrogenados de los individuos
      array1 = self.getNitrogenado
      array2 = inv.getNitrogenado

      # Estos arrays almacenaran las bases nitrogenadas de los 2 individuos generados
      # mencionadso previamente con las bases hasta los cortes realizados
      partA1 = []
      partB1 = []
      partA2 = []
      partB2 = []

      # En esta serie de for's las variables temporales partA1 partB1 partA2 partB2
      # guardan las bases hasta los cortes realizados

      # Bases del primer individuo
      for i in 0..cutb
        partA1[i] = array1[i]
      end

      for j in cuta..array1.length-1
        partB1[j] = array1[j]
      end

      # Bases del segundo individuo
      for i in 0..cutb
        partA2[i] = array2[i]
      end

      for j in cuta..array2.length-1
        partB2[j] = array2[j]
      end

      newInv[0] = partA1
      newInv[1] = partA2

=begin
      puts "corte a: #{cuta}"
      puts "corte b: #{cutb}"

      puts "\nCorte del primer individuo"
      for value in partA1 do
        putc "#{value}"
      end
      puts "\n"
      for value in partB1 do
        putc "#{value}"
      end
      puts "\nCorte del segundo individuo"
      for value in partA2 do
        putc "#{value}"
      end
      puts "\n"
      for value in partB2 do
        putc "#{value}"
      end
=end
      # Finalmente se hace el pusheo de las baes
      for i in cutb+1..cuta-1
        newInv[0].push(inv.getBase(i))
      end

      for i in cuta..29
        newInv[0].push(partB1[i])
      end

      for i in cutb+1..cuta-1
        newInv[1].push(self.getBase(i))
      end

      for i in cuta..29
        newInv[1].push(partB2[i])
      end

      # Se contruyen los individuos a retornar
      newInd = Array.new(2)
      newInd[0] = Individuo.new
      newInd[1] = Individuo.new

      # A cada uno de los nuevos elementos generados
      # se les asigna el nitrogenado producto de realizar el cambio
      newInd[0].setNitrogenado(newInv[0])
      newInd[1].setNitrogenado(newInv[1])

      return newInd[0], newInd[1]
    else
      puts "\nNo se puede hacer el cambiazo"
    end
  end
end