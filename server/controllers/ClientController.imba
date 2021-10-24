import client from '../../client/index.html'
import BaseController from './BaseController'

export default class ClientController < BaseController
	def clientBody
		client.body

	def index()
		if req.accepts(['image/*', 'html']) !== 'html'
			return res.sendStatus(404)
		res.send clientBody!
 