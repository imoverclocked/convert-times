A quick sketch of how to convert between System.Clock and Data.Time formats. YMMV because this was written quickly without digging deep into System.Clock.

When the executable is run, you may see something along the lines of:
```
     SystemClock(Realtime): TimeSpec {sec = 1682155611, nsec = 83001000}
                 Data.Time: 2023-04-22 09:26:51.083812 UTC
--------------------------------------------------------------------------------
converting between these two time formats
--------------------------------------------------------------------------------
          SystemClock->UTC: 2023-04-22 09:26:51.083001 UTC
UTC->SystemClock(Realtime): TimeSpec {sec = 1682155611, nsec = 83812000}
```