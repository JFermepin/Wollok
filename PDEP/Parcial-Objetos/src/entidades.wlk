import main.*

class Bot{
	
	var property cargaElectrica = null
	var property aceite = null

	method impactaHechizo(_hechizero, _hechizo){
		if(_hechizo.nombre() == "Inmobilus"){
			cargaElectrica = cargaElectrica - 50 
		}
		if(_hechizo.nombre() == "Sectum Sempra"){
			if(_hechizero.experimentado()){
				aceite = "Sucio"
			}
		}
		if(_hechizo.nombre() == "Avadakedabra"){
			if((_hechizero.aceite() == "Sucio") || (_hechizero.casa().esPeligrosa())){
				cargaElectrica = 0
			}
		}
		if(_hechizo.nombre() == "Expecto Patronum"){
			if(_hechizero.cargaElectrica() > 80){
				cargaElectrica = cargaElectrica - 120
			}
		}
	}

	method estaActivo() = cargaElectrica > 0

}

class BotEstudiante inherits Bot{
	var property casa = null
	var property hechizosAprendidos = []
	var property experimentado = false
		
	method asistirAMateria(_materia){
		
		_materia.profesorAsignado().materiasDictadas(_materia.profesorAsignado().materiasDictadas() + 1)
		_materia.profesorAsignado().esExperimentado()
		
		if(!hechizosAprendidos.contains(_materia.hechizoEnsenado()))
		{
			hechizosAprendidos.add(_materia.hechizoEnsenado())
			self.esExperimentado()
		}
	}
	
	method esExperimentado(){
		if(hechizosAprendidos.size() > 3){
			experimentado = true
		}else{
			experimentado = false
		}
	}
		
	
	method lanzarHechizo(_hechizo, _bot){
		if((self.estaActivo()) && (hechizosAprendidos.contains(_hechizo))){
			_bot.impactaHechizo(self, _hechizo)
		}
	}
	
	override method impactaHechizo(_hechizero, _hechizo){
		
		if(_hechizo.nombre() == "Inmobilus"){
			cargaElectrica = cargaElectrica - 50 
		}
		if(_hechizo.nombre() == "Sectum Sempra"){
			if(_hechizero.experimentado()){
				aceite = "Sucio"
			}
		}
		if(_hechizo.nombre() == "Avadakedabra"){
			if((_hechizero.aceite() == "Sucio") || (_hechizero.casa().esPeligrosa())){
				cargaElectrica = 0
			}
		}
		if(_hechizo.nombre() == "Expecto Patronum"){
			if(_hechizero.cargaElectrica() > 80){
				cargaElectrica = cargaElectrica - 120
			}
		}		
		if(_hechizo.nombre() == "Olvidus"){
			hechizosAprendidos.remove(hechizosAprendidos.last())
		}
		
		/*
		if(_hechizo.nombre() == "Olvidus"){
			hechizosAprendidos.remove(hechizosAprendidos.last())
		}else{
			super(_hechizero, _hechizo)
		}
		*/
	}
}

class BotProfesor inherits BotEstudiante{
	
	var property materiasDictadas
	
	override method esExperimentado(){
		if(materiasDictadas >= 2){
			experimentado = true
		}else{
			experimentado = false
		}
	}
	
	override method impactaHechizo(_hechizero, _hechizo){
		if((_hechizo.nombre() == "Expecto Patronum") || (_hechizo.nombre() == "Inmobilus")){
			//NO LE RESTAN CARGA ELECTRICA
		}
		if(_hechizo.nombre() == "Avadakedabra"){
			cargaElectrica = (cargaElectrica/2).truncate(0)
		}		
		if(_hechizo.nombre() == "Sectum Sempra"){
			if(_hechizero.experimentado()){
				aceite = "Sucio"
			}
		}
		if(_hechizo.nombre() == "Olvidus"){
			hechizosAprendidos.remove(hechizosAprendidos.last())
		}
		
		/*
		if((_hechizo.nombre() == "Expecto Patronum") || (_hechizo.nombre() == "Inmobilus")){
			//NO LE RESTAN CARGA ELECTRICA
		}
		if(_hechizo.nombre() == "Avadakedabra"){
			cargaElectrica = (cargaElectrica/2).truncate(0)
		}else{
			super(_hechizero, _hechizo)
		}
		*/
	}
	
}

object botSeleccionador inherits Bot{
	
	var indice = 0
	var property casas = [gryffindor,slytherin,ravenclaw,hufflepuff]
	
	method determinarCasa(_estudiante){
		var casaSeleccionada = casas.get(indice)
		
		_estudiante.casa(casaSeleccionada)
		casaSeleccionada.agregarEstudiante(_estudiante)
		
		indice++
		
		if(indice == casas.size() ){
			indice = 0
		}
	}
	
	override method impactaHechizo(_hechizero, _hechizo){
		if(_hechizo.nombre() == "Sectum Sempra"){
			//NO LE CAMBIAN EL ACEITE
		}else{
			super(_hechizero, _hechizo)
		}
		
	}
	
}

/**********/

class Casa{
	
	const nombre
	const property integrantes = []
	var property esPeligrosa
	
	method agregarEstudiante(_estudiante){
		integrantes.add(_estudiante)
		self.determinarSiEsPeligrosa()	
	}
	
	method determinarSiEsPeligrosa(){
		if ((nombre == "Hufflepuff") || (nombre == "Ravenclaw")){
			var cantidadDeAceitesSucios = integrantes.count({estudiante => estudiante.aceite() == "Sucio"})
			
			if (cantidadDeAceitesSucios > ((integrantes.size())/2).truncate(0)){
				esPeligrosa = true
			}
			else{
				esPeligrosa = false		
			}
		}
	}
}

/**********/

class Hechizo{
	
	const property nombre

}

/**********/

class Materia{
	
	const nombre
	const property profesorAsignado
	const property hechizoEnsenado
	
}





