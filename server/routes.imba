import ClientController from './controllers/ClientController'

export default [
	new Route('get', /.*/, ClientController, 'index')
]