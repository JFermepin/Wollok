object pikachu{
	
	var property poder = 0
	
	const misteriosResueltos = {"misterioUno","misterioDos","misterioTres"}	
	
	
	
	method poderPokemon(){
		
		poder = misteriosResueltos.map(misterio=>{misterio.size()}).sum() * 20
		/** no se como saber el tamaño de las palabras dentro de la coleccion */
		
	}
	
	method agregarMisterio(nuevoMisterio){
		
		misteriosResueltos.add(nuevoMisterio)
		
	}
	/**
	method entrena(){
		self.resolverMisterio(_misterio)
		if (misteriosResueltos.contains("parte 2")) misteriosResueltos		
			else misteriosResueltos + "parte 2"
	}

 	*/
	method entrena(){
		misteriosResueltos.find(misterio =>{not misterio.contains("parte2")}) + "parte2"
	}
 	
	
	
}

object ratatta{
	var property poder = 1500
	
	method poderPokemon(){
		/** setter */
		return poder
	}
	
	method entrena(lohace){
		/** no mejora el poder cuando entrena */
	}
	
	
}

object machop{
	var property poder = 2000
	method poderPokemon(){
		/** setter */
		return poder
	}
	
	method entrena(lohace){
		if (lohace) poder = poder * 0.10
	}
	
	
}
object dragonite{
	var property poder = 0
	
	method poderPokemon(){
		/** getter */
		poder = machop.poderPokemon() * 2 
	}
	method entrena(){
		/** no entrena pero hace que bruno entrene */
	bruno.entrena()	
	}
	
}
object bruno{
	var property poder = 0
	
	method poderPokemon(){
		return poder
	}
	
	method entrena(){
		/** entrena cuando lo hace entrenar dragonite */
	}
}



