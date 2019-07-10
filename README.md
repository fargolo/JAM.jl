# JAM.jl
---  

Version  : 0.0.1
Date     : 10 Jul 2019  
Mantainer: Felipe C. Argolo [@argolof](https://github.com/fargolo)  

To do:  
	* JAMDev with functions to make RESTful API from f(x,y). Use Mux.    
 
	*  Init containers from JAM modules   
		*  Import from JAM modules  
			*  Models   
			*  Widgets  
		*  Build RESTful API from base container with Julia.   
	*  `Display` screen.  
		*  Sidepanel with IDs from analysis  
		*  Standard X-Y Widget (in Beagle.jl)  
		*  Try to run imported widgets 
	*  List of models/datasets screen (View of SQL DB)   
	*  Run (POST)
		*  Fill text input targets (POST using JSON stream).  
		*  Select file (copy from disk to container jam/volumes/data volume) and run fields (POST using file source).  
		*  Fill text input targets (POST using remote DB with queries; e.g. remote MySQL)  
