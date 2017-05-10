port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram, toFileStructure, compiler, compile)
import Styles


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    toFileStructure [ ( "dist/styles.css", compile [ Styles.css ] ) ]


main : CssCompilerProgram
main =
    compiler files fileStructure
