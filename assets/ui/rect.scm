(gui "gui-rect"
    (state! "colour" (239 239 239))
    (state! "radius" (quote (/ 18.0 (+ width height))))
    (render (render-rect rect colour radius))
)