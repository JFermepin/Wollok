import wollok.game.*

const este = "este"
const oeste = "oeste"
const norte = "norte"
const sur = "sur"
const ne = "ne"
const no = "no"
const so = "so"
const se = "se"

class Direccion{
	var property valor = este
	
	method este() = (valor == este)
	method oeste() = (valor == oeste)
	method norte() = (valor == norte)
	method sur() = (valor == sur)
}

class Movimiento {
	
	var property posicion
	var property miraHacia = new Direccion()
	
	method rotaMediaVuelta(){
		if((miraHacia.este()) || (miraHacia.oeste())){
			if(miraHacia.este()){
				game.schedule(0, { miraHacia.valor(ne) game.schedule(50, { miraHacia.valor(norte) game.schedule(50, { miraHacia.valor(no) game.schedule(50, { miraHacia.valor(oeste)})})})})
			}else{
				game.schedule(0, { miraHacia.valor(no) game.schedule(50, { miraHacia.valor(norte) game.schedule(50, { miraHacia.valor(ne) game.schedule(50, { miraHacia.valor(este)})})})})
			}
		
		}if(miraHacia.norte() || miraHacia.sur()){
			if(miraHacia.norte()){
				game.schedule(0, { miraHacia.valor(no) game.schedule(50, { miraHacia.valor(oeste) game.schedule(50, { miraHacia.valor(so) game.schedule(50, { miraHacia.valor(sur)})})})})
			}else{
				game.schedule(0, { miraHacia.valor(se) game.schedule(50, { miraHacia.valor(este) game.schedule(50, { miraHacia.valor(ne) game.schedule(50, { miraHacia.valor(norte)})})})})
				}
			}
		}
 
  
	method rotaUnCuarto(_aDondeVa){
		if((miraHacia.este()) && (_aDondeVa == norte)){
			game.schedule(0, { miraHacia.valor(ne) game.schedule(50, { miraHacia.valor(norte)})})
		}
		if((miraHacia.este()) && _aDondeVa == sur){
			game.schedule(0, { miraHacia.valor(se) game.schedule(50, { miraHacia.valor(sur)})})
		}
		if((miraHacia.norte()) && (_aDondeVa == este)){
			game.schedule(0, { miraHacia.valor(ne) game.schedule(50, { miraHacia.valor(este)})})
		}
		if((miraHacia.norte()) && (_aDondeVa == oeste)){
			game.schedule(0, { miraHacia.valor(no) game.schedule(50, { miraHacia.valor(oeste)})})
		}
		if((miraHacia.oeste()) && (_aDondeVa == norte)){
			game.schedule(0, { miraHacia.valor(no) game.schedule(50, { miraHacia.valor(norte)})})
		}
		if((miraHacia.oeste()) && (_aDondeVa == sur)){
			game.schedule(0, { miraHacia.valor(so) game.schedule(50, { miraHacia.valor(sur)})})
		}
		if((miraHacia.sur()) && (_aDondeVa == oeste)){
			game.schedule(0, { miraHacia.valor(so) game.schedule(50, { miraHacia.valor(oeste)})})
		}
		if((miraHacia.sur()) && _aDondeVa == este){
			game.schedule(0, { miraHacia.valor(se) game.schedule(50, { miraHacia.valor(este)})})
		}
	}
  
	method moverseDerecha(){
	  	if(miraHacia.este()){
	  		posicion = posicion.right(1)
	  	}else{
	  		if(miraHacia.oeste()){
	  			self.rotaMediaVuelta()
	  		}else{
	  			self.rotaUnCuarto(este)
	  		}
	  	}
  	}
  	
	method moverseIzquierda(){
	   	if(miraHacia.oeste()){
	  		posicion = posicion.left(1)
	  	}else{
	  		if(miraHacia.este()){
	  			self.rotaMediaVuelta()
	  		}else{
	  			self.rotaUnCuarto(oeste)
	  		}
	  	}
  	}
  	
	method moverseArriba(){
	  	if(miraHacia.norte()){
	  		posicion = posicion.up(1)
	  	}else{
	  		if(miraHacia.sur()){
	  			self.rotaMediaVuelta()
	  		}else{
	  			self.rotaUnCuarto(norte)
	  		}
	  	}
  	}
  	
	method moverseAbajo(){
	  	 if(miraHacia.sur()){
	  		posicion = posicion.down(1)
	  	}else{
	  		if(miraHacia.norte()){
	  			self.rotaMediaVuelta()
	  		}else{
	  			self.rotaUnCuarto(sur)
	  		}
	  	}
  	}
  	
  	method retroceder(){
  		if (miraHacia.este()){
  			posicion = posicion.left(1)
  		}
  		if (miraHacia.oeste()){
  			posicion = posicion.right(1)
  		}
  		if (miraHacia.sur()){
  			posicion = posicion.up(1)
  		}
  		if (miraHacia.norte()){
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
