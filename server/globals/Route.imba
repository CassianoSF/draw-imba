import { Request, Response } from 'express'
import Controller from './Controller'

const ControllerClass = Controller

export default global class Route
	prop method\string
	prop path\RegExp|string
	prop controller\ControllerClass
	prop action\string

	constructor(method\string, path\RegExp|string, controller\ControllerClass, action\string)
		self.method = method
		self.path = path
		self.controller = controller
		self.action = action

	def exec(req\Request, res\Response)
		const controller = new controller(req, res)
		await controller.execBeforeAction()
		await controller[action]()

	def start(server)
		server[method](path, exec.bind(self))