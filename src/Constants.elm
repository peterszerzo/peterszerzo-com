module Constants exposing (..)

import Time exposing (Time, millisecond)


tick : Time.Time
tick =
    300 * Time.millisecond


showNotificationAt : Time.Time
showNotificationAt =
    30 * Time.second


hideNotificationAt : Time.Time
hideNotificationAt =
    48 * Time.second


transitionEvery : Time.Time
transitionEvery =
    8 * Time.second


transitionFor : Time.Time
transitionFor =
    1.5 * Time.second
