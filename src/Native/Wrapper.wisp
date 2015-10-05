(defn- sanitize [record & spaces]
  (spaces.reduce (fn [r space] (do
    (if (aget r space) nil (set! (aget r space) {}))
    (aget r space)))
  record))

(defn- createServer
      [http Tuple2 Task]
  (fn [address] (let
    [send (:_0 address)
     server (.createServer http (fn [request response]
      (do (send (Tuple2 request response))
          (.log console "create"))))]

    (.asyncFunction Task
      (fn [callback] (callback (.succeed Task server)))))))

(defn- listen
  [Task]
  (fn [port echo server]
    (.asyncFunction Task (fn [callback]
      (.listen server port (fn []
        (do (.log console echo) (callback server))))))))

(defn- make [localRuntime] (let
  [http (require "http")
   Signal          (Elm.Native.Signal.make localRuntime)
   Tuple2 (:Tuple2 (Elm.Native.Utils.make  localRuntime))
   Task            (Elm.Native.Task.make   localRuntime)
   createServer*   (createServer http Tuple2 Task)
   listen*         (F3 (listen Task))]

  (do (sanitize localRuntime :Native :Http)
    (let [v localRuntime.Native.Http.values]
      (if v v (set! localRuntime.Native.Http.values {
        :createServer createServer*
        :listen listen*}))))))

(sanitize Elm :Native :Http)
(set! Elm.Native.Http.make make)
