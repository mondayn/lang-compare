(ns build
  (:require [clojure.tools.build.api :as b]))

(def main 'readfile)
(def uber-file "readfile.jar")

(defn- uber-opts [opts]
  (assoc opts
         :main main
         :uber-file uber-file
         :basis (b/create-basis {})
         :class-dir "classes"
         :src-dirs ["src"]
         :ns-compile [main]))

(defn uber [opts]
  (b/delete {:path uber-file})
  (let [opts (uber-opts opts)]
      (b/compile-clj opts)
      (b/uber opts))
  opts
  )