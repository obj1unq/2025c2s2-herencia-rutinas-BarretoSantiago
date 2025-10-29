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
    //method kilosPorCaloríaQuePierde(rutina)
    method formula(rutina){
        return self.peso() - (rutina.caloriasQuemadas(self.tiempo())) / self.kilosPorCaloria()
    }
}

class PersonaSedentaria inherits Persona {
    var property tiempo = 0
    var property peso = 0
    const property kilosPorCaloria = 7000
    method verificarAplicarRutina(){
        if(peso < 50){
            self.error("no puede hacer la rutina, su peso es menor o igual de 50")
        }
    }
    method pesoAlRealizar(rutina){
        self.verificarAplicarRutina()
        return self.formula(rutina).truncate(3)
    }
}

class PersonaAtleta inherits Persona {
    const property tiempo = 90
    var property peso = 0
    const property kilosPorCaloria = 8000
    method pesoAlRealizar(rutina){
        self.verificarAplicarRutina(rutina)
        return (self.peso() - ((rutina.caloriasQuemadas(self.tiempo())/self.kilosPorCaloria())-1)).truncate(3)
    }
    method verificarAplicarRutina(rutina){
        if(rutina.caloriasQuemadas(tiempo) < 10000){
            self.error("no puede hacer la rutina, no quema las calorias minimas")
        }
    }
}

