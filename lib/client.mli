type t

val build : ?user:string option -> ?password:string option ->
  host:string -> ?port:int -> ?path:string -> unit -> t

val post : client:t -> Yojson.Safe.json -> Yojson.Safe.json
