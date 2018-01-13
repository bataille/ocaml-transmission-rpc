(*{{{ Copyright (c) 2015, Benoit Bataille <benoit.bataille@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of ocaml-transmission-rpc nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}}}*)

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

let send_request ~client request =
  Cohttp_lwt_unix.Client.post 
    ~headers:client.header
    ~body:(`String (request |> Yojson.Safe.to_string)) 
    client.uri 
  >>= fun (resp, body) ->
    body |> Cohttp_lwt__Body.to_string

let post ~client request =
  send_request ~client request
  |> Lwt_main.run
  |> Yojson.Safe.from_string
