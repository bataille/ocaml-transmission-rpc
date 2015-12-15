let client =
  Client.build ~user:(Some "user") ~password:(Some "password")
    ~host:"http://127.0.0.1" ()

let () =
  Transmission.Torrent.get ~client 
    ~fields:[`Id; `Name; `Status; `UploadLimit; `Files; `Status] 
    ~ids:`All
  |> (function `Ok l -> begin
        l
        |> List.map (List.map Result.Torrent.Get.show_field)
        |> List.map (fun s -> "(" ^ String.concat "," s ^ ")")
        |> String.concat "\n"
    end | `Error e -> e)
  |> print_endline
