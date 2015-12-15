open Yojson
open Rresult

(* Send request and parse results *)
let no_arg_method method_name =
  let f ~client =
    `Assoc [("method", `String method_name)]
    |> Client.post ~client
  in f

let ids_method method_name =
  let f ~client ~ids =
    let open Request.Torrent in
    `Assoc [
      ("method", `String method_name);
      ("arguments", {ids=ids} |> arguments_to_yojson)
    ] |> Client.post ~client
  in f


let get_return_arguments returned =
  let f x = 
    (function ("arguments", json) -> Ok json
    |("result", `String "success") -> Ok x
    |("result", `String s) -> Error s
    |("tag", t) -> Ok x
    |_ -> Error "Invalid return")
  in returned
  |> (function `Assoc l -> 
        List.fold_left (fun acc elem -> acc >>= fun acc -> f acc elem) 
          (Ok `Null) l
      |_ -> Error "Invalid return")

let no_return returned =
  match get_return_arguments returned with
  | Ok `Null -> Ok ()
  | Ok _ -> assert false
  | Error e -> Error e

let no_arg_method_no_return method_name =
  let f ~client =
    no_return @@ (no_arg_method method_name) ~client
  in f

let ids_method_no_return method_name =
  let f ~client ~ids =
    no_return @@ (ids_method method_name) ~client ~ids
  in f

module Torrent = struct
  let start = ids_method_no_return "torrent-start"
  let start_now = ids_method_no_return "torrent-start-now"
  let stop = ids_method_no_return "torrent-stop"
  let verify = ids_method_no_return "torrent-verify"
  let reannounce = ids_method_no_return "torrent-reannounce"

  let get ~client ~fields ~ids =
    let open Request.Torrent.Get in
    `Assoc [
      ("method", `String "torrent-get");
      ("arguments", {fields=fields; ids=ids} |> arguments_to_yojson)] 
    |> Client.post ~client
    |> get_return_arguments
    >>= Answer.Torrent.Get.parse

  let remove ~client ?delete_local_data:(dlt=false) ~ids =
    let open Request.Torrent.Remove in
    `Assoc [
      ("method", `String "torrent-remove");
      ("arguments", 
        { ids=ids; 
          delete_local_data=dlt } |> arguments_to_yojson)
    ] 
    |> Client.post ~client
    |> no_return

  let set_location ~client ?move:(move=false) ~ids ~location =
    let open Request.Torrent.SetLocation in
    `Assoc [
      ("method", `String "torrent-set-location");
      ("arguments", 
        { location=location; 
          ids=ids; 
          move=move } |> arguments_to_yojson)
    ] 
    |> Client.post ~client
    |> no_return

  let rename_path ~client ~id ~path ~name = 
    let open Request.Torrent.RenamePath in
    `Assoc [
      ("method", `String "torrent-rename-path");
      ("arguments", 
        { ids=id; 
          path=path;
          name = name } |> arguments_to_yojson)
    ] 
    |> Client.post ~client
    |> get_return_arguments
    >>= Answer.Torrent.RenamePath.parse
end

module Session = struct
  let get ~client = 
    (no_arg_method "session-get") ~client
  |> get_return_arguments
  >>= Answer.Session.Get.parse
  
  let stats ~client = 
    (no_arg_method "session-stats") ~client
    |> get_return_arguments
    >>= Answer.Session.Stats.parse

  let port_test ~client = 
    (no_arg_method "port-test") ~client
      |> get_return_arguments
      >>= Answer.Session.PortChecking.parse

  let blocklist_update ~client = 
    (no_arg_method "blocklist-update") ~client
    |> get_return_arguments
    >>= Answer.Session.BlocklistUpdate.parse

  let close = no_arg_method_no_return "session-close"

  module Queue = struct
    let move_top = ids_method_no_return "queue-move-top" 
    let move_up = ids_method_no_return "queue-move-up" 
    let move_down = ids_method_no_return "queue-move-down" 
    let move_bottom = ids_method_no_return "queue-move-bottom" 
  end

  let free_space ~client ~path =
      `Assoc [
        ("method", `String "free-space");
        ("arguments", `Assoc [("path", `String path)])
      ] |> Client.post ~client
      |> get_return_arguments
      >>= Answer.Session.FreeSpace.parse
end
