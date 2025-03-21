import clientes.*
import productos.*

object pattiserie {
	
	var regalo = 100
	
	const property platosALaVenta = []
	const property clientesQueCompraron = #{}
	
	method promocion() = clientesQueCompraron.forEach({cliente => cliente.credito(cliente.credito() + regalo)})
	
}
