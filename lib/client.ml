open Lwt
open Cohttp

type t = {
  header: Cohttp.Header.t;
  uri: Uri.t
} 

let default_header () = 
  Header.init ()
  |> fun h -> Header.add h "content-type" "application/json"

let add_transmission_id id header =
    Header.add header "X-Transmission-Session-Id" id

let add_auth ~user ~password header =
  Header.add_authorization header (`Basic (user,password))

let build ?user:(user=None) ?password:(password=None) 
    ~host ?port:(port=9091) ?path:(path="/transmission/rpc") () =
  let header =
    default_header ()
    |> fun h -> begin match (user,password) with
      |(Some u, Some p) -> add_auth ~user:u ~password:p h
      |(None, None) -> h
      |_ -> failwith "You must provide a user and a password."
      end
  in
  let uri = Uri.of_string @@ host ^ ":" ^ string_of_int port ^ path in
  (Cohttp_lwt_unix.Client.post ~headers:header uri >>= fun (resp,_) -> begin
    match (resp |> Response.status |> Code.code_of_status) with
    |409 ->  return {
        header = (resp |> Response.headers
          |> fun head -> Header.get head "X-Transmission-Session-Id" 
          |> (function Some id -> add_transmission_id id header 
              |_ -> assert false));
        uri = uri
      }
    |_ -> failwith "Failed to get a session id."
  end) |> Lwt_main.run

let send_request client request =
  print_endline @@ Yojson.Safe.to_string request;
  Cohttp_lwt_unix.Client.post 
    ~headers:client.header
    ~body:(`String (request |> Yojson.Safe.to_string)) 
    client.uri 
  >>= fun (resp, body) ->
    let code = resp |> Response.status |> Code.code_of_status in
    Printf.printf "Response code: %d\n" code;
    Printf.printf "Headers: %s\n" 
      (resp |> Response.headers |> Header.to_string);
    body |> Cohttp_lwt_body.to_string >|= fun body ->
      Printf.printf "Body of length: %d\n" (String.length body);
    body

let post client request =
  send_request client request
  |> Lwt_main.run
