import pokemones.*
object red {
	
	const pokemones = {}
	
	method pokemonesEnCiudad(){
		return pokemones
	}
	
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
	
}

