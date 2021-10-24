import express from 'express'
import './globals'
import ClientController from './controllers/ClientController'
import routes from './routes'

class Server
	prop port
	prop server
	prop handle
	prop router
	prop routes

	constructor(port)
		self.port = port
		self.server = express()
		self.routes = routes
		self.router = new Router(self.server, self.routes)

	def start
		initRack()
		handle = server.listen(port)

	def stop
		handle.close()

	def initRack()
		router.start()

export default Server
