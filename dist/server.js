'use strict'
let
connect ,
serveStatic


connect = require('connect')
serveStatic = require('serve-static')


connect().use
(
	serveStatic
	(__dirname)
)
.listen(8888)