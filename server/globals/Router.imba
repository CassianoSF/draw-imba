import { Express } from 'express'
import Route from './Route'

export default global class Router
	prop server\Express
	prop routes\Route[]

	constructor(server\Express, routes\Route[])
		self.server = server
		self.routes = routes

	def start
		for route in routes
			route.start(server)