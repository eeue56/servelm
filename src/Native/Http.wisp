(defn- sanitize
  [record & spaces]
  (spaces.reduce (fn [r space] (do
    (if (aget r space) nil (set! (aget r space) {}))
    (aget r space)))
  record))

(defn- createServer
  [http Tuple2 Task]
  (fn [address] (let
    [send (:_0 address)
     server (.createServer http (fn [request response]
      (.perform Task (send (Tuple2 request response)))))]

    (.asyncFunction Task
      (fn [callback] (callback (.succeed Task server)))))))

(defn- listen
  [Task]
  (fn [port echo server]
    (.asyncFunction Task (fn [callback]
      (.listen server port (fn []
        (do (.log console echo) (callback (.succeed Task server)))))))))

(defn- writeHead
  [Task]
  (fn [code header res]
    (let [o {}]
      (.asyncFunction Task (fn [callback]
        (do (set! (aget o header._0) header._1)
            (.writeHead res code o)
            (callback (.succeed Task res))))))))

(defn- write
  [Task]
  (fn [message res]
    (.asyncFunction Task (fn [callback]
      (do (.write res message)
          (callback (.succeed Task res)))))))

(defn- end
  [Task Tuple0]
  (fn [res]
  (.asyncFunction Task (fn [callback]
    (do (.end res)
        (callback (.succeed Task Tuple0)))))))

(defn- make
  [localRuntime] (let
  [http (require "http")
   Task   (Elm.Native.Task.make  localRuntime)
   Utils  (Elm.Native.Utils.make localRuntime)
   Tuple0 (:Tuple0 Utils)
   Tuple2 (:Tuple2 Utils)
   noop   (fn [] nil)]

  (do (sanitize localRuntime :Native :Http)
    (let [v localRuntime.Native.Http.values]
      (if v v (set! localRuntime.Native.Http.values {

        :createServer (createServer http Tuple2 Task)
        :listen       (F3 (listen    Task))
        :writeHead    (F3 (writeHead Task))
        :write        (F2 (write     Task))
        :end          (end Task Tuple0)
        :url          (fn [res] (:url        res))
        :method       (fn [res] (:method     res))
        :statusCode   (fn [res] (:statusCode res))
        :emptyReq     {}
        :emptyRes     {
          :end          noop
          :write        noop
          :writeHead    noop}}))))))

(sanitize Elm :Native :Http)
(set! Elm.Native.Http.make make)

(if (== (typeof window) :undefined) (set! window global))
