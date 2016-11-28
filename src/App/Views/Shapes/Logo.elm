module Views.Shapes.Logo exposing (..)

import Html exposing (Html)
import Svg exposing (svg, g, path)
import Svg.Attributes exposing (viewBox, stroke, fill, strokeWidth, strokeLinecap, strokeLinejoin, d)


view : Html a
view =
    svg [ viewBox "0 0 250 250" ]
        [ g
            [ fill "none"
            , strokeWidth "3.5"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            ]
            [ path [ d "M61.448 142.317l-30.25 38.185M62.64 141.508l5.252-6.632M134.531 168.821l-49.135 62.035M114.354 108.486l-6.871 8.672M134.342 136.304l2.552 2.021M89.19 139.857l5.102 4.042M69.929 136.03l-1.531-1.214M149.816 123.639l6.63 5.253M146.425 100.271l-3.571-2.829M151.295 136.38l5.25-6.633M97.741 139.791l-3.234 4.083M103.38 114.391l3.572 2.83M64.849 108.217l-7.655-6.062M93.991 89.203l-.806 1.02M91.807 69.421l43.505-54.926M141.342 83.504l38.554-48.672M60.737 96.724l-3.638 4.59M98.255 180.171l-33.049 41.723M179.162 179.579l-44.297 55.926M174.547 139.149l4.041-5.101M52.646 102.221L23.085 78.806M200.8 131.006l26.115-32.973M178.588 134.048l22.212-3.042M174.547 139.149l4.615 40.43M132.129 145.695l2.402 23.126M142.502 97.482l-1.16-13.978M93.991 89.203l-2.184-19.782M100.947 97.696l2.433 16.695M114.354 108.486l22.085-3.35M156.446 128.892l14.946-1.268M136.914 138.51l14.381-2.13M116.793 137.493l17.549-1.189M97.741 139.791l6.082-1.112M94.292 143.899l3.963 36.272M109.14 131.434l-2.188-14.213M67.892 134.876l-3.043-26.659M52.646 102.221l4.453-.907" ] []
            ]
        ]