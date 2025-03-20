
object pikachu{
	/** no se como es lo de los misterios no entiendo la consigna */
	var property poder = 30
	
	method poderPokemon(){
		/** setter */
		return poder
	}
	
	method entrena(){
		
	}
}

object ratatta{
	var property poder = 1500
	
	method poderPokemon(){
		/** setter */
		return poder
	}
	
	method entrena(){
		
		/** no mejora el poder cuando entrena */
	}
	
	
}

object machop{
	var property poder = 2000
	
	method poderPokemon(){
		/** setter */
		return poder
	}
	
	method entrena(){
		poder = poder * 0.10
	}
	
	
}
object dragonite{
	var property poder = 0
	
	method poderPokemon(){
		/** setter */
		return poder
	}
	method poderPokemon(_machop){
		/** getter */
		poder = _machop.poderPokemon() * 2 
	}
	method entrena(){
		/** no entrena pero hace que bruno entrene, DUDA: bruno es un entrenador o es un pokemon?? */
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

