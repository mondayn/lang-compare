# lang-compare

intel n100

to do: measure max memory used during process

| 126 mb file     | Read & Count lines (ms) | Read & Parse |
| :-------------- | :---------------------: | ------------ |
| c gcc           |           55            | 425          |
| go              |           90            | 350          |
| rust            |           120           | 415          |
| zig             |           134           | 250          |
| python          |           142           | 560          |
| py multi-thread |           160           |
| c#              |           149           | 650          |
| go (4 threads)  |           200           |
| julia           |           235           | 925          |
| roc             |                         |
| clojure         |           500           | 1700         |

<br>

TODO
nasm
janet

| Insert File to Postgres | Duration (ms) | Memory |
| :---------------------- | :-----------: | -----: |
| python                  |               |        |
