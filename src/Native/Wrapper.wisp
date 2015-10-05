(defn- sanitize [record & spaces]
  (spaces.reduce (fn [r space] (do
    (if (aget r space) nil (set! (aget r space) {}))
    (aget r space)))
  record))

(defn- handler [sendMessage address Tuple2]
  (fn [request response]
    (sendMessage address (Tuple2 request response))))

(defn- createServer
      [http localRuntime sendMessage Tuple2]
  (fn [address port message]
      (.listen (.createServer http (handler address))
               port
               (fn [] (.log console message)))))

(defn- make [localRuntime] (let
  [http (require "http")
   Signal (Elm.Native.Signal.make localRuntime)
   Tuple2 (:Tuple2 (Elm.Native.Utils.make localRuntime))]
  (do (sanitize localRuntime :Native :Http)
      (if localRuntime.Native.Http.values
          localRuntime.Native.Http.values
          (set! localRuntime.Native.Http.values {
            :createServer createServer})))))

(sanitize Elm :Native :Http)
(set! Elm.Native.Http.make make)
