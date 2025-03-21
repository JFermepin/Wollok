import entidades.*

/*HECHIZOS CONOCIDOS*/
const inmobilus = new Hechizo(nombre = "Inmobilus")
const sectumSempra = new Hechizo(nombre = "Sectum Sempra")
const avadakedabra = new Hechizo(nombre = "Avadakedabra")
const expectoPatronum = new Hechizo(nombre = "Expecto Patronum")
const olvidus = new Hechizo(nombre = "Olvidus")

/*CASAS*/
const gryffindor = new Casa(nombre = "Gryffindor", esPeligrosa = false) //No es peligrosa
const slytherin = new Casa(nombre = "Slytherin", esPeligrosa = true) //Es peligrosa
const ravenclaw = new Casa(nombre = "Ravenclaw", esPeligrosa = false) //No es peligrosa al inicio
const hufflepuff = new Casa(nombre = "Hufflepuff", esPeligrosa = false) //No es peligrosa al inicio

/*ALUMNOS*/
const harryBotter = new BotEstudiante(cargaElectrica  = 80, aceite = "Sucio")
const ronBotsley = new BotEstudiante(cargaElectrica  = 20, aceite = "Puro")
const hermioneBotnger = new BotEstudiante(cargaElectrica  = 70, aceite = "Puro")
const dracoBotfoy = new BotEstudiante(cargaElectrica  = 30, aceite = "Sucio")
const ginnyBotsley = new BotEstudiante(cargaElectrica  = 60, aceite = "Puro")

/*PROFESORES*/
const albusBotbledore = new BotProfesor(cargaElectrica  = 150, aceite = "Puro", casa = gryffindor, materiasDictadas = 0)
const severusBotnape = new BotProfesor(cargaElectrica  = 130, aceite = "Sucio", casa = slytherin, materiasDictadas = 0)

/*MATERIAS*/
const materiaUno = new Materia(nombre = "Defensa contra los hackeos oscuros", profesorAsignado = severusBotnape, hechizoEnsenado = inmobilus)
const materiaDos = new Materia(nombre = "El arte de la olvidar", profesorAsignado = albusBotbledore, hechizoEnsenado = olvidus)
const materiaTres = new Materia(nombre = "Ataque oscuro", profesorAsignado = severusBotnape, hechizoEnsenado = sectumSempra)
