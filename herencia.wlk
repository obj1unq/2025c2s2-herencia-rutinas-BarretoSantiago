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
    } // preguntar si puedo hacer la method formula y multiplicar por 2
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
       return rutina.caloriasQuemadas(self.tiempo())/ self.kilosPorCaloria()
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
        return peso < 50
    }
}


class PersonaAtleta inherits Persona {
    const property tiempo = 90
    var property peso = 0
    const property kilosPorCaloria = 8000
    method pesoAlRealizar(rutina){
        self.verificarAplicarRutina(rutina)
        return (self.peso() - self.pesoQuePierde(rutina)-1).truncate(3)
    }
    method verificarAplicarRutina(rutina){
        if(not self.puedeRealizar(rutina)){
            self.error("no puede hacer la rutina, no quema las calorias minimas")
        }
    }
    override method puedeRealizar(rutina){

    }
}

