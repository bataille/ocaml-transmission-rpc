# Transmission-rpc

An OCaml client library for the Transmission Bittorrent client RPC.
The implemented spec definition is in the doc folder. 
See [here](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt)
for the last version.

This library supports all the methods of the Transmission RPC interface while 
remaining voluntarily close to the interface specification. To each specified
method corresponds a function. These functions take advantage of some OCaml 
niceties: labelled arguments, optional arguments for optional parameters and 
variant types where it makes sense. They return properly typed structure.

## Installation

To be compiled, this library requires:
- *cohttp*
- *lwt*
- *yojson*
- *ppx_deriving_yojson*
- *rresult*

All these libraries can be installed through [opam](https://opam.ocaml.org/):
```
opam install cohttp lwt yojson ppx_deriving_yojson rresult
```

The project is setup using [oasis](http://oasis.forge.ocamlcore.org/) which
generates a usabe Makefile. 

To compile, run :
```
make
```

To install:
```
make install
```

## Usage

All the modules in this library are packed under the *Transmission* top module.
The following examples are written implying that this toplevel module is open:
```Ocaml
open Transmission
```

### Connection

First create a client using *Client.build* :
```Ocaml
let client =
  Client.build ~host:"http://127.0.0.1" ()
```

If needed, you can use basic authentification and setup different port using
the optional argument of *Client.build* :
```Ocaml
let client =
  Client.build ~host:"http://127.0.0.1" ~port:80 
    ~user:(Some "user") ~password:(Some "password") ()
```

The library takes care of setting the required headers properly.

### Request

To each method of the Transmission rpc interface corresponds a function in the
*Rpc* module. If needed, the types of arguments are defined in the *Request*
module. These functions return structure defined in the *Answer* module.

For example, you can get the name, status and upload ratio of every torrents 
currently processed using:
```Ocaml
Rpc.Torrent.get ~client 
  ~ids:`All 
  ~fields:[`Name; `Status; `UploadRatio]
```

The estimated remaining time of the recently active torrents:
```Ocaml
Rpc.Torrent.get ~client
  ~ids:`RecentlyActive
  ~fields:[`Eta]
```

To delete the torrents 3 and 5 including their data, you would use:
```Ocaml
Rpc.Torrent.remove ~client 
  ~delete_local_data:true
  ~ids:(`TorrentList [3;5])
```

To get statistics on the current session:
```Ocaml
Rpc.Session.stats ~client
```

## Todo

* Write proper testing
