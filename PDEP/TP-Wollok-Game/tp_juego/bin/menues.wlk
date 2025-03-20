import wollok.game.*
import juego.*
import entidades.*

class Menu {

	const imagen
	const tablero = new Tablero(image = imagen)
	var property items
	var cursor = null
	var property estrellas = []
	
	const menuAnterior
	
	//method posicionIzqDelItem(indice) = items.get(indice).position().left(1)

	method mostrar() {
		game.clear()
		game.addVisual(tablero)
		
		if(items != null){
			cursor = new Cursor(objetoSeleccionado = items.head(), objetosDelMenu = items)
			game.addVisual(cursor)
			items.forEach({item => game.addVisual(item)})	
		}
		
		if(!estrellas.isEmpty()){
			estrellas.forEach({estrella =>
				game.addVisual(new ItemDelHud(imagen = "estrella.png", posicion = items.get(estrella-1).position().right(2)))
			})
		}
		
		self.configurarTeclado()
	}

	method configurarTeclado() {
		keyboard.enter().onPressDo({
			if(cursor != null){cursor.seleccionActual().ejecutar()}
		})
		
		if(menuAnterior != null){
			keyboard.backspace().onPressDo({menuAnterior.mostrar()})
		}
		
		if(cursor != null){
			keyboard.alt().onPressDo({ cursor.desplazarse()})
		}
	}
	
}

class MenuConMusica inherits Menu{
	
	const file
	var musicaFondo = new Sound(file = file)
	
	method pausarMusica(){
		if(!musicaFondo.paused()){
			musicaFondo.pause()	
		}
	}
	
	override method mostrar() {

		super()
		
		if(!musicaFondo.played()){
			musicaFondo.shouldLoop(true)
			game.schedule(0,{ musicaFondo.play() })
		}
		
		if(musicaFondo.paused()){
			musicaFondo.stop()
			musicaFondo = new Sound(file = file)
			game.schedule(0,{ musicaFondo.play() })
		}

	}
	
	override method configurarTeclado() {
		keyboard.enter().onPressDo({
			if(cursor != null){cursor.seleccionActual().ejecutar()}
		})
		
		if(menuAnterior != null){
			keyboard.backspace().onPressDo({menuAnterior.mostrar() self.pausarMusica()})
		}
		
		if(cursor != null){
			keyboard.alt().onPressDo({ cursor.desplazarse()})
		}
	}	
}

class Cursor {
	
	var index = 0
	var objetoSeleccionado = null
	const objetosDelMenu = null
	
	method position() = objetoSeleccionado.position().left(1)
	method finalDelMenu() = objetosDelMenu.size() - 1
	method principioDelMenu() = 0
	method seleccionActual() = game.getObjectsIn(self.position().right(1)).head()
	method image() = "selector.png"
	

	method desplazarse() {
		if (self.volverAlInicio()) {
			index++
		} 
		
		else {
			index = self.principioDelMenu()
		}
		
		objetoSeleccionado = objetosDelMenu.get(index)
	}

	method volverAlInicio() {
		return index != self.finalDelMenu()
	}
	
}

class ItemMenu{
	
	const imagen
	const posicion
	const proximo
	
	method image() = imagen
	method position() = posicion
	
	method ejecutar(){
		game.clear()
		proximo.mostrar()
	}
}