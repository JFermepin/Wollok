import entidades.*
import wollok.game.*
import juego.*

class Nivel {
	
	var property mejoras = [new Arma(nombre = "escopeta", sonidoRecarga = "escopeta-recarga.mp3", sonidoDisparo = "escopeta-tiro.mp3", danio = 14, tiempoRecarga = 4500, sonidoRecoger = "escopeta-recoger.mp3", posicion = null, cargador = 8),
		new Arma(nombre = "rifle", sonidoRecarga = "rifle-recarga.mp3", sonidoDisparo = "rifle-tiro.mp3", sonidoRecoger = "rifle-recoger.mp3", danio = 10, tiempoRecarga = 2100, posicion = null, cargador = 20)]
	
	const property dificultad
	const escenario
	// const estructuras = []
	const limitesDelMapa = []
	var property objetivo
	var property maxZombies = dificultad * 5
	var fondo = new Tablero(image = "mapa-" + escenario + (1.randomUpTo(5).truncate(0))+ ".png")
	var property musicaFondoJuego
	
	var soldado = new Soldado(posicion = game.at(12,8))
	
	method agregarVisuales(){
		game.addVisual(fondo)
		game.addVisual(soldado)
		game.addVisual(new ItemDelHud(imagen = soldado.arma().nombre() + ".png", posicion = game.at(9,1)))
		game.addVisual(new ItemDelHud(imagen = objetivo.toString() + ".png", posicion = game.at(16,1)))
		
		if(soldado.arma().balas() == 0){
			game.addVisual(new ItemDelHud(imagen = "recarga.png", posicion = game.at(22,1)))
			soldado.recarga()
		}else{
			game.addVisual(new ItemDelHud(imagen = soldado.arma().balas().toString() + ".png", posicion = game.at(22,1)))	
		}
		
		if(soldado.vidas() != 0){
			soldado.corazones().forEach({corazon => game.addVisual(corazon)})
		}
		game.onTick(1000.div(dificultad),"aparecerZombie",{
			if(maxZombies != 0){
				var zombie = (new Zombie(posicion = limitesDelMapa.anyOne(), dificultadDeZombie = dificultad))
				zombie.aparecer(dificultad, soldado)
				game.onCollideDo(zombie,{algo => algo.interactuaConZombie(zombie, self)}) //soldado.perderVida()
				maxZombies--
			}
		})
		game.onTick(2000,"sonidoZombie",{
			var probabilidadesDeSonido = 1.randomUpTo(18).truncate(0) 
			if((probabilidadesDeSonido >= 1) && (probabilidadesDeSonido <= 8)){
				game.sound("zombie" + probabilidadesDeSonido.toString() + ".mp3").play()
			}
		})
	}
	
	method mostrar(){
		maxZombies = dificultad * 4
		juego.menuPrincipal().pausarMusica()
		self.calcularLimitesDelMapa()
		self.agregarVisuales()
		game.onCollideDo(soldado,{algo => algo.interactuaConSoldado(soldado, self)}) //soldado.perderVida()
		self.configurarTeclado()
		if(!musicaFondoJuego.played()){
			musicaFondoJuego.shouldLoop(true)
			musicaFondoJuego.play()
		}
		if(musicaFondoJuego.paused()){
			musicaFondoJuego.stop()
			musicaFondoJuego = new Sound(file = "ambiente" + escenario + ".mp3")
			musicaFondoJuego.play()
		}
	}
	
	method siguienteMejora(){
		if(!mejoras.isEmpty()){
			var probabilidadesDeMejora = 0.randomUpTo(dificultad + 6).truncate(0) 
			
			if(soldado.arma().nombre() == mejoras.head().nombre()){
				mejoras.remove(mejoras.head())
			}
			if((probabilidadesDeMejora == 0) && (!mejoras.isEmpty())){
				mejoras.head().posicion(new Position(x = 0.randomUpTo(game.width()), y = 3.randomUpTo(game.height())))
				game.addVisual(mejoras.head())
			}
		}
	}
	
	method generarNuevoMapa(){
		
		const posicionSoldadoX = soldado.posicion().x()
		const posicionSoldadoY = soldado.posicion().y()
		
		if(posicionSoldadoX >= game.width()){
			game.clear()
			fondo = new Tablero(image = "mapa-" + escenario + (1.randomUpTo(5).truncate(0)) + ".png")
			soldado.posicion(new Position(x = 0, y = posicionSoldadoY))
			self.mostrar()
			self.siguienteMejora()
		}
		
		if(posicionSoldadoX < 0){
			game.clear()
			fondo = new Tablero(image = "mapa-" + escenario + (1.randomUpTo(5).truncate(0))+ ".png")
			soldado.posicion(new Position(x = game.width()-1, y = posicionSoldadoY))
			self.mostrar()
			self.siguienteMejora()
		}
		
		if(posicionSoldadoY >= game.height()){
			game.clear()
			fondo = new Tablero(image = "mapa-" + escenario + (1.randomUpTo(5).truncate(0))+ ".png")
			soldado.posicion(new Position(x = posicionSoldadoX, y = 3))
			self.mostrar()
			self.siguienteMejora()
		}
		
		if(posicionSoldadoY < 3){
			game.clear()
			fondo = new Tablero(image = "mapa-" + escenario + (1.randomUpTo(5).truncate(0))+ ".png")
			soldado.posicion(new Position(x = posicionSoldadoX, y = game.height()-1))
			self.mostrar()
			self.siguienteMejora()
		}
		
	}
	
	method configurarTeclado(){
		keyboard.right().onPressDo { soldado.moverseDerecha() soldado.reproducirPaso(escenario) self.generarNuevoMapa()}
		keyboard.left().onPressDo { soldado.moverseIzquierda() soldado.reproducirPaso(escenario) self.generarNuevoMapa() }
		keyboard.up().onPressDo { soldado.moverseArriba() soldado.reproducirPaso(escenario) self.generarNuevoMapa() }
		keyboard.down().onPressDo { soldado.moverseAbajo() soldado.reproducirPaso(escenario) self.generarNuevoMapa() }
		keyboard.backspace().onPressDo({self.resetearNivel() musicaFondoJuego.pause() juego.mostrarMenuPrincipal()}) // game.removeTickEvent("sonidoZombie")
		keyboard.space().onPressDo { 
			if(soldado.arma().balas() == 1){
				soldado.dispara()
				game.removeVisual(game.getObjectsIn(game.at(22,1)).head())
	 			game.addVisual(new ItemDelHud(imagen = "recarga.png", posicion = game.at(22,1)))
				soldado.recarga()
			}if(soldado.arma().balas() <= 0){
				soldado.noHacerNada()
			}else{
				soldado.dispara()
			}
		}
	}
	
	method resetearNivel(){
		soldado = new Soldado(posicion = game.at(12,8))
		mejoras = [new Arma(nombre = "escopeta", sonidoRecarga = "escopeta-recarga.mp3", sonidoDisparo = "escopeta-tiro.mp3", danio = 14, tiempoRecarga = 4500, sonidoRecoger = "escopeta-recoger.mp3", posicion = null, cargador = 8),
		new Arma(nombre = "rifle", sonidoRecarga = "rifle-recarga.mp3", sonidoDisparo = "rifle-tiro.mp3", danio = 10, tiempoRecarga = 2100, sonidoRecoger = "rifle-recoger.mp3", posicion = null, cargador = 20)]
		if(dificultad == 1){
			objetivo = 15
		}
		if(dificultad == 2){
			objetivo = 20
		}
		if(dificultad == 3){
			objetivo = 30
		}
		if(dificultad == 4){
			objetivo = 35
		}
	}
	
	method calcularLimitesDelMapa(){
		const ancho = game.width()
		const alto = game.height()
		(0 .. ancho).forEach{ num => limitesDelMapa.add(new Position(x = num, y = alto-1))} // lado superior
		(0 .. ancho).forEach{ num => limitesDelMapa.add(new Position(x = num, y = 3))} // lado inferior
		(3 .. alto).forEach{ num => limitesDelMapa.add(new Position(x = ancho-1, y = num))} // lado derecho
		(3 .. alto).forEach{ num => limitesDelMapa.add(new Position(x = 0, y = num))} // lado izquierdo
	}
}