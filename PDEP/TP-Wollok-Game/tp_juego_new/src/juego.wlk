import wollok.game.*
import menues.*
import niveles.*

object juego {
	
	/*MENU PRINCIPAL*/
	var property menuPrincipal = new MenuConMusica(file = "musica-fondo.wav", imagen = "menuPrincipal.png", items = null, menuAnterior = null)
	
	/*ITEMS DEL SELECTOR DE NIVELES*/
	var property itemNivelUno = new ItemMenu(imagen = "nivel1.png", posicion = game.at(7, 8), proximo = new Nivel(dificultad = 1, objetivo = 15, escenario = "Bosque", musicaFondoJuego = new Sound(file = "ambienteBosque.mp3")))
	var property itemNivelDos = new ItemMenu(imagen = "nivel2.png", posicion = game.at(16, 8), proximo = new Nivel(dificultad = 2, objetivo = 20, escenario = "Desierto", musicaFondoJuego = new Sound(file = "ambienteDesierto.mp3")))
	var property itemNivelTres = new ItemMenu(imagen = "nivel3.png", posicion = game.at(7, 2), proximo = new Nivel(dificultad = 3, objetivo = 30, escenario = "Nieve", musicaFondoJuego = new Sound(file = "ambienteNieve.mp3")))
	var property itemNivelCuatro = new ItemMenu(imagen = "nivel4.png", posicion = game.at(16, 2), proximo = new Nivel(dificultad = 4, objetivo = 35, escenario = "Infierno", musicaFondoJuego = new Sound(file = "ambienteInfierno.mp3")))
	
	/*MENU NIVELES*/
	var property menuNiveles = new Menu(imagen = "menuNiveles.png", items = [itemNivelUno, itemNivelDos, itemNivelTres, itemNivelCuatro], menuAnterior = menuPrincipal)
	
	/*MENU COMO JUGAR*/
	var property menuComoJugar = new Menu(imagen = "menuComoJugar.png", items = null, menuAnterior = menuPrincipal)
	
	/*ITEMS DEL MENU PRINCIPAL*/
	var property itemNuevaPartida = new ItemMenu(imagen = "nuevaPartida.png", posicion = game.at(3, 4), proximo = menuNiveles)
	var property itemComoJugar = new ItemMenu(imagen = "comoJugar.png", posicion = game.at(3, 3), proximo = menuComoJugar)
	
	/*MENU PERDER*/
	var property menuPerder = new Menu(imagen = "menuPerder.png", items = null, menuAnterior = menuPrincipal)
	
	/*MENU VICTORIA*/
	var property menuVictoria = new MenuConMusica(file = "musicaVictoria.mp3", imagen = "menuVictoria.png", items = null, menuAnterior = menuPrincipal)
	
	
	method configurarVentana(){
		game.width(25)
		game.height(15)
		game.cellSize(50)
		game.title("Metal's Lag")
	}
	
	method mostrarMenuPrincipal(){
		menuPrincipal.items([itemNuevaPartida, itemComoJugar])
		menuPrincipal.mostrar()
	}
}

class Tablero {

	const image

	method image() = image
	method position() = game.origin()

}

