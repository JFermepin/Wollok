import semillas.*

class Parcelas {
	const property ancho
	const property largo
	var property horasDeSolRecibidas
	var property plantasQueTiene=[]
	var property superficieParcela
	var property cantidadMaxPlantas
	
	method superficieParcela()=ancho*largo

	method calcularCantidadMaxPlantas(){
		if (ancho > largo){
			cantidadMaxPlantas= superficieParcela / 5
		}
		else{
			cantidadMaxPlantas= (superficieParcela / 3) + largo
		}
	}
	method tieneComplicaciones(){
		return plantasQueTiene.any({plantasdeparcela => plantasdeparcela.horasDeSol()<horasDeSolRecibidas
		})
	}
	
	method plantar(_nuevaPlanta){
		plantasQueTiene.add(_nuevaPlanta)
	}
	
	method seAsociaBien(_planta)


	
}

class ParcelaEcologica inherits Parcelas{
	override method seAsociaBien(_planta) = self.tieneComplicaciones()
}

class ParcelaIndustrial inherits Parcelas{
	override method seAsociaBien(_planta) =(plantasQueTiene.size() >= 2 && _planta.esFuerte())
}






