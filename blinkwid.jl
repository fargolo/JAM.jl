using Interact, Blink
using Gadfly, Distributions
using Match

ui_dist = @manipulate for mu in -10:.1:10, sigma = 0:.1:3
    plot(x -> pdf(Normal(mu, sigma), x), -10, 10)
end
@layout! ui_dist dom"div"(observe(_),:mu,:sigma)

menu_bts = vbox(HTML("""<button class="button" onclick='Blink.msg("press", "Explore")'>Explore</button>"""),
				HTML("""<button class="button" onclick='Blink.msg("press", "Descriptive")'>Descriptive</button>"""),
                HTML("""<button class="button" onclick='Blink.msg("press", "Data")'>Data</button>"""),
                HTML("""<button class="button" onclick='Blink.msg("press", "Diagnostics")'>Diagnostics</button>"""))

main_w = Window(Dict(:show=>true), async=false)
body!(main_w, hbox(menu_bts,ui_dist));
handle(main_w,"press") do args
  @match args begin
	 "Explore"     => body!(main_w,hbox(menu_bts,ui_dist), async=false)
	 "Descriptive" => body!(main_w,hbox(menu_bts,args), async=false)
	 "Data"        => body!(main_w,hbox(menu_bts,args), async=false)
	 "Diagnostics" => body!(main_w,hbox(menu_bts,args), async=false)
  end
end
load!(main_w,"styles/panel_buttons.css")
