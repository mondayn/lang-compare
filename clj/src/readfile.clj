
(ns readfile
  (:require [clojure.java.io :as io]
            [clojure.string :as str])
 (:gen-class)
 )

(defn measure-duration [f]
  (let [start-time (System/currentTimeMillis)]
    (println "lines = " (f))  
    (let [end-time (System/currentTimeMillis)]
      (- end-time start-time)))) 

(def file "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv")

(defn readfile[]
  (with-open [reader (io/reader file)]
    (let [lines (line-seq reader)
          line-count (count lines)]
      line-count)
   )
)

(defn read-and-count[]
  (with-open [reader (io/reader file)]
    (let [lines (line-seq reader)
          line-count (count lines)]
      (doseq [line lines]
        (let [tokens (str/split line #",")]
        ;;   (println tokens)
          )
        )  
      line-count)
   )
)

(defn -main []
  (println "Read (ms):" (measure-duration readfile))
  (println "Read and count(ms):" (measure-duration read-and-count))
 )

        