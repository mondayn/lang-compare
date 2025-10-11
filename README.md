# lang-compare

similar to https://programming-language-benchmarks.vercel.app/, implementation matters

intel n100

| 126 mb file     | Read & Count lines (ms) | Read & Parse |
| :-------------- | :---------------------: | ------------ |
| c gcc           |           55            | 425          |
| go              |           90            | 350          |
| rust            |           120           | 415          |
| zig             |           134           | 250          |
| odin            |           137           |              |
| python          |           142           | 560          |
| c#              |           149           | 650          |
| nasm            |           155           |
| py multi-thread |           160           |
| go (4 threads)  |           200           |
| julia           |           235           | 925          |
| luajit          |           289           |              |
| java aot        |           328           | 700          |
| clojure         |           500           | 1700         |
| java jit        |           527           | 800          |
| gleam           |           520           |              |
| elixir          |           663           |              |
| scala           |           691           | 1488         |
| roc             |          1000           |              |

<br>
Compiliation efforts

- helped significantly: zig, rust, odin
- did not help significantly: go, c#, clojure

<br>
- golang - great performance out of box
- luajit - easy install, decent performance, repl

<br>
TODO

- nasm simd

| Insert File to Postgres | Duration | Processes |
| :---------------------- | :------: | --------- |
| py batch size 1000      |   69s    | 1         |
| py batch size 50000     |   63s    | 1         |
| py copy_from postgres   |    5s    |
| go batch size 1000      |   54s    | 1         |
| go batch size 5000      |   58s    | 1         |

Go inserted about 20% faster, not much. Claude > ChatGpt

TODO
4 processes
