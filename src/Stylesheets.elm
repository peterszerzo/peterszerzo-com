port module Stylesheets exposing (..)

import Css.File
    exposing
        ( CssFileStructure
        , CssCompilerProgram
        , toFileStructure
        , compiler
        , compile
        )
import Styles
import Styles.Raw exposing (raw)


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    let
        compiledCss =
            compile [ Styles.css ]
    in
        toFileStructure
            [ ( "build/styles.css"
              , { compiledCss
                    | css = raw ++ compiledCss.css
                }
              )
            ]


main : CssCompilerProgram
main =
    compiler files fileStructure
