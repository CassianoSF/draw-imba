import Server from './Server.imba'

describe('server > Server', &) do
	const port = 4001
	const server = new Server(port)

	it('initRack must start router', &) do |done|
		const routerStart = jest.spyOn(server.router, "start")
		server.initRack()
		expect(routerStart).toHaveBeenCalled()
		done()

	it('start must initialize middleware rack and listen port', &) do |done|
		const initRack = jest.spyOn(server, "initRack")
		const listen = jest.spyOn(server.server, "listen")
		server.start()
		server.stop()
		expect(initRack).toHaveBeenCalled()
		expect(listen).toHaveBeenCalledWith(port)
		done()

	it('stop must close server hundle', &) do |done|
		server.start()
		const close = jest.spyOn(server.handle, "close")
		server.stop()
		expect(close).toHaveBeenCalled()
		done()