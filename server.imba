import express from 'express'
import client from './client/index.html'

const server = express()

server.get(/.*/, &) do |req, res|
	unless req.accepts(['image/*', 'html']) == 'html'
		return res.sendStatus(404)
	res.send client.body

imba.serve server.listen(3000)