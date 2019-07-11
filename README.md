# JAM.jl  

*I think it's time we blow this scene. Get everybody and the stuff together. Ok? 3, 2, 1: Let's jam.* Tank, Yoko Kanno (Cowboy Bebop opening theme)   

It provides capabilities for  basic pipeline of analysis (e.g. exploration, visualization, diagnostics) given an ordinary Julia function (e.g. linear regression `lm(@formula(y~x),data)`).  
*JAM.jl* enables one to play with a band of models.  

---  

Version  : 0.0.2
Date     : 11 Jul 2019  
Maintainer: Felipe C. Argolo [@argolof](https://github.com/fargolo)  

---  

**JAM.jl** exposes functions through RESTful API and widgets for interactive management and visualization of objects. Once a functionality is loaded, it can be activated with **POST** requests `http://jam-url.com/run/my-linear-model/` containing adequate arguments.  
The following example takes a pair of vectors (X,Y) and fits a linear regression model to it.  
```julia
# Data frame df is generated in /test/generate_samples.jl and contains variables x and y_linear
julia>json_load = """
{ \"source\" : \"json_stream\",
\"x\" : $(df.x),
\"y\" : $(df.y_linear)}"""
julia> url_query = "http://jam-url.com/run/my-linear-model/"
julia> HTTP.request("POST", url_query,["Content-Type" => "application/json"],json_load)
HTTP.Messages.Response:
"""
HTTP/1.1 200 OK
(...){"error": false, "result": "Outputs saved to lm-2019-07-11T16:06:07.821"}"""
```  
File lm-2019-07-11T16:06:07.417.csv contains outputs. 

Data and relevant outputs are stored and can be retrieved later for data visualization, exploration and diagnostics in `http://jam-url.com/display/`.

Visiting the web page `http://jam-url.com/run/my-linear-model/` or using the **GET** method will yield information about methods supported:  
`Hello! Methods for my-linear-model are: Method[lm(X, y) in GLM (..)`  

### Roadmap:    

		*  Methods to import functionalities (**Beagle.jl**, **Abu.jl**)
			*  Import models and create adequate endpoints.    
			*  Import widgets and add them to the display available list.   
		*  `Display` screen.  
			*  Sidepanel with IDs from analysis  
			*  Standard X-Y Widget (in Beagle.jl)  
		*  List of models/datasets screen (View of SQL DB)   
		*  Init Docker containers for predict tasks (**Infra.jl**)   
		*  Built-in system to keep track of dataset versions and analysis using MD5 checksum or similar.  
