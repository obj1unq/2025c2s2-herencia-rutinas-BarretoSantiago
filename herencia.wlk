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
    }
}
class Remo inherits Rutina{
    override method intensidad() = 1.3
    override method descanso(tiempo) = tiempo/5


}
class RemoCompeticion inherits Remo {
    override method intensidad()= 1.7
    override method descanso(tiempo) = 2.max((tiempo/5) - 3)
}