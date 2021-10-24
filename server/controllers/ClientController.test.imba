import '../globals'
import ClientController from './ClientController'
import { Request, Response } from 'express'

describe('server > controllers > ClientController', &) do
	const req = { accepts: jest.fn() }
	const res = { sendStatus: jest.fn(), send: jest.fn() }

	beforeEach do
		jest.resetAllMocks()

	it('index must accept html request', &) do |done|
		const controller = new ClientController(req, res)
		const clientBodySpy = jest.spyOn(controller, 'clientBody').mockImplementation(do 'client body')
		const acceptsSpy = jest.spyOn(req, 'accepts').mockImplementation(do 'html')
		const sendStatusSpy = jest.spyOn(res, 'sendStatus')
		const sendSpy = jest.spyOn(res, 'send')
		controller.index()

		expect(acceptsSpy).toHaveBeenCalledWith(['image/*', 'html'])
		expect(sendStatusSpy).not.toHaveBeenCalled()
		expect(clientBodySpy).toHaveBeenCalled()
		expect(sendSpy).toHaveBeenCalledWith('client body')
		done()

	it('index must sendStatus 404 if not html request', &) do |done|
		const controller = new ClientController(req, res)
		const clientBodySpy = jest.spyOn(controller, 'clientBody').mockImplementation(do 'client body')
		const acceptsSpy = jest.spyOn(req, 'accepts').mockImplementation(do 'image/png')
		const sendStatusSpy = jest.spyOn(res, 'sendStatus')
		const sendSpy = jest.spyOn(res, 'send')
		controller.index()

		expect(acceptsSpy).toHaveBeenCalledWith(['image/*', 'html'])
		expect(sendStatusSpy).toHaveBeenCalledWith(404)
		expect(clientBodySpy).not.toHaveBeenCalled()
		expect(sendSpy).not.toHaveBeenCalled()
		done()
