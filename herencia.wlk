class Rutina {
    method intensidad()
    method descanso(tiempo)
    method caloriasQuemadas(tiempo) {
        return 100 * (tiempo-self.descanso(tiempo))*self.intensidad()
    }
}
class Running inherits Rutina{
    var property intensidad = 0
    override method descanso(tiempo){
        return if (tiempo > 20){
            5
        } else {
            2
        }
    }
    override method intensidad() = intensidad
}
class Maraton inherits Running{
    override method caloriasQuemadas(tiempo){
       return 100 * (tiempo-self.descanso(tiempo))*self.intensidad() * 2
    } // hace un super flaco
}
class Remo inherits Rutina{
    override method intensidad() = 1.3
    override method descanso(tiempo) = tiempo/5


}
class RemoCompeticion inherits Remo {
    override method intensidad()= 1.7
    override method descanso(tiempo) = 2.max((tiempo/5) - 3)
} 

class Persona {
    method tiempo()
    method peso()
    method kilosPorCaloria()
    method pesoAlRealizar(rutina)
    method pesoQuePierde(rutina){
       return (rutina.caloriasQuemadas(self.tiempo())/ self.kilosPorCaloria())
    }
    method verificarRutina(rutina){
        if(not self.puedeRealizar(rutina)){
            self.error("no puede hacer la rutina")
        }
    }
    method puedeRealizar(rutina)
}

class PersonaSedentaria inherits Persona {
    const property tiempo 
    var property peso
    const property kilosPorCaloria = 7000
    override method pesoAlRealizar(rutina){
        self.verificarRutina(rutina)
        peso = (peso - self.pesoQuePierde(rutina)).truncate(3)
    }
    override method puedeRealizar(rutina){
        return peso > 50
    }
}


class PersonaAtleta inherits Persona {
    const property tiempo = 90
    var property peso = 0
    const property kilosPorCaloria = 8000
    override method pesoQuePierde(rutina){
        return super(rutina) -1
    }
    override method pesoAlRealizar(rutina){
        self.verificarRutina(rutina)
        peso = (peso - self.pesoQuePierde(rutina)).truncate(3)
    }
    override method puedeRealizar(rutina){
        return rutina.caloriasQuemadas(self.tiempo())>10000
    }
}


class Club{
    const predios
    method mejorPredio(persona){
        return predios.max({predio => predio.caloriasTotalesPara(persona)})
    }
    method prediosTranquis(persona){
        return predios.filter({predio => predio.esTranquiPara(persona)})
    }
    method rutinasMasexigentesClub(persona){
        return predios.map({predio => predio.rutinaMasExigentePara(persona)}).asSet()
    }
}
class Predio{
    const rutinas 
    method caloriasTotalesPara(persona){
        return rutinas.sum({rutina => rutina.caloriasQuemadas(persona.tiempo())})
    }
    method esTranquiPara(persona){
        return rutinas.any({rutina => rutina.caloriasQuemadas(persona.tiempo()) < 500})
    }
    method rutinaMasExigentePara(persona){
        return rutinas.max({rutina => rutina.caloriasQuemadas(persona.tiempo())})
    }

}

