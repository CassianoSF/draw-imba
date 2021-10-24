import { Request, Response } from 'express'

export default global class Controller
	prop req\Request
	prop res\Response
	prop _beforeAction = []

	constructor(req\Request|any, res\Response|any)
		self.req = req
		self.res = res

	set beforeAction(args\string|string[])
		if args isa Array
		then _beforeAction.push(...args) 
		else _beforeAction.push(args)

	def execBeforeAction
		for callback of _beforeAction
			await self[callback]()