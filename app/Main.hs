module Main where

import Data.Maybe (fromJust)
import Data.Time qualified as DT
import Data.Time.Clock qualified as DTC
import Data.Time.RFC3339 qualified as RFC3339
import System.Clock qualified as SC

{- System.Clock epoch is defined in the RFC: 00:00:00 GMT, January 1, 1970
   Formatting that to RFC3339 gives us: 1970-01-01T00:00:00.00Z
   -}
scEpochInUTC :: DT.UTCTime
scEpochInUTC = DT.zonedTimeToUTC $ fromJust $ RFC3339.parseTimeRFC3339 "1970-01-01T00:00:00.00Z"

{- NB: This code assumes an SC.Realtime clock. If a different clock is used,
   it needs to be converted differently.
    -}
main :: IO ()
main = do
    let
        sc_clock = SC.Realtime
    sc_time <- SC.getTime sc_clock
    putStr "     SystemClock(Realtime): "
    print sc_time

    dtc_time <- DTC.getCurrentTime
    putStr "                 Data.Time: "
    print dtc_time

    putStrLn "--------------------------------------------------------------------------------"
    putStrLn "converting between these two time formats"
    putStrLn "--------------------------------------------------------------------------------"

    let
        sc2diffTime = fromInteger (SC.toNanoSecs sc_time) / 1000000000 :: DTC.NominalDiffTime
        sc2utc = DTC.addUTCTime sc2diffTime scEpochInUTC

    putStr "          SystemClock->UTC: "
    print sc2utc

    let
        diffTime = DTC.diffUTCTime dtc_time scEpochInUTC
        utc2scNS = round $ DTC.nominalDiffTimeToSeconds diffTime * 1000000000
        utc2sc = SC.fromNanoSecs utc2scNS
    putStr "UTC->SystemClock(Realtime): "
    print utc2sc
