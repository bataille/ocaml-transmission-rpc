open Rresult

module Torrent : sig
  val start : client:Client.t -> ids:Request.Torrent.ids ->
    (unit, string) result
  
  val start_now : client:Client.t -> ids:Request.Torrent.ids -> 
    (unit, string) result
  
  val stop : client:Client.t -> ids:Request.Torrent.ids -> 
    (unit, string) result
  
  val verify : client:Client.t -> ids:Request.Torrent.ids -> 
    (unit, string) result
  
  val reannounce : client:Client.t -> ids:Request.Torrent.ids -> 
    (unit, string) result  
  
  val get : client:Client.t ->
    fields:Request.Torrent.Get.field_name list -> 
    ids:Request.Torrent.ids -> 
    (Answer.Torrent.Get.field list list, string) result

  val add : client:Client.t -> 
    ?cookies:string option ->
    ?download_dir:string option ->
    ?paused:bool option ->
    ?peer_limit:int option ->
    ?bandwithPriority:int option ->
    ?files_wanted:int list option ->
    ?files_unwanted:int list option ->
    ?priority_hight:int list option ->
    ?priority_low:int list option ->
    ?priority_normal:int list option ->
    Request.Torrent.Add.to_add -> (Answer.Torrent.Add.t, string) result

  val remove : client:Client.t -> 
    ?delete_local_data:bool ->
    ids:Request.Torrent.ids -> (unit, string) result
  
  val set_location : client:Client.t ->
    ?move:bool ->
    ids:Request.Torrent.ids ->
    location:string ->
    (unit, string) result

  val rename_path : client:Client.t -> 
    id:int -> 
    path:string -> 
    name:string -> (Answer.Torrent.RenamePath.t, string) result
end

module Session : sig
  val get : client:Client.t -> (Answer.Session.Get.t, string) result
  
  val stats : client:Client.t -> (Answer.Session.Stats.t, string) result

  val port_test : client:Client.t -> (bool, string) result
  val blocklist_update : client:Client.t -> (int, string) result
  val close : client:Client.t -> (unit, string) result

  module Queue : sig
    val move_top : client:Client.t -> ids:Request.Torrent.ids -> 
      (unit, string) result
    val move_up : client:Client.t -> ids:Request.Torrent.ids -> 
      (unit, string) result
    val move_down : client:Client.t -> ids:Request.Torrent.ids -> 
      (unit, string) result
    val move_bottom : client:Client.t -> ids:Request.Torrent.ids -> 
      (unit, string) result
  end

  val free_space : client:Client.t -> path:string -> 
    (Answer.Session.FreeSpace.t, string) result
end
