# lang-compare

similar to https://programming-language-benchmarks.vercel.app/, implementation matters
intel n100

|                 | 126 MB Read, Count Lines (ms) | 126 MB read,parse | 13.8 GB Read, Count |
| :-------------- | :---------------------------: | ----------------- | ------------------- |
| c gcc           |              55               | 425               | 29,585              |
| go              |              90               | 350               | 31,973              |
| rust            |              120              | 415               | 77,947              |
| zig             |              134              | 250               | 28,870 to 31,000    |
| odin            |              137              |                   | os "Killed"         |
| python          |              142              | 560               | 113,000             |
| c#              |              149              | 650               | 50,731              |
| nasm            |              155              |                   |                     |
| nasm simd       |                               |                   |                     |
| py multi-thread |              160              |                   | os "Killed"         |
| go (4 threads)  |              200              |                   |                     |
| julia           |              235              | 925               | 66,300              |
| luajit          |              289              |                   |
| java aot        |              328              | 700               | 79,648              |
| clojure         |              500              | 1700              | 113,967             |
| java jit        |              527              | 800               | 90,809              |
| gleam           |              520              |                   |
| elixir          |              663              |                   |
| scala           |              691              | 1488              | 86,549 to 127,568   |
| roc             |             1000              |                   |

Compiling

- helped significantly: zig, rust, odin
- did not help significantly: go, c#, clojure

Other

- go: great performance out of box
- luajit: easy install, decent performance, repl
- performance from 126mb to 13.8gb is worse than linear (110x). e.g. c for 126mb x 110 would be 6,050ms, vs 29,585ms

<br>

| Insert File to Postgres | Duration | Processes |
| :---------------------- | :------: | --------- |
| py batch size 1000      |   69s    | 1         |
| py batch size 50000     |   63s    | 1         |
| py copy_from postgres   |    5s    |
| go batch size 1000      |   54s    | 1         |
| go batch size 5000      |   58s    | 1         |

Go inserted about 20% faster, not much. Claude > ChatGpt
