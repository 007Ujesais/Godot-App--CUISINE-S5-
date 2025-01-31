extends Node
pas sur localhost mais sur l'ip vue que je vais l'appeler dans railway genre pour appler ce HTTP serveur c'est non tu voit pour appeler godot j'utilise http://mon ip:8080
var server : TCPServer
var port : int = 8080  # Port sur lequel le serveur écoute

func _ready():
	server = TCPServer.new() 
	if server.listen(port) == OK:
		print("Serveur démarré sur le port ", port)
	else:
		print("Impossible de démarrer le serveur.")

func _process(delta):
	if server.is_connection_available():
		var peer : StreamPeerTCP = server.take_connection()
		handle_client(peer)

func handle_client(peer: StreamPeerTCP):
	# Lire les données brutes
	var bytes = peer.get_available_bytes()
	if bytes > 0:
		var data = peer.get_data(bytes)
		if data[0] == OK:  # Vérifier si la lecture a réussi
			var request_data = data[1].get_string_from_utf8()
			print("Requête reçue:\n", request_data)

			# Analyser la requête pour déterminer si c'est GET ou POST
			if request_data.begins_with("GET"):
				handle_get_request(peer)
			elif request_data.begins_with("POST"):
				handle_post_request(peer, request_data)
			else:
				send_response(peer, 400, "Bad Request")
		else:
			print("Erreur lors de la lecture des données.")
			send_response(peer, 500, "Internal Server Error")
	else:
		print("Aucune donnée reçue.")
		send_response(peer, 400, "Bad Request")

func handle_get_request(peer: StreamPeerTCP):
	# Répondre à une requête GET
	var response = "HTTP/1.1 200 OK\r\n"
	response += "Content-Type: text/plain\r\n"
	response += "\r\n"
	response += "Hello, GET request received!"
	peer.put_data(response.to_utf8_buffer())  # Correction ici

func handle_post_request(peer: StreamPeerTCP, request_data: String):
	# Extraire le corps de la requête POST
	var body = request_data.split("\r\n\r\n")
	if body.size() > 1:
		var post_body = body[1]
		print("Corps de la requête POST: ", post_body)

		# Répondre à une requête POST
		var response = "HTTP/1.1 200 OK\r\n"
		response += "Content-Type: text/plain\r\n"
		response += "\r\n"
		response += "Hello, POST request received! Body: " + post_body
		peer.put_data(response.to_utf8_buffer())  # Correction ici
	else:
		print("Aucun corps trouvé dans la requête POST.")
		send_response(peer, 400, "Bad Request")

func send_response(peer: StreamPeerTCP, status_code: int, message: String):
	var response = "HTTP/1.1 " + str(status_code) + " " + message + "\r\n"
	response += "Content-Type: text/plain\r\n"
	response += "\r\n"
	response += message
	peer.put_data(response.to_utf8_buffer())  # Correction ici
