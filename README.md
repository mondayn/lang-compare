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
| c#              |           149           | 650          |
| sa              |           149           | 650          |
| nasm (not simd) |           155           |
| py multi-thread |           160           |
| go (4 threads)  |           200           |
| julia           |           235           | 925          |
| clojure         |           500           | 1700         |

<br>
Compiliation efforts

- helped significantly: zig, rust
- did not help significantly: go, c#, clojure

<br>
TODO

- nasm simd
- roc

| Insert File to Postgres | Duration (ms) | Memory |
| :---------------------- | :-----------: | -----: |
| python                  |               |        |
