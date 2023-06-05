import wollok.game.*

class Maiz {
	var property position
	var estado = bebe
	
	method image() {
		return estado.image()
	}
	
	method regarse(){
		estado = adulto	
	}
	method cosecharse(){
		game.removeVisual(self)
	}
	
	method estaLista() = estado == adulto
	
	method precio() = 150
}


class Trigo {
	var property position
	var etapa = 0
	
	method image() {
		return "trigo_" + etapa + ".png"
	}
	
	method regarse(){
		etapa = (etapa + 1) % 4
	}
	method cosecharse(){
		game.removeVisual(self)
	}
	
	method estaLista() = etapa >= 2
	
	method precio() = (etapa -1) * 100
}



object bebe{
	method image() = "maiz_bebe.png"	
}

object adulto{
	method image() = "maiz_adulto.png"	
}


// Agregar las demás plantas y completar el Maiz.