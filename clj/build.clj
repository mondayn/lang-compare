(ns build
;;  (:refer-clojure :exclude [test])
  (:require [clojure.tools.build.api :as b]))

(def main 'readfile)

(defn- uber-opts [opts]
  (assoc opts
         :main main
         :uber-file "readfile.jar"
         :basis (b/create-basis {})
         :class-dir "classes"
         :src-dirs ["src"]
         :ns-compile [main]))

(defn uber [opts]
  (b/delete {:path "target"})
  (let [opts (uber-opts opts)]
      (b/compile-clj opts)
      (b/uber opts))
  opts)