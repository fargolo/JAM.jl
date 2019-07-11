using JAM, Test

if !isfile("tmp/df_example.csv")
	include("generate_examples.jl")
end

json_load = """
{ \"source\" : \"json_stream\",
\"x\" : $(df.x),
\"y\" : $(df.y_linear)}"""

json_body = JSON2.read(json_load)

url_query_get = "http://127.0.0.1:8081/run/lm"
HTTP.request("POST", url_query,
             ["Content-Type" => "application/json"],
             json_load)

url_query_post = "http://127.0.0.1:8081/params/lm"
HTTP.request("GET", url_query)


#@testset "Transforms Goodness of fit" begin
#	trans_df = TransformGoF(df.x,df.y_linear)
#	@test typeof(trans_df) == DataFrame
#	@test typeof(trans_df.AIC) == Array{Float64,1}
#	@test typeof(trans_df.r2) == Array{Float64,1}
#	@test typeof(trans_df.transforms) == Array{String,1}
#	@test typeof(trans_df.coef[1]) == Array{Float64,1}
#end
