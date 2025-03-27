//javac readfile.java
//java readfile
//rm readfile.class

//java readfile.java

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class readfile {
    public static void main(String[] args) {
        String filePath = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"; 
        

        long startTime = System.nanoTime(); 
        int line_count=0;

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line_count+=1;
            //    String[] values = line.split(",");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        long endTime = System.nanoTime(); // End time measurement

        long durationMs = (endTime - startTime) / 1_000_000; // Convert nanoseconds to milliseconds
        System.out.println("lines: " + line_count);
        System.out.println("Time taken: " + durationMs + " ms");
    }
}
