const path = require 'path'
const fs = require 'fs'
const jest = require 'jest'
const cp = require 'child_process'

const rootFolder = path.resolve(__dirname, "..")
const distFolder = path.resolve(__dirname, "..", "dist")

def buildTest(dir)
	for src of fs.readdirSync(dir, withFileTypes: true)
		let fullpath = path.resolve(dir, src.name)
		if fullpath.match(/\.test\.imba$/)
			cp.execSync("imba build {fullpath} --clean")
		elif src.isDirectory()
			buildTest(fullpath)

def run
	buildTest(rootFolder)
	const options = { projects: [distFolder], silent: true }
	# // @ts-ignore
	# await jest.runCLI(options, options.projects)
	# await new Promise(&) do |resolve|
	# 	fs.rm(distFolder, { recursive: true }, &) do
	# 		resolve()

run()