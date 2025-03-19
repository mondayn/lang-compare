# lang-compare

intel n100

| Read 126 mb file | Duration (ms) |          Memory |
| :--------------- | :-----------: | --------------: |
| c gcc            |      72       |      256kb used |
| go scanfile      |      100      |   +.98mb change |
| go readfile      |      135      |   +.98mb change |
| dotnet9          |      154      |       752 bytes |
| py multi-thread  |      160      |   +3.5mb change |
| julia            |      190      | 144mb allocated |
| go (4 threads)   |      200      |                 |
| rust             |      214      |  25mb allocated |
| python           |      550      |   +.25mb change |
| roc              |               |                 |

<br>

TODO

| Insert File to Postgres | Duration (ms) | Memory |
| :---------------------- | :-----------: | -----: |
| python                  |               |        |
