using Interact, Mux

loadbutton = filepicker()
hellobutton = button("Hello!")
goodbyebutton = button("Good bye!")
s = slider(1:100)

ui_up = vbox(loadbutton,hbox(hellobutton,goodbyebutton,s,button(s[])))

@app abu = (
    Mux.defaults
#    page("/", req -> ui_dist),
    page("/", req -> ui_up),
    Mux.notfound())

Mux.serve(abu)

#using Gadfly, Distributions

#ui_dist = @manipulate for α in 1:100, β = 1:100
#    plot(x -> pdf(Beta(α, β), x), 0, 1)
#end
#@layout! ui_dist dom"div"(observe(_),:α,:β)
