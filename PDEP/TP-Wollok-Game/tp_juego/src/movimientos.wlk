import wollok.game.*

class Movimiento {
	
	var property posicion
	var property miraHacia = "derecha"
	
	method rotaMediaVuelta(_miraHacia){
		if(_miraHacia == "derecha" || _miraHacia == "izquierda"){
			if(_miraHacia == "derecha"){
				game.schedule(0, { miraHacia = "45" game.schedule(50, { miraHacia = "arriba" game.schedule(50, { miraHacia = "135" game.schedule(50, { miraHacia = "izquierda"})})})})
			}else{
				game.schedule(0, { miraHacia = "135" game.schedule(50, { miraHacia = "arriba" game.schedule(50, { miraHacia = "45" game.schedule(50, { miraHacia = "derecha"})})})})
			}
		
		}if(_miraHacia == "arriba" || _miraHacia == "abajo"){
			if(_miraHacia == "arriba"){
				game.schedule(0, { miraHacia = "135" game.schedule(50, { miraHacia = "izquierda" game.schedule(50, { miraHacia = "225" game.schedule(50, { miraHacia = "abajo"})})})})
			}else{
				game.schedule(0, { miraHacia = "315" game.schedule(50, { miraHacia = "derecha" game.schedule(50, { miraHacia = "45" game.schedule(50, { miraHacia = "arriba"})})})})
				}
			}
		}
 
  
	method rotaUnCuarto(_miraHacia,_aDondeVa){
		if(_miraHacia == "derecha" && _aDondeVa == "arriba"){
			game.schedule(0, { miraHacia = "45" game.schedule(50, { miraHacia = "arriba"})})
		}
		if(_miraHacia == "arriba" && _aDondeVa == "derecha"){
			game.schedule(0, { miraHacia = "45" game.schedule(50, { miraHacia = "derecha"})})
		}
		if(_miraHacia == "arriba" && _aDondeVa == "izquierda"){
			game.schedule(0, { miraHacia = "135" game.schedule(50, { miraHacia = "izquierda"})})
		}
		if(_miraHacia == "izquierda" && _aDondeVa == "arriba"){
			game.schedule(0, { miraHacia = "135" game.schedule(50, { miraHacia = "arriba"})})
		}
		if(_miraHacia == "izquierda" && _aDondeVa == "abajo"){
			game.schedule(0, { miraHacia = "225" game.schedule(50, { miraHacia = "abajo"})})
		}
		if(_miraHacia == "abajo" && _aDondeVa == "izquierda"){
			game.schedule(0, { miraHacia = "225" game.schedule(50, { miraHacia = "izquierda"})})
		}
		if(_miraHacia == "abajo" && _aDondeVa == "derecha"){
			game.schedule(0, { miraHacia = "315" game.schedule(50, { miraHacia = "derecha"})})
		}
		if(_miraHacia == "derecha" && _aDondeVa == "abajo"){
			game.schedule(0, { miraHacia = "315" game.schedule(50, { miraHacia = "abajo"})})
		}
	}
  
	method moverseDerecha(){
	  	if(miraHacia == "derecha"){
	  		posicion = posicion.right(1)
	  	}else{
	  		if(miraHacia == "izquierda"){
	  			self.rotaMediaVuelta(miraHacia)
	  		}else{
	  			self.rotaUnCuarto(miraHacia,"derecha")
	  		}
	  	}
  	}
  	
	method moverseIzquierda(){
	   	if(miraHacia == "izquierda"){
	  		posicion = posicion.left(1)
	  	}else{
	  		if(miraHacia == "derecha"){
	  			self.rotaMediaVuelta(miraHacia)
	  		}else{
	  			self.rotaUnCuarto(miraHacia,"izquierda")
	  		}
	  	}
  	}
  	
	method moverseArriba(){
	  	if(miraHacia == "arriba"){
	  		posicion = posicion.up(1)
	  	}else{
	  		if(miraHacia == "abajo"){
	  			self.rotaMediaVuelta(miraHacia)
	  		}else{
	  			self.rotaUnCuarto(miraHacia,"arriba")
	  		}
	  	}
  	}
  	
	method moverseAbajo(){
	  	 if(miraHacia == "abajo"){
	  		posicion = posicion.down(1)
	  	}else{
	  		if(miraHacia == "arriba"){
	  			self.rotaMediaVuelta(miraHacia)
	  		}else{
	  			self.rotaUnCuarto(miraHacia,"abajo")
	  		}
	  	}
  	}
  	
  	method retroceder(){
  		if (miraHacia == "derecha"){
  			posicion = posicion.left(1)
  		}
  		if (miraHacia == "izquierda"){
  			posicion = posicion.right(1)
  		}
  		if (miraHacia == "abajo"){
  			posicion = posicion.up(1)
  		}
  		if (miraHacia == "arriba"){
  			posicion = posicion.down(1)
  		}
  	}
  	
  	method perseguir(entidad){
		if(self.posicion().x() > entidad.posicion().x()){
			self.moverseIzquierda()
		}
		if(self.posicion().x() < entidad.posicion().x()){
			self.moverseDerecha()
		}
		if(self.posicion().y() > entidad.posicion().y()){
			self.moverseAbajo()
		}
		if(self.posicion().y() < entidad.posicion().y()){
			self.moverseArriba()
		}
  	}
}
