# lang-compare

intel n100

| Read 126 mb file | Duration (ms) |          Memory |
| :--------------- | :-----------: | --------------: |
| python           |      550      |   +.25mb change |
| py multithread   |      160      |   +3.5mb change |
| go readfile      |      135      |   +.98mb change |
| go scanfile      |      100      |   +.98mb change |
| go multi         |     #todo     |           #todo |
| julia            |      190      | 144mb allocated |
| rust             |      214      |  25mb allocated |
| roc              |               |                 |
| c gcc            |      72       |      256kb used |

<br>
<br>

TODO

| Insert File to Postgres | Duration (ms) | Memory |
| :---------------------- | :-----------: | -----: |
| python                  |               |        |

<br>

```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```

<br>
```mermaid
flowchart TD
A[Christmas] -->|Get money| B(Go shopping)
B --> C{Let me think}
C -->|One| D[Laptop]
C -->|Two| E[iPhone]
C -->|Three| F[fa:fa-car Car]
```
