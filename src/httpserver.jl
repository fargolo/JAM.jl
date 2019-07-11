using HTTP, Sockets, JSON2
using GLM
using CSV: write
using Dates: now

include("json-handlers.jl")

struct T
    source::String
    x::Array
    y::Array
end

function runJAMmodel(req::HTTP.Request)
    jamparams = JSON2.read(IOBuffer(HTTP.payload(req)), T)
    modelid = HTTP.URIs.splitpath(req.target)[2]
    if (jamparams.source == "json_stream")
        df = DataFrame(x_inw=jamparams.x,y_inw=jamparams.y)
        lin_fit = lm(@formula(y_inw ~ x_inw),df) # launch in container
        df.yhat = predict(lin_fit) # launch in container
        CSV.write("test/tmp/$(modelid)-$(Dates.now()).csv" ,df)
        return HTTP.Response(200, JSON2.write("Outputs saved to $(modelid)-$(Dates.now())"))
    else
        return HTTP.Response(200)
    end
end


function runJAMinfo(req::HTTP.Request)
    modelid = HTTP.URIs.splitpath(req.target)[2]
    print_methods = sprint(println,methods(GLM.lm).ms)
    return ("Hello! Methods for model $modelid are: $print_methods")
end

const JAM_ROUTER = HTTP.Router()
HTTP.@register(JAM_ROUTER, "POST", "/run/*", runJAMmodel)
HTTP.@register(JAM_ROUTER, "GET", "/run/*", runJAMinfo)

HTTP.serve(JSONHandler, Sockets.localhost, 8081)
HTTP.serve(JAM_ROUTER, Sockets.localhost, 8081)
