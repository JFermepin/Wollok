import parcelas.*
class Plantas{
	var property anioDeObtencion
	var property altura
	var property horasDeSol
	const property espacioQueOcupa

	method esFuerte(){
		return horasDeSol > 10
		
	}
	
	method daNuevasSemillas(){
		return self.esFuerte()
		
	}
	method tolerancia() {
		if (self.horasDeSol() > 10){}
		
	}
	method parcelaIdeal(_parcela){
		return false
	}
}

class Menta inherits Plantas{
	var alturaMenta	
	override method espacioQueOcupa(){
		 altura = altura * 3
		 alturaMenta=altura
	}
	override method daNuevasSemillas(){
		return altura>0.4
	}
	override method parcelaIdeal(_parcela){
		 return _parcela.superficieParcela()>6 
	}
	
}
class Soja inherits Plantas{
		
	override method tolerancia(){
		if(altura< 0.5){
			horasDeSol = 6
		}
		if(altura> 0.5 && altura>1){
			horasDeSol = 7
		}
		if(altura> 1){
			horasDeSol = 9
		}
	}
	
	override method daNuevasSemillas(){
		return (anioDeObtencion>2007 && altura > 1)
	}
	override method espacioQueOcupa()=altura/2
	override method parcelaIdeal(_parcela){
		 return (_parcela.horasDeSolRecibidas()==horasDeSol) /**no se como hacer esto o si funciona */
	}
}

class Quinoa inherits Plantas{
	
	override method espacioQueOcupa() = 0.5
	override method daNuevasSemillas(){
		return (anioDeObtencion<2005)
	}
	override method parcelaIdeal(_parcela){
		 return _parcela.plantasQueTiene().any({plantasParcela=>plantasParcela.altura()>1.5})
	}
}

class SojaTransgenica inherits Soja{
	override method daNuevasSemillas()=false
	override method parcelaIdeal(_parcela){
		 return _parcela.any({plantasParcela=>plantasParcela.size()>1})
	}
}
class HierbaBuena inherits Menta{
	
	override method espacioQueOcupa(){
		altura=alturaMenta*2
		}
	override method parcelaIdeal(_parcela){
		 return _parcela.superficieParcela()>6 /**no se como hacer esto */
	}
}
