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
    12 * Time.second


transitionStartingAt : Time.Time
transitionStartingAt =
    3 * Time.second
