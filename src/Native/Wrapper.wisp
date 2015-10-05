(defn- sanitize [record & spaces]
  (spaces.reduce (fn [r space] (do
    (if (aget r space) nil (set! (aget r space) {}))
    (aget r space)))
  record))

(defn- make [localRuntime] (let
  [http (require "http")]
  (do (sanitize localRuntime :Native :Http)
      (set! localRuntime.Native.Http.values {
        :createServer createServer}))))

(sanitize Elm :Native :Http)
(set! Elm.Native.Http.make make)
