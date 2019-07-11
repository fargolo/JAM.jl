using HTTP, JSON2

function JSONHandler(req::HTTP.Request)
    # first check if there's any request body
    body = IOBuffer(HTTP.payload(req))
    if eof(body)
        # no request body
        response_body = HTTP.handle(JAM_ROUTER, req)
    else
        # there's a body, so pass it on to the handler we dispatch to
        response_body = HTTP.handle(JAM_ROUTER, req, JSON2.read(body, jamparams))
    end
    return HTTP.Response(200, JSON2.write(response_body))
end
