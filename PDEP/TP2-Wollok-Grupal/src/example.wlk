import pokemones.*
object red {
	
	const pokemones = #{}
	
	method agregarPokemones(_pokemonNuevo) {
		pokemones.add(_pokemonNuevo)
	}
	
	method poderioTotal()= pokemones.sum({pokemon => pokemon.poderPokemon()})
	
	method abandonarPokemonMenosPoderoso(){
		pokemones.remove(pokemones.min({pokemon => pokemon.poderPokemon()}))
		}
	
	method promedioPoderioTotal() = self.poderioTotal() / pokemones.size()
	
	
	method reclutarPokemon(pokemon){
		if ( pokemon.poderPokemon() > self.promedioPoderioTotal())
			self.agregarPokemones(pokemon)
	}
	
	method entrenarEquipo()= pokemones.map({pokemon => pokemon.entrena()})
	
	/** falta determinar si va a ser campeon de la liga */

object rattata{
	
	const poder=1500
	
	method poder()= poder	 	
}

object machop{
	
	var poder=2000
	
	method poder()=poder
	
	method entrenar(){poder += poder*10/100}
}

object pikachuResuelveMist{
	
	var poder
	var misterios = #{}
	
	method poder()=poder
	
	method cal_poder(){
		
		poder += 20 * misterios.size()
	}
	
	method entrenar(nuevoMisterio){
		misterios=misterios + nuevoMisterio
	}
	method mister()=misterios
	
}


	object dragonite{
	
	var poder
	
	method poder()=poder* machop.poder()
	
}
	
}
