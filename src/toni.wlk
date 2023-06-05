import wollok.game.*
import plantas.*
import pachamama.*

object huerta {
	
	method iniciar(){
		game.width(15)
		game.height(15)
		// Configuramos una imagen de fondo, que se repite para cada celda del tablero.
		game.ground("tierra.png")
	
		// Agregamos al amigo Toni.
		game.addVisual(toni)
		game.addVisual(pachamama)
		self.sembrarFilaMaices()
		toni.configurarMovimiento()
		toni.configurarTareas()
	}
	method sembrarFilaMaices() {
	/* 
	 * Agregamos una fila de maices. Ojo al regar, que Toni no va a conocer
	 * estas plantas.
	 * 
	 * De yapa, mostramos cómo agregar varios objetos de una utilizando
	 * un rango (1..13), que equivale a la lista [1, 2, 3, ..., 13].
	 */
	(1..13).forEach { x => toni.sembrar(new Maiz(position= game.at(x, 5)))}
	
	}

}

object arriba{
	method moverA(personaje){
		personaje.position( personaje.position().up(1))
	}
}

object abajo{
	method moverA(personaje){
		personaje.position( personaje.position().down(1))
	}
}
object izquierda{
	method moverA(personaje){
		personaje.position( personaje.position().left(1))
	}
}
object derecha{
	method moverA(personaje){
		personaje.position( personaje.position().right(1))
	}
}


object toni {
	const property image = "toni.png"
	var property position = game.at(3, 3)
	
	const cosasSembradas = []
	const cosasCosechadas = []
	var oro = 0
	
	method mover(direccion){
		direccion.moverA(self)
	}

	method configurarMovimiento() {
		keyboard.up().onPressDo{self.mover(arriba)}
		keyboard.down().onPressDo{self.mover(abajo)}
		keyboard.left().onPressDo{self.mover(izquierda)}
		keyboard.right().onPressDo{self.mover(derecha)}
	}
	method configurarTareas() {
		keyboard.m().onPressDo{self.sembrar(new Maiz(position = position ))}
		keyboard.t().onPressDo{self.sembrar(new Trigo(position = position ))}
		keyboard.r().onPressDo{self.regar()}
		keyboard.a().onPressDo{self.regarTodo()}
		keyboard.c().onPressDo{self.cosechar()}
		keyboard.x().onPressDo{self.cosecharTodo()}
		keyboard.v().onPressDo{self.vender()}
		keyboard.space().onPressDo{game.say(toni,toni.mensajeOro())}
		
		
	}
	method sembrar(planta) {
		if(not game.colliders(self).isEmpty()){
			throw new Exception(message = "ya hay sembrado")
		}
		cosasSembradas.add(planta)
		game.addVisual(planta) 
	}
	method regar(){
		game.colliders(self).forEach({planta=>planta.regarse()})
	}
	method regarTodo(){
		cosasSembradas.forEach{planta=>planta.regarse()}
	}
	method cosechar() {
		game.colliders(self).forEach({planta=>self.cosecharUna(planta)})
				 
	}
	
	method cosecharUna(planta){
		if(planta.estaLista()){
			cosasCosechadas.add(planta)
			cosasSembradas.remove(planta)
			game.removeVisual(planta)
		}
	}
	
	method cosecharTodo() {
		//TODO: Código autogenerado 
	}
	method vender() {
		oro = oro + cosasCosechadas.sum{p=>p.precio()}
		cosasCosechadas.clear()
	}
	method mensajeOro() = "Tengo " + oro + " monedas de oro"
	
}