extends Node

var http_request: HTTPRequest
var server = TCPServer.new()
var client: StreamPeerTCP

func _ready():
	# --- Partie 1 : Envoi de l'IP au serveur Symfony ---
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	
	var ip_list = IP.get_local_addresses()
	var local_ip = ""

	for address in ip_list:
		if address.begins_with("192.") or address.begins_with("10.") or address.begins_with("172."):
			local_ip = address
			break

	if local_ip == "":
		print("Impossible de trouver une IP locale")
		return

	print("📡 IP locale envoyée :", local_ip)

	var url = "https://symfony-app-production.up.railway.app/sendIp"
	var headers = ["Content-Type: application/json"]
	var body = JSON.stringify({"ip": local_ip})

	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, body)

	if error != OK:
		print("❌ Erreur lors de l'envoi de la requête :", error)

	# --- Partie 2 : Démarrage du serveur TCP ---
	server.listen(8000)
	print("🚀 Serveur TCP en écoute sur le port 8000")

func _process(_delta):
	if server.is_connection_available():
		client = server.take_connection()
		if client:
			print("✅ Client connecté :", client.get_connected_host())
	
	if client and client.get_available_bytes() > 0:
		var message = client.get_string(client.get_available_bytes())
		print("📩 Message reçu :", message)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("✅ IP envoyée avec succès")
	else:
		print("❌ Erreur lors de l'envoi de l'IP :", response_code)
