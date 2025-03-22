# lang-compare

intel n100

to do: measure max memory used during process

| 126 mb file     | Read & Count lines (ms) | Read & Parse |
| :-------------- | :---------------------: | ------------ |
| c gcc           |           55            | 425          |
| go              |           90            | 350          |
| python          |           142           | 560          |
| dotnet9         |           169           | 782          |
| go (4 threads)  |           200           |
| julia           |           235           | 925          |
| rust            |           300           | 1000         |
| py multi-thread |           160           |
| roc             |                         |
| clojure         |                         |

<br>

TODO

| Insert File to Postgres | Duration (ms) | Memory |
| :---------------------- | :-----------: | -----: |
| python                  |               |        |
