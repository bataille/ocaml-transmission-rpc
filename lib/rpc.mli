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
  
  val set : client:Client.t ->
    ?bandwidthPriority:int option ->
    ?downloadLimit:int option ->
    ?downloadLimited:bool option ->
    ?files_wanted:int list option ->
    ?files_unwanted:int list option ->
    ?honorsSessionLimits:bool option ->
    ?location:string option ->
    ?peer_limit:int option ->
    ?priority_high:int list option ->
    ?priority_low:int list option ->
    ?priority_normal:int list option ->
    ?queuePosition:int option ->
    ?seedIdleLimit:int option ->
    ?seedIdleMode:int option ->
    ?seedRatioLimit:float option ->
    ?seedRatioMode:int option ->
    ?trackerAdd:string list option ->
    ?trackerRemove:int list option ->
    ?trackerReplace:(int*string) list option ->
    ?uploadLimit:int option ->
    ?uploadLimited:bool option ->
    ids:Request.Torrent.ids -> (unit, string) result

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
  val set : client:Client.t ->
    ?alt_speed_down:int option ->
    ?alt_speed_enabled:bool option ->
    ?alt_speed_time_begin:int option ->
    ?alt_speed_time_enabled:bool option ->
    ?alt_speed_time_end:int option ->
    ?alt_speed_time_day:int option ->
    ?alt_speed_up:int option ->
    ?blocklist_url:string option ->
    ?blocklist_enabled:bool option ->
    ?cache_size_mb:int option ->
    ?download_dir:string option ->
    ?download_queue_size:int option ->
    ?download_queue_enabled:bool option ->
    ?dht_enabled:bool option ->
    ?encryption:string option ->
    ?idle_seeding_limit:int option ->
    ?idle_seeding_limit_enabled:bool option ->
    ?incomplete_dir:string option ->
    ?incomplete_dir_enabled:bool option ->
    ?lpd_enabled:bool option ->
    ?peer_limit_global:int option ->
    ?peer_limit_per_torrent:int option ->
    ?pex_enabled:bool option ->
    ?peer_port:int option ->
    ?peer_port_random_on_start:bool option ->
    ?port_forwarding_enabled:bool option ->
    ?queue_stalled_enabled:bool option ->
    ?queue_stalled_minutes:int option ->
    ?rename_partial_files:bool option ->
    ?script_torrent_done_filename:string option ->
    ?script_torrent_done_enabled:bool option ->
    ?seedRatioLimit:float option ->
    ?seedRatioLimited:bool option ->
    ?seed_queue_size:int option ->
    ?seed_queue_enabled:bool option ->
    ?speed_limit_down:int option ->
    ?speed_limit_down_enabled:bool option ->
    ?speed_limit_up:int option ->
    ?speed_limit_up_enabled:bool option ->
    ?start_added_torrents:bool option ->
    ?trash_original_torrent_files:bool option ->
    ?units:Request.Session.Set.units option ->
    ?utp_enabled:bool option ->
    unit -> (unit, string) result

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
