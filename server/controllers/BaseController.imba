export default class BaseController < Controller
	// @ts-ignore
	beforeAction = 'logger'

	def logger
		console.log("[{new Date().toJSON()}] {req.method} - {req.url} - ", req.params)

