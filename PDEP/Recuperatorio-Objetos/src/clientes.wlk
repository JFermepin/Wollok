import pattiserie.*

class UserException inherits Exception { }

class Cliente{
	var property credito
	
	method leGusta(producto)
	method comprarProducto(){
		//Si hay alguno que le guste, que lo compre (buscarlo en la lista, eliminarlo y restar el credito)
		if(pattiserie.platosALaVenta().any({producto => (self.leGusta(producto)) && (producto.precio() <= credito)})){
			var productoComprado = pattiserie.platosALaVenta().find({producto => (self.leGusta(producto)) && (producto.precio() <= credito)})
			pattiserie.clientesQueCompraron().add(self)
			pattiserie.platosALaVenta().remove(productoComprado)
			credito = credito - productoComprado.precio()
		}else{
			throw new UserException(message = "No hay nada que le guste, o no tiene credito")
		}
	}
}

class ClienteNaturista inherits Cliente{
	
	override method leGusta(producto) = producto.esNatural()
}

class ClientePadawan inherits Cliente{
	
	override method leGusta(producto) = (producto.esEspecial()) || (producto.valoracion() > 100)
}

class ClienteTodoVale inherits Cliente{
	
	override method leGusta(producto) = true
}