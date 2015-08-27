import asynchttpserver, asyncdispatch, redis, cgi


proc incrHandler(req: Request) {.async.} =
  var distribution, field: string
  for k, v in cgi.decodeData(req.url.query):
    if k == "distribution":
      distribution = v
    if k == "field":
      field = v

  await req.respond(Http200, "OK")

proc distHandler(req: Request) {.async.} =
  var distribution: string
  for k, v in cgi.decodeData(req.url.query):
    if k == "distribution":
      distribution = v

  await req.respond(Http200, "OK")


proc getHandler(req: Request) {.async.} =
  var distribution, field: string
  for k, v in cgi.decodeData(req.url.query):
    if k == "distribution":
      distribution = v
    if k == "field":
      field = v

  await req.respond(Http200, "OK")


var server = newAsyncHttpServer()
proc handler(req: Request) {.async.} =
  if req.url.path == "/ping":
    await req.respond(Http200, "OK")
  elif req.url.path == "/incr":
    await incrHandler(req)
  elif req.url.path == "/get":
    await getHandler(req)
  elif req.url.path == "/dist":
    await distHandler(req)
  else:
    await req.respond(Http404, "<h1>Not Found</h1>")

waitFor server.serve(Port(8080), handler)
