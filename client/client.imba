const store = {
	objects: [
		{
			class: 'Rectangle'
			x: 0
			y: 0
			height: 100
			width: 200
			color: "white"
			stroke: "steelblue"
			text: "Hello Imba"
		}
	]
}

global css *
	p: 0; m:0
	ff: sans

	text
		user-select: none

tag client
	prop view = { 
		height: window.innerHeight
		width: window.innerWidth
		x: 0 
		y: 0
		zoom: 1 
	}
	prop mouse = {
		x: 0 
		y: 0
		left: false
		right: false
	}
	prop keys = {}
	prop menu = { open: false, x: null, y: null }
	prop grabbing = null
	prop editing = null

	def mount
		window.addEventListener('resize', &) do
			view.height = window.innerHeightgrabbing
			render!

	def mousemove e
		mouse.x = e.x
		mouse.y = e.y
		if(moving)
			view.x += e.movementX / view.zoom
			view.y += e.movementY / view.zoom
		if(grabbing)
			grabbing.x += e.movementX / view.zoom
			grabbing.y += e.movementY / view.zoom

	def mousedown e
		mouse.left = true if e.button === 0
		mouse.right = true if e.button === 2
		menu.open = true if mouse.right
		if(mouse.left && e.target === $svg)
			moving = true
		if !e.path.includes($menu)
			menu.open = false if mouse.left
			menu.x = mouse.x
			menu.y = mouse.y
		editing = null

	def mouseup e
		mouse.left = false if (e.button === 0) 
		mouse.right = false if (e.button === 2) 
		moving = false
		grabbing = null

	def mousewheel e
		if(e.deltaY > 0)
			return if view.zoom < 0.2
			view.zoom -= 0.1
		else
			view.zoom += 0.1

		view.x = view.x - ((mouse.x - (view.width / 2)) / (view.zoom * 2))
		view.y = view.y - ((mouse.y - (view.height / 2)) / (view.zoom * 2))

	def addObject(e)
		store.objects.push({
			class: 'Rectangle'
			x: ((mouse.x - (view.width / 2)) / view.zoom) - view.x 
			y: ((mouse.y - (view.height / 2)) / view.zoom) - view.y 
			height: 100
			width: 200
			color: "white"
			stroke: "steelblue"
			text: "test"
		})
		menu.open = false

	def grabObj(obj)
		grabbing = obj

	def editObj(obj)
		editing = obj

	def calcObjLeft(obj)
		((obj.x + view.x) * view.zoom + (view.width / 2))

	def calcObjTop(obj)
		((obj.y + view.y) * view.zoom + (view.height / 2))

	<self>
		if(editing)
			<input bind=editing.text [
				text-align: center
				position: absolute 
				font-size: {16 * view.zoom}px
				top: {calcObjTop(editing)}px 
				left: {calcObjLeft(editing)}px 
				color: black
				width: {editing.width * view.zoom * 0.9}px
				transform: translate(-50%, -50%)
			]>
		<svg$svg
			@mousemove=mousemove 
			@mousedown=mousedown 
			@mouseup=mouseup
			@mousewheel.prevent=mousewheel
			@contextmenu.prevent
			width="{view.width}px" 
			height="{view.height}px">
			<g [transform: translate({view.width / 2}px, {view.height / 2}px)]>
				<g [transform: scale({view.zoom}, {view.zoom}) translate({view.x}px, {view.y}px)]>
					for obj of store.objects
						<g 
							[transform: translate({ obj.x - obj.width/2 }px, { obj.y - obj.height/2 }px)]
							@mousedown=grabObj(obj)
							@dblclick=editObj(obj)
							width=obj.width 
							height=obj.height>
							<rect 
								width=obj.width
								height=obj.height
								fill=obj.color
								stroke=obj.stroke
								stroke-width=2
								rx=10>
							<text
								[transform: translate({obj.width/2}px, {obj.height/2}px)] 
								dominant-baseline="middle"
								text-anchor="middle"> 
									obj.text

			if menu.open
				<g$menu [transform: translate({menu.x}px, {menu.y}px) ]>
					<g @click=addObject [transform: translateY(50) ]>
						<rect width=150 height=40 fill="#454555" stroke="black" stroke-width=2>
						<text [transform: translate({150/2}px, {40/2}px)] dominant-baseline="middle" text-anchor="middle" fill="white">
							"Add Rectangle"

imba.mount <client>