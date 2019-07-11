using Joseki, JSON, HTTP
using GLM
using CSV
using Dates
using DataFrames

function runJAMmodel(req::HTTP.Request)
    modelid = HTTP.URIs.splitpath(req.target)[2]
    jamparams = try
                body_as_dict(req)
            catch err
                return error_responder(req"Bad format in JSON load!")
            end
    has_all_required_keys(["source","x", "y"], jamparams) || return error_responder(req, "Sorry, JSON object requires source, x and y!")
    req_source = get(jamparams, "source", "unsupported_source")
    req_x = get(jamparams, "x", 0) |> (x -> convert(Array{Float64,1},x))
    req_y = get(jamparams, "y", 0) |> (x -> convert(Array{Float64,1},x))


    if (req_source == "json_stream")
        df = DataFrame(x_inw=req_x,y_inw=req_y)
        lin_fit = lm(@formula(y_inw ~ x_inw),df) # launch in container
        df.yhat = predict(lin_fit) # launch in container
        CSV.write("test/tmp/$(modelid)-$(Dates.now()).csv" ,df)
        json_responder(req, "Outputs saved to $(modelid)-$(Dates.now())")
    else
        json_responder(req, "Unsupported method. Please send data over JSON payload: source, x, y.")
    end
end

function runJAMinfo(req::HTTP.Request)
    modelid = HTTP.URIs.splitpath(req.target)[2]
    print_methods = sprint(println,methods(GLM.lm).ms)
    return ("Hello! Methods for model $modelid are: $print_methods")
end

jam_routes = [
(runJAMmodel, "POST", "/run/*"),
(runJAMinfo, "GET", "/run/*")
]

jam_r = Joseki.router(jam_routes)
HTTP.serve(jam_r, "127.0.0.1", 8081)
