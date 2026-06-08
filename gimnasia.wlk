class Rutina {

    method caloriasQuemadas(tiempo) {
        return 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()
    }
    
    method intensidad()
    method descanso(tiempo) 
}

class Running inherits Rutina {
    var intensidad 

    override method intensidad() {
        return  intensidad
    }

    override method descanso(tiempo) {
        return if (tiempo > 20) 5 else 2
    }
}

class Maraton inherits Running {

    override method caloriasQuemadas(tiempo) {
        return super(tiempo) * 2
    }
}

class Remo inherits Rutina {
    
    override method intensidad() {
        return 1.3
    } 
    
    override method descanso(tiempo) {
        return tiempo / 5
    }
}

class RemoDeCompeticion inherits Remo {
    
    override method intensidad() {
        return 1.7
    } 
    
    override method descanso(tiempo) {
        return (super(tiempo) - 3).max(2)
    }
}

class Persona {
    var property peso 

    method hacerRutina(rutina) {
        self.validarSiPuede(rutina)
        peso = peso - self.pesoPerdido(rutina)
    }

    method pesoPerdido(rutina) {
        return rutina.caloriasQuemadas(self.tiempoDeEjercicio()) / self.kilosPorCaloria()
    }

    method validarSiPuede(rutina) {
        if(not self.puedeHacer(rutina)){
            self.error(self.cartel(rutina))
        }
    }

    method tiempoDeEjercicio()
    method kilosPorCaloria()
    method puedeHacer(rutina)
    method cartel(rutina)
}

class Sedentario inherits Persona {
    var tiempoDeEjercicio 

    override method tiempoDeEjercicio() {
        return tiempoDeEjercicio
    } 

    override method kilosPorCaloria() {
        return 7000
    } 

    override method puedeHacer(rutina) {
        return peso > 50
    }

    override method cartel(rutina) {    
        return "No pesa mas de 50"
    }
}

class Atleta inherits Persona {
    
    override method tiempoDeEjercicio() {
        return 90
    }

    override method kilosPorCaloria() {
        return 8000
    }

    override method puedeHacer(rutina) {
        return rutina.caloriasQuemadas(self.tiempoDeEjercicio()) > 10000
    }

    override method cartel(rutina) {    
        return "No quema mas de 10.000 calorias"
    }
    
    override method pesoPerdido(rutina) {
        return super(rutina) - 1
    }
}

class Predio {
    const rutinas = []

    method totalCaloriasPara(persona) {
        return rutinas.sum({ rutina => rutina.caloriasQuemadas(persona.tiempoDeEjercicio()) })
    }

    method tieneRutinaTranquiPara(persona) {
        return rutinas.any({ rutina => rutina.caloriasQuemadas(persona.tiempoDeEjercicio()) < 500 })
    }

    method rutinaMasExigentePara(persona) {
        return rutinas.max({ rutina => rutina.caloriasQuemadas(persona.tiempoDeEjercicio()) })
    }
}

class ClubBarrial {
    const predios = []

    method mejorPredioPara(persona) {
        return predios.max({ predio => predio.totalCaloriasPara(persona) })
    }

    method prediosTranquisPara(persona) {
        return predios.filter({ predio => predio.tieneRutinaTranquiPara(persona) })
    }

    method rutinasMasExigentesPara(persona) {
        return predios.map({ predio => predio.rutinaMasExigentePara(persona) }).asSet()
    }
}
