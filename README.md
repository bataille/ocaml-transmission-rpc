# Transmission-rpc

A work-in-progress Transmission rpc client library for Ocaml.

It aims to support all the methods of the Transmission rpc interface and remains voluntarily close to the interface specification. 
Each call is a function using labelled arguments, optional arguments for optional fields and returns a properly typed structure.

## Installation

To be compiled, *Transmission-rpc* requires:
- cohttp
- lwt
- yojson
- ppx_deriving_yojson

All these libraries can be installed through [opam](https://opam.ocaml.org/):
  opam install cohttp lwt yojson ppx_deriving_yojson

The project is setup using [oasis](http://oasis.forge.ocamlcore.org/) which
generates a usabe Makefile. 
To compile, run :
  make

To install:
  make install

## Usage

### Connection

First create a client using *Client.build* :
  let client =
    Client.build ~host:"http://127.0.0.1" ()

If needed, you can use basic authentification and setup different port using
the optional argument of *Client.build* :
  let client =
    Client.build ~host:"http://127.0.0.1" ~port:80 
      ~user:(Some "user") ~password:(Some "password") ()

The library takes care of setting the required headers properly.

### Request

To each method of the Transmission rpc interface corresponds a function in the
*Transmission* module. If needed, the types of arguments are defined in the *Request*
module. These functions return structure defined in the *Result* module.

For example, you can get the name, status and upload ratio of every torrents currently processed using:
  Transmission.Torrent.get ~client 
    ~ids:`All 
    ~fields:[`Name; `Status; `UploadRatio]

The estimated remaining time of the recently active torrents:
  Transmission.Torrent.get ~client
    ~ids:`RecentlyActive
    ~fields:[`Eta]

To delete the torrents 3 and 5 including their data, you would use:
  Transmission.Torrent.remove ~client 
    ~delete_local_data:true
    ~ids:(`TorrentList [3;5])

To get statistics on the current session:
  Transmission.Session.stats ~client

## Support

| -------------------- | ----------- |
| Command              | Supported   |
| -------------------- | ----------- |
| torrent-start        | ✓           |
| torrent-start-now    | ✓           |
| torrent-stop         | ✓           |
| torrent-verify       | ✓           |
| torrent-set          |             |
| torrent-get          | ✓           |
| torrent-add          |             |
| torrent-remove       | ✓           |
| torrent-set-location | ✓           |
| torrent-rename-path  | ✓           |
| -------------------- | ----------- |
| session-set          |             |
| session-get          | ✓           |
| session-stats        | ✓           |
| session-close        | ✓           |
| -------------------- | ----------- |
| blocklist-update     | ✓           |
| port-test            | ✓           |
| -------------------- | ----------- |
| queue-move-top       | ✓           |
| queue-move-up        | ✓           |
| queue-move-down      | ✓           |
| queue-move-bottom    | ✓           |
| -------------------- | ----------- |
| free-space           | ✓           |

## Todo

* Write code to support the remaining methods:
** torrent-set
** torrent-add
** session-set
* Write mli for request and result
* Write proper testing
