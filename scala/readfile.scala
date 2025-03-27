import java.io._
import System.nanoTime
import scala.collection.mutable.ArrayBuffer

object readfile {
  def main(args: Array[String]): Unit = {
    val filePath = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv";

    // Start measuring time
    val startTime = nanoTime()

    // Open the file
    val file = new File(filePath)
    val fileInputStream = new FileInputStream(file)
    val bufferedReader = new BufferedReader(new InputStreamReader(fileInputStream))

    var lineCount = 0
    val chunkSize = 1024  // Reading in 1024-byte chunks
    var buffer = new Array[Char](chunkSize)
    var currentLine = new StringBuilder()

    try {
      var bytesRead = bufferedReader.read(buffer)
      while (bytesRead != -1) {
        var i = 0
        while (i < bytesRead) {
          val char = buffer(i)
          if (char == '\n') {  // End of line
            lineCount += 1
            // Parse the line by comma
            //val values = currentLine.toString().split(",").map(_.trim)
            //println(s"Line $lineCount: ${values.mkString(" | ")}")
            currentLine.clear() // Clear the current line for next one
          } else {
            currentLine.append(char)
          }
          i += 1
        }
        bytesRead = bufferedReader.read(buffer) // Read the next chunk
      }
    } catch {
      case e: IOException => e.printStackTrace()
    } finally {
      bufferedReader.close()
    }

    // End time measurement
    val endTime = nanoTime()

    // Calculate duration in milliseconds
    val durationMs = (endTime - startTime) / 1000000

    // Output results
    println(s"Total lines read: $lineCount")
    println(s"Time taken: $durationMs ms")
  }
}
