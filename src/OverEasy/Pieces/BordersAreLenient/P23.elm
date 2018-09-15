module OverEasy.Pieces.BordersAreLenient.P23 exposing (view)

import Html exposing (Html)
import Svg exposing (circle, g, line, path, polygon, polyline, svg)
import Svg.Attributes exposing (class, cx, cy, d, points, r, viewBox, x1, x2, y1, y2)


view : Html msg
view =
    svg [ viewBox "0 0 250 200" ]
        [ g [ class "engrave" ]
            [ path [ d "M119.094,53.395 c-11.912,1.471-22.85,7.328-30.676,16.43" ] []
            , path [ d "M94.113,138.332 c8.67,7.227,19.6,11.184,30.887,11.184" ] []
            , path [ d "M155.887,138.332 c3.166,2.057,5.432,4.148,5.627,4.426c0.334,0.471,1.525,1.262,1.887,1.092c0.361-0.172-0.135-1.486-0.135-1.486 c-0.641-1.787-3.152-3.869-5.652-5.541" ] []
            , path [ d "M168.953,121.158 c3.035,1.742,5.59,3.324,5.766,3.521c0.391,0.436,1.486,1.469,2.197,1.105c0.711-0.365-0.434-1.912-0.434-1.912 c-0.709-1.309-3.566-3.506-6.391-5.451" ] []
            , path [ d "M125,70.27c0,0,6.207-0.027,11.867,2.445" ] []
            , path [ d "M164.148,73.086 c1.312-0.574,3.529-1.523,5.066-2.078c2.363-0.852,0.045-1.697,0.045-1.697c-2.031-0.678-5.029-0.209-7.678,0.514" ] []
            , path [ d "M81.047,121.158 c2.764,6.107,6.398,11.131,11.34,15.664" ] []
            , path [ d "M85.852,73.086 c-9.473,13.154-11.705,30.186-5.943,45.336" ] []
            , path [ d "M125,53.031 c-0.77,0-1.537,0.02-2.305,0.057" ] []
            , path [ d "M130.906,53.395 c-0.213-1.572,1.688-3.516,1.688-3.516s0.67-0.959-1.412-0.52c-1.408,0.295-3.445,2.08-3.877,3.729" ] []
            ]
        , g [ class "cut" ]
            [ path [ d "M125,140.121 c-10.883-2.723-19.998-15.443-20.707-16.844c-0.479-0.941-1.566-0.49-1.566-0.49c-0.973,0.314-1.771,0.602-3.314,1.725 c-1.545,1.125-0.574,2.012-0.574,2.012c0.951,1.234,0.904,2.02,3.334,4.77s-0.406,3.391-0.406,3.391 c-6.582,1.84-12.945,7.602-13.279,8.074c-0.334,0.471-1.525,1.262-1.887,1.092c-0.363-0.172,0.133-1.486,0.133-1.486 c1.195-3.334,8.904-7.695,10.898-8.508c1.994-0.814,0.441-2.6,0.441-2.6c-1.1-1.59-5.043-4.727-6.662-5.781 s-0.162-2.295-0.162-2.295c1.689-1.418,6.303-4.082,7.883-4.861s0.996-1.162,0.996-1.162c-2.211-2.814-3.166-9.072-3.734-10.807 s-1.676-1.459-1.676-1.459c-2.459,0.617-2.523,0.93-4.002,1.684c-1.221,0.625-0.783,1.766-0.783,1.766 c0.777,1.83,1.418,4.875,1.756,6.293c0.336,1.42-0.838,1.662-0.838,1.662c-3.045,0.668-15.178,7.949-15.568,8.385 s-1.486,1.469-2.197,1.105c-0.711-0.365,0.434-1.912,0.434-1.912c1.414-2.605,11.352-8.748,12.572-9.365 c1.219-0.617,0.742-1.938,0.742-1.938c-0.336-1.488-3.59-6.666-4.408-7.699c-0.766-0.969-0.049-1.467-0.049-1.467 c1.449-1.014,11.461-4.066,12.68-4.311c1.168-0.234,1.027-0.705,1.027-0.705c-0.035-1.971,0.785-5.018,1.189-6.289 c0.402-1.271-0.826-1.58-0.826-1.58s-8.701-3.621-12.861-5.318c-2.174-0.887-0.896-2.123,0.576-4.084 c0.854-1.139,1.979-1.902,3.289-6.068c0.395-1.256-0.506-1.482-0.506-1.482s-3.848-1.725-6.16-2.559 c-2.361-0.852-0.043-1.697-0.043-1.697c4.164-1.393,12.406,2.051,13.354,2.582s0.607,1.164,0.607,1.164s-3.191,5.83-3.807,6.912 s0.305,1.385,0.305,1.385l8.648,2.814c0.52,0.254,0.84-0.369,0.986-0.641c3.549-6.664,12.299-10.812,12.299-10.812 c-0.641-6.48,5.738-10.008,5.738-10.008c-7.236-3.324-1.266-6.957-0.074-8.572s-1.391-4.256-1.391-4.256s-0.672-0.959,1.412-0.52 c2.084,0.438,5.553,4.145,3.133,5.828s0.393,3.104,0.871,3.99c0.479,0.883,0.262,1.277,0.551,1.527 c0.291,0.248,0.832,0.037,1.627,0.023" ] []
            , path [ d "M161.582,69.824 c-2.787,0.76-5.189,1.797-5.676,2.068c-0.947,0.531-0.607,1.164-0.607,1.164s3.191,5.83,3.807,6.912s-0.305,1.385-0.305,1.385 l-8.648,2.814c-0.52,0.254-0.842-0.369-0.986-0.641c-3.549-6.664-12.299-10.812-12.299-10.812 c0.641-6.48-5.738-10.008-5.738-10.008c7.236-3.324,1.266-6.957,0.074-8.572c-0.17-0.229-0.262-0.479-0.297-0.74" ] []
            , circle [ cx "125", cy "101.273", r "62.361" ] []
            , path [ d "M170.092,118.422 c-2.803-1.928-5.572-3.605-6.182-3.914c-1.221-0.617-0.742-1.938-0.742-1.938c0.336-1.488,3.59-6.666,4.406-7.699 c0.768-0.969,0.051-1.467,0.051-1.467c-1.449-1.014-11.461-4.066-12.68-4.311c-1.168-0.234-1.027-0.705-1.027-0.705 c0.035-1.971-0.785-5.018-1.189-6.289c-0.402-1.271,0.826-1.58,0.826-1.58s8.701-3.621,12.861-5.318 c2.174-0.887,0.895-2.123-0.576-4.084c-0.854-1.139-1.979-1.902-3.289-6.068c-0.395-1.256,0.506-1.482,0.506-1.482 s0.432-0.193,1.092-0.48" ] []
            , line [ x1 "125", y1 "60.729", x2 "125", y2 "70.27" ] []
            , path [ d "M157.613,136.822 c-2.164-1.449-4.32-2.59-5.244-2.967c-1.994-0.814-0.441-2.6-0.441-2.6c1.1-1.59,5.043-4.727,6.662-5.781s0.162-2.295,0.162-2.295 c-1.689-1.418-6.303-4.082-7.883-4.861s-0.996-1.162-0.996-1.162c2.211-2.814,3.166-9.072,3.734-10.807s1.676-1.459,1.676-1.459 c2.459,0.617,2.523,0.93,4.002,1.684c1.221,0.625,0.783,1.766,0.783,1.766c-0.777,1.83-1.418,4.875-1.756,6.293 c-0.338,1.42,0.838,1.662,0.838,1.662c1.674,0.367,6.096,2.734,9.803,4.863" ] []
            , path [ d "M125,88.404 c0-1.25,1.703-3.219,2.82-3.049" ] []
            , path [ d "M125,140.121 c10.883-2.723,19.998-15.443,20.707-16.844c0.477-0.941,1.566-0.49,1.566-0.49c0.973,0.314,1.771,0.602,3.314,1.725 c1.545,1.125,0.574,2.012,0.574,2.012c-0.951,1.234-0.904,2.02-3.334,4.77s0.406,3.391,0.406,3.391 c2.727,0.762,5.414,2.195,7.652,3.648" ] []
            , path [ d "M125,149.516 c11.287,0,22.217-3.957,30.887-11.184" ] []
            , path [ d "M121.742,85.445 c1.053-0.193,3.258-2.17,3.258-3.203" ] []
            , line [ x1 "125", y1 "60.729", x2 "125", y2 "53.031" ] []
            , line [ x1 "125", y1 "140.121", x2 "125", y2 "149.516" ] []
            , line [ x1 "125", y1 "70.27", x2 "125", y2 "82.242" ] []
            , path [ d "M161.582,69.824 c-7.826-9.102-18.764-14.959-30.676-16.43" ] []
            , path [ d "M170.092,118.422 c5.762-15.15,3.529-32.182-5.943-45.336" ] []
            , path [ d "M157.613,136.822 c4.941-4.533,8.576-9.557,11.34-15.664" ] []
            , path [ d "M127.305,53.088 c-0.768-0.037-1.535-0.057-2.305-0.057" ] []
            , line [ x1 "125", y1 "125.789", x2 "125", y2 "140.121" ] []
            , path [ d "M127.418,122.291 c7.26-5.467,12.053-17.143,10.727-25.877c-1.166-7.678-6.303-10.297-10.324-11.059" ] []
            , path [ d "M127.305,53.088 c-0.207,0.791-0.043,1.553,0.744,2.1c2.42,1.684-0.393,3.104-0.871,3.99c-0.479,0.883-0.262,1.277-0.551,1.527 c-0.291,0.248-0.832,0.037-1.627,0.023" ] []
            , path [ d "M125,119.391 c0,0.84,0.926,3.914,2.418,2.9" ] []
            , path [ d "M121.131,121.088 c0.717,0.623,3.869,3.094,3.869,4.701" ] []
            , line [ x1 "125", y1 "88.404", x2 "125", y2 "119.391" ] []
            , path [ d "M121.268,121.211 c0.191,0.172,0.385,0.338,0.58,0.5" ] []
            , path [ d "M121.816,85.43 c-3.961,0.848-8.83,3.535-9.961,10.984c-1.234,8.139,2.842,18.83,9.275,24.674" ] []
            ]
        ]