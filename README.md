# lang-compare

intel n100

| Read 126 mb file | Duration (ms) |          Memory |
| :--------------- | :-----------: | --------------: |
| c gcc            |      72       |      256kb used |
| go               |      100      |   +.98mb change |
| dotnet9          |      154      |       752 bytes |
| py multi-thread  |      160      |   +3.5mb change |
| julia            |      190      | 144mb allocated |
| go (4 threads)   |      200      |                 |
| rust             |      214      |  25mb allocated |
| python           |      550      |   +.25mb change |
| roc              |               |                 |

memory is questionably not apple-to-apples and i should dig into that further.

<br>

TODO

| Insert File to Postgres | Duration (ms) | Memory |
| :---------------------- | :-----------: | -----: |
| python                  |               |        |
