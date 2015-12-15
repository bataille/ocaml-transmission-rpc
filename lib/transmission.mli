type 'a result = [ `Ok of 'a | `Error of string ]

module Torrent : sig
  val start : client:Client.t -> ids:Request.Torrent.ids -> unit result
  val start_now : client:Client.t -> ids:Request.Torrent.ids -> unit result
  val stop : client:Client.t -> ids:Request.Torrent.ids -> unit result
  
  val verify : client:Client.t -> ids:Request.Torrent.ids -> unit result
  val reannounce : client:Client.t -> ids:Request.Torrent.ids -> unit result  
  
  val get : 
    client : Client.t ->
    fields:Request.Torrent.Get.field_name list -> 
    ids:Request.Torrent.ids -> 
    Result.Torrent.Get.field list list result

  val remove : client:Client.t -> ?delete_local_data:bool ->
    ids:Request.Torrent.ids -> unit result
  
  val set_location :
    client : Client.t ->
    ?move:bool ->
    ids:Request.Torrent.ids ->
    location:string ->
    unit result

  val rename_path : client:Client.t -> id:int -> path:string -> 
    name:string -> Result.Torrent.RenamePath.t result
end

module Session : sig
  val get : client:Client.t -> Result.Session.Get.t result
  
  val stats : client:Client.t -> Result.Session.Stats.t result

  val port_test : client:Client.t -> bool result
  val blocklist_update : client:Client.t -> int result
  val close : client:Client.t -> unit result

  module Queue : sig
    val move_top : client:Client.t -> ids:Request.Torrent.ids -> unit result
    val move_up : client:Client.t -> ids:Request.Torrent.ids -> unit result
    val move_down : client:Client.t -> ids:Request.Torrent.ids -> unit result
    val move_bottom : client:Client.t -> ids:Request.Torrent.ids -> unit result
  end

  val free_space : client:Client.t -> path:string -> 
    Result.Session.FreeSpace.t result
end
