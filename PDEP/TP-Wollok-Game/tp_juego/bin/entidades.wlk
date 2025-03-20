import wollok.game.*
import movimientos.*
import niveles.*
import juego.*
import utilidades.*

class Soldado inherits Movimiento{
  
	var property arma = new Arma(nombre = "pistola", sonidoRecarga = "pistola-recarga.mp3", sonidoDisparo = "pistola-tiro.mp3", sonidoRecoger = null, tiempoRecarga = 2500, danio = 4, posicion = null, cargador = 12)
	var property vidas = 3
	var property corazones = [new ItemDelHud(posicion = game.at(3,1), imagen = "corazon.png"),new ItemDelHud(posicion = game.at(4,1), imagen = "corazon.png"),new ItemDelHud(posicion = game.at(5,1), imagen = "corazon.png")]

	method image() = "soldado-" + arma.nombre() + "-" + self.miraHacia() + ".png"
	method position() = self.posicion()
  
	method dispara(){
		
		game.sound(arma.sonidoDisparo()).play()
		arma.balas(arma.balas()-1)
	 	game.removeVisual(game.getObjectsIn(game.at(22,1)).head())
	 	game.addVisual(new ItemDelHud(imagen = numeroAString.conversion(arma.balas()) + ".png", posicion = game.at(22,1)))
		
		if(self.miraHacia() == "derecha"){
			const bala = new Bala(posicion = self.posicion().right(1), miraHacia = self.miraHacia(), arma = arma)
			game.addVisual(bala)
			bala.moverse()
		}
		if(self.miraHacia() == "izquierda"){
			const bala = new Bala(posicion = self.posicion().left(1), miraHacia = self.miraHacia(), arma = arma)
			game.addVisual(bala)
			bala.moverse()
		}
		if(self.miraHacia() == "arriba"){
			const bala = new Bala(posicion = self.posicion().up(1), miraHacia = self.miraHacia(), arma = arma)
			game.addVisual(bala)
			bala.moverse()
		}
		if(self.miraHacia() == "abajo"){
			const bala = new Bala(posicion = self.posicion().down(1), miraHacia = self.miraHacia(), arma = arma)
			game.addVisual(bala)
			bala.moverse()
		}
	 }
	 
	 method recarga(){
	 	game.sound(arma.sonidoRecarga()).play()
	 	game.schedule(arma.tiempoRecarga(), {
	 		game.say(self,"Listo") 
	 		arma.balas(arma.cargador())
	 		game.removeVisual(game.getObjectsIn(game.at(22,1)).head())
	 		game.addVisual(new ItemDelHud(imagen = numeroAString.conversion(arma.balas()) + ".png", posicion = game.at(22,1)))
	 	})
	 }
	  
	 method reproducirPaso(escenario){
	 	var paso = "paso" + escenario + numeroAString.conversion(1.randomUpTo(4).truncate(0)) + ".mp3"
	 	game.sound(paso).play()
	 }
	 
	 method perderVida(nivel){
	 	vidas--
	 	game.sound("danio" + numeroAString.conversion(1.randomUpTo(3).truncate(0)) + ".mp3").play()
	 	game.removeVisual(game.getObjectsIn(corazones.last().posicion()).head())
	 	corazones.remove(corazones.last())
	 	self.retroceder()
	 	if(vidas == 0){
	 		nivel.musicaFondoJuego().pause()
	 		game.sound("missionFailed.wav").play()
	 		nivel.resetearNivel()
	 		juego.menuPerder().mostrar()
	 	}
	 }
	 
	 method noHacerNada(){}
	 
	 method interactuaConZombie(zombie, nivel){}
}

class Zombie inherits Movimiento{
	
	const dificultadDeZombie
	var property vida = 12 * dificultadDeZombie
	
	method image() = "zombie-" + self.miraHacia() + ".png"
	method position() = self.posicion()
	
	method aparecer(dificultad, soldado){
		
		if(self.position().x() == 0){
			self.miraHacia("derecha")
		}
		if(self.position().x() == game.width()-1){
			self.miraHacia("izquierda")
		}
		if(self.position().y() == game.height()-1){
			self.miraHacia("abajo")
		}
		if(self.position().y() == 3){
			self.miraHacia("arriba")
		}
		
		game.addVisual(self)
		
		game.onTick(1000.div(dificultad), "perseguir", {self.perseguir(soldado)})
	}
	
	method interactuaConSoldado(soldado, nivel){
		soldado.perderVida(nivel)
		nivel.generarNuevoMapa()
	}
	
	method interactuaConZombie(zombie, nivel){
		self.retroceder()
	}
}

class Arma{
	
	var property posicion
	const property nombre
	const property sonidoDisparo
	const property sonidoRecarga
	const property sonidoRecoger
	const property cargador
	const property tiempoRecarga
	const property danio
	var property balas = cargador
	
	method image() = nombre + ".png"
	method position() = posicion
	
	method interactuaConSoldado(soldado, nivel){
		self.esAgarradoPorSoldado(soldado)
	}
	
	method esAgarradoPorSoldado(soldado){
		soldado.arma(self)
		game.removeVisual(self)
		game.sound(sonidoRecoger).play()
		game.removeVisual(game.getObjectsIn(game.at(9,1)).head())
		game.addVisual(new ItemDelHud(imagen = soldado.arma().nombre() + ".png", posicion = game.at(9,1)))
		game.removeVisual(game.getObjectsIn(game.at(22,1)).head())
	 	game.addVisual(new ItemDelHud(imagen = numeroAString.conversion(self.balas()) + ".png", posicion = game.at(22,1)))
	}
	
	method interactuaConZombie(zombie, nivel){}
}

class Bala inherits Movimiento{
	
	const arma
	
	var rango = 0
	
	var posicionFinal = null
	
	method image() = "bala-" + self.miraHacia() + ".png"
	method position() = self.posicion()
	
	method calcularRango(){
		if(arma.nombre() == "pistola"){
			rango = 4
		}
		if(arma.nombre() == "escopeta"){
			rango = 2
		}
		if(arma.nombre() == "rifle"){
			rango = 7
		}
	}
	
	method calcularTrayecto(){
		if(self.miraHacia() == "derecha"){
			posicionFinal = new Position(x = self.posicion().x() + rango, y = self.posicion().y())
		}
		if(self.miraHacia() == "izquierda"){
			posicionFinal = new Position(x = self.posicion().x() - rango, y = self.posicion().y())
		}
		if(self.miraHacia() == "arriba"){
			posicionFinal = new Position(x = self.posicion().x(), y = self.posicion().y() + rango)
		}
		if(self.miraHacia() == "abajo"){
			posicionFinal = new Position(x = self.posicion().x(), y = self.posicion().y() - rango)
		}
	}
	
	method moverse(){
		
		self.calcularRango()
		self.calcularTrayecto()
		
		if(self.miraHacia() == "derecha"){
			game.onTick(200,"disparo",{self.moverseDerecha() 		
			if ((self.posicion().x() > posicionFinal.x()) || (self.posicion().x() > game.width())){
			game.removeTickEvent("disparo")
			game.removeVisual(self)
			}
		})
		}
		if(self.miraHacia() == "izquierda"){
			game.onTick(200,"disparo",{self.moverseIzquierda()		
			if ((self.posicion().x() < posicionFinal.x()) || (self.posicion().x() < 0)){
			game.removeTickEvent("disparo")
			game.removeVisual(self)
		}})
		}
		if(self.miraHacia() == "arriba"){
			game.onTick(200,"disparo",{self.moverseArriba()
			if ((self.posicion().y() > posicionFinal.y()) || (self.posicion().y() > game.height())){
			game.removeTickEvent("disparo")
			game.removeVisual(self)
		}})
		}
		if(self.miraHacia() == "abajo"){
			game.onTick(200,"disparo",{self.moverseAbajo()
			if ((self.posicion().y() < posicionFinal.y()) || (self.posicion().y() < 3)){
			game.removeTickEvent("disparo")
			game.removeVisual(self)
		}})
		}
	}
	
	method interactuaConSoldado(soldado, nivel){}
	
	method interactuaConZombie(zombie, nivel){
		
		game.sound("hitmarker.mp3").play()
		zombie.vida(zombie.vida()-arma.danio())
		game.removeTickEvent("disparo")
		game.removeVisual(self)
		
		if(zombie.vida() < 0){
			game.removeVisual(zombie)
			const charcoDeSangre = new Sangre(posicion = zombie.position())
			game.addVisual(charcoDeSangre)
			charcoDeSangre.desvanecerse()
			nivel.maxZombies(nivel.maxZombies() + 1)
			
			/*VISUALES DEL HUD */
			nivel.objetivo(nivel.objetivo()-1)
			
			if(nivel.objetivo() == 0){
				if(!juego.menuNiveles().estrellas().contains(nivel.dificultad())){
					juego.menuNiveles().estrellas().add(nivel.dificultad())	
				}
				nivel.musicaFondoJuego().pause()
	 			nivel.resetearNivel()
	 			juego.menuVictoria().mostrar()
			}else{
				game.removeVisual(game.getObjectsIn(game.at(16,1)).head())
	 			game.addVisual(new ItemDelHud(imagen = numeroAString.conversion(nivel.objetivo()) + ".png", posicion = game.at(16,1)))
			}
			
		}/*else{
			game.say(zombie, "Vida: " + numeroAString.conversion(zombie.vida()))
		}*/
	}
}

class Sangre{
	var property opacidad = 5
	const property posicion
	
	method position() = posicion
	method image() = "sangre" + opacidad + ".png"
	
	method desvanecerse(){
		game.onTick(1000, "desvanecerse", {
			if(opacidad == 1){
				game.removeTickEvent("desvanecerse")
				game.removeVisual(self)
			}
			else{
				opacidad--
			}
		})	
	}
	
	method interactuaConZombie(zombie, nivel){}
	
	method interactuaConSoldado(soldado, nivel){}
}

class ItemDelHud{
	
	const property posicion
	const imagen
	
	method position() = posicion
	method image() = imagen
	
}

/*
class BloqueInvisible{
	
	const esLimite
	const posicion
		
	method position() = posicion
	
}
*/
