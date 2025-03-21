class Producto{
	
	var precio = self.valoracion() * 30
	
	method valoracion()
	method esEspecial()
	method esNatural()
	
	method precio(){
		if(self.esNatural()){
			return precio + 120 
		}else{
			return precio
		}
	} 
}

/**********************************/

class Macaron inherits Producto{

	const property peso
	const tieneCobertura //Cada vez que se crea un nuevo Macaron, se define si tiene o no cobertura (true o false)
	
	override method esEspecial() = (peso > 50) && tieneCobertura
	override method esNatural() = !tieneCobertura
	override method valoracion(){
		if (self.esEspecial()){
			return 120
		}else{
			return 80
		}
	}
}

/**********************************/

class Alfajor inherits Producto{
	
	const relleno
	const pesoTapa
	method peso() = (relleno.peso()) + (pesoTapa * 2)
	
	override method esEspecial() = self.peso() > 50
	override method esNatural() = relleno.esNatural() //Es natural si el relleno es natural
	override method valoracion() = self.peso() / 10
	
}

class Relleno{
	const property peso
	const property esNatural
	method esNatural()
}

const dulceDeLeche = new Relleno(peso = 30, esNatural = false)
const confitureDeGroseilles = new Relleno(peso = 25, esNatural = false)
const miel = new Relleno(peso = 20, esNatural = true)

/**********************************/

class AlfajorTriple inherits Alfajor{

	override method peso() = super() + relleno.peso() + pesoTapa
	override method esEspecial() = self.peso() > 100

}

/**********************************/

class PorcionDeTorta inherits Producto{
	
	const tipo //Torta fraiser, pastafrola, etc
	const ingrediente
	const property peso
	
	method tieneChocolate() = (ingrediente == "Chocolate")
	
	override method esEspecial() = (peso > 50) && self.tieneChocolate()
	override method esNatural() = true
	override method valoracion() = 100

}

/**********************************/

class MesaDulce inherits Producto{
	
	const property componentes
	
	method peso() = componentes.sum({componente => componente.peso()})
	override method esEspecial() = (self.peso() > 50) && (componentes.size() > 3)
	override method esNatural() = componentes.all({componente => componente.esNatural()})
	override method valoracion() = componentes.max({componente => componente.valoracion()}).valoracion()
	
}




