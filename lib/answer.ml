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
[@@@warning "-32-39"] (* disable warnings triggered by deriving_yojson *)

open Ppx_deriving_yojson_runtime 
open Result

(* Parsing json returned by the rpc interface of Transmission *)
module Torrent = struct
  module Get = struct
    type file = {
      bytesCompleted : int;
      length : int;
      name : string
    } [@@deriving show, of_yojson]

    type file_stats = {
      bytesCompleted : int;
      wanted : bool;
      priority : int
    } [@@deriving show, of_yojson]

    type peer = {
      address : string;
      clientName : string;
      clientIsChocked : bool;
      clientIsInterested : bool;
      flagStr : string;
      isDownloadingFrom : bool;
      isEncrypted : bool;
      isIncoming : bool;
      isUploadingTo : bool;
      isUTP : bool;
      peerIsChoked : bool;
      peerIsInterested : bool;
      port : int;
      progress : float;
      rateToClient : int;
      rateToPeer : int
    } [@@deriving show, yojson]

    type peers_from = {
      fromCache : int;
      fromDHT : int;
      fromIncoming : int;
      fromLpd : int;
      fromLtep : int;
      fromPex : int;
      fromTracker : int
    } [@@deriving show, of_yojson]

    type tracker = {
      announce : string;
      id : int;
      scrape : string;
      tier : int
    } [@@deriving show, of_yojson]

    type tracker_stat = {
      announce : string;
      announceState : int;
      downloadCount : int;
      hasAnnounced : bool;
      hasScraped : bool;
      host : string;
      id : int;
      isBackup : bool;
      lastAnnouncePeerCount : int;
      lastAnnounceResult : string;
      lastAnnounceStartTime : int;
      lastAnnounceSucceeded : bool;
      lastAnnounceTime : int;
      lastAnnounceTimedOut : bool;
      lastScrapeResult : string;
      lastScrapeStartTime : int;
      lastScrapeSucceeded : bool;
      lastScrapeTime : int;
      lastScrapeTimedOut : bool;
      leecherCount : int;
      nextAnnounceTime : int;
      nextScrapeTime : int;
      scrape : string;
      scrapeState : int;
      seederCount : int;
      tier : int 
    } [@@deriving show, of_yojson]

    type field =
      ActivityDate of int
    | AddedDate of int
    | BandwithPriority of int
    | Comment of string
    | CorruptEver of int
    | Creator of string
    | DateCreated of int
    | DesiredAvailable of int
    | DoneDate of int
    | DownloadDir of string
    | DownloadedEver of int
    | DownloadLimit of int
    | DownloadLimited of bool
    | Error of int
    | ErrorString of string
    | Eta of int
    | EtaIdle of int
    | Files of file list
    | FileStats of file_stats
    | HashString of string
    | HaveUnchecked of int
    | HaveValid of int
    | HonorsSessionLimits of bool
    | Id of int
    | IsFinished of bool
    | IsPrivate of bool
    | IsStalled of bool
    | LeftUntilDone of int
    | MagnetLink of string
    | ManualAnnounceTime of int
    | MaxConnectedPeers of int
    | MetadataPercentComplete of float
    | Name of string
    | PeerLimit of int
    | Peers of peer list
    | PeersConnected of int
    | PeersFrom of peers_from
    | PeersGettingFromUs of int
    | PeersSendingToUs of int
    | PercentDone of float
    | Pieces of string
    | PieceCount of int
    | PieceSize of int
    | Priorities of int list
    | QueuePosition of int
    | RateDownload of int
    | RateUpload of int
    | RecheckProgress of float
    | SecondsDownloading of int
    | SecondsSeeding of int
    | SeedIdleLimit of int
    | SeedIdleMode of int
    | SeedRatioLimit of float
    | SeedRatioMode of int
    | SizeWhenDone of int
    | StartDate of int
    | Status of int
    | Trackers of tracker list
    | TrackerStats of tracker_stat list
    | TotalSize of int
    | TorrentFile of string
    | UploadedEver of int
    | UploadLimit of int
    | UploadLimited of bool
    | UploadRatio of float
    | Wanted of bool list
    | Webseeds of string list
    | WebseedsSendingToUs of int
    [@@deriving show]

    let tuple_to_field =  function
      ("activityDate", `Int i) -> Ok (ActivityDate i)
    | ("addedDate", `Int i) -> Ok (AddedDate i)
    | ("bandwithPriority", `Int i) -> Ok (BandwithPriority i)
    | ("comment", `String s) -> Ok (Comment s)
    | ("corruptEver", `Int i) -> Ok (CorruptEver i)
    | ("creator", `String s) -> Ok (Creator s)
    | ("dateCreated", `Int i) -> Ok (DateCreated i)
    | ("desiredAvailable", `Int i) -> Ok (DesiredAvailable i)
    | ("doneDate", `Int i) -> Ok (DoneDate i)
    | ("downloadDir", `String s) -> Ok (DownloadDir s)
    | ("downloadedEver", `Int i) -> Ok (DownloadedEver i)
    | ("downloadLimit", `Int i) -> Ok (DownloadLimit i)
    | ("downloadLimited", `Bool b) -> Ok (DownloadLimited b)
    | ("error", `Int i) -> Ok (Error i)
    | ("errorString", `String s) -> Ok (ErrorString s)
    | ("eta", `Int i) -> Ok (Eta i)
    | ("etaIdle", `Int i) -> Ok (EtaIdle i)
    | ("files", `List files) -> 
        map_bind file_of_yojson [] files >>= fun files -> Ok (Files files)
    | ("fileStats", json) -> 
        file_stats_of_yojson json >>= fun fileStats -> Ok (FileStats fileStats)
    | ("hashString", `String s) -> Ok (HashString s)
    | ("haveUnchecked", `Int i) -> Ok (HaveUnchecked i)
    | ("haveValid", `Int i) -> Ok (HaveValid i)
    | ("honorsSessionLimits", `Bool b) -> Ok (HonorsSessionLimits b)
    | ("id", `Int i) -> Ok (Id i)
    | ("isFinished", `Bool b) -> Ok (IsFinished b)
    | ("isPrivate", `Bool b) -> Ok (IsPrivate b)
    | ("isStalled", `Bool b) -> Ok (IsStalled b)
    | ("leftUntilDone", `Int i) -> Ok (LeftUntilDone i)
    | ("magnetLink", `String s) -> Ok (MagnetLink s)
    | ("manualAnnounceTime", `Int i) -> Ok (ManualAnnounceTime i)
    | ("maxConnectedPeers", `Int i) -> Ok (MaxConnectedPeers i)
    | ("metadataPercentComplete", `Float f) -> Ok (MetadataPercentComplete f)
    | ("name",`String s) -> Ok (Name s)
    | ("peer-limit", `Int i) -> Ok (PeerLimit i)
    | ("peers", `List peers) -> 
        map_bind peer_of_yojson [] peers >>= fun peers -> Ok (Peers peers)
    | ("peersConnected", `Int i) -> Ok (PeersConnected i)
    | ("peersFrom", json) -> 
        peers_from_of_yojson json >>= fun peersFrom -> Ok (PeersFrom peersFrom)
    | ("peersGettingFromUs", `Int i) -> Ok (PeersGettingFromUs i)
    | ("peersSendingToUs", `Int i) -> Ok (PeersSendingToUs i)
    | ("percentDone", `Float f) -> Ok (PercentDone f)
    | ("pieces", `String s) -> Ok (Pieces s)
    | ("pieceCount", `Int i) -> Ok (PieceCount i)
    | ("pieceSize", `Int i) -> Ok (PieceSize i)
    | ("priorities", `List l) -> 
        map_bind (function `Int i -> Ok i |_ -> Error "Invalid priority") [] l
        >>= fun p -> Ok (Priorities p)
    | ("queuePosition", `Int i) -> Ok (QueuePosition i)
    | ("rateDownload", `Int i) -> Ok (RateDownload i)
    | ("rateUpload", `Int i) -> Ok (RateUpload i)
    | ("recheckProgress", `Float f) -> Ok (RecheckProgress f)
    | ("secondsDownloading", `Int i) -> Ok (SecondsDownloading i)
    | ("secondsSeeding", `Int i) -> Ok (SecondsSeeding i)
    | ("seedIdleLimit", `Int i) -> Ok (SeedIdleLimit i)
    | ("seedIdleMode", `Int i) -> Ok (SeedIdleMode i)
    | ("seedRatioLimit", `Float f) -> Ok (SeedRatioLimit f)
    | ("seedRatioMode", `Int i) -> Ok (SeedRatioMode i)
    | ("sizeWhenDone", `Int i) -> Ok (SizeWhenDone i)
    | ("startDate", `Int i) -> Ok (StartDate i)
    | ("status", `Int i) -> Ok (Status i)
    | ("trackers", `List trackers) ->
        map_bind tracker_of_yojson [] trackers >>= fun l -> Ok (Trackers l)
    | ("trackerStats", `List stats) ->
        map_bind tracker_stat_of_yojson [] stats 
        >>= fun ts -> Ok (TrackerStats ts)
    | ("totalSize", `Int i) -> Ok (TotalSize i)
    | ("torrentFile", `String s) -> Ok (TorrentFile s)
    | ("uploadedEver", `Int i) -> Ok (UploadedEver i)
    | ("uploadLimit", `Int i) -> Ok (UploadLimit i)
    | ("uploadLimited", `Bool b) -> Ok (UploadLimited b)
    | ("uploadRatio", `Float f) -> Ok (UploadRatio f)
    | ("wanted", `List l) -> 
        map_bind 
          (function `Bool b -> Ok b |_ -> Error "Invalid wanted field") [] l
        >>= fun l -> Ok (Wanted l)
    | ("webseeds", `List l) -> 
        map_bind
         (function `String s -> Ok s |_ -> Error "Invalid webseed") [] l
        >>= fun l -> Ok (Webseeds l)
    | ("webseedsSendingToUs", `Int i) -> Ok (WebseedsSendingToUs i)
    | (s,_) -> Error ("Unsupported field: " ^ s)

    type torrent = field list
    let torrent_of_yojson = 
      function `Assoc l -> map_bind tuple_to_field [] l
      |_ -> Error "Invalid torrent field" 
    
    type t = {
      torrents: torrent list
    } [@@deriving of_yojson]

    let parse json =
      of_yojson json >>= fun t -> Ok t.torrents
  end

  module Add = struct
    type info = {
      id : int;
      name : string;
      hashString : string
    } [@@deriving of_yojson]

    type t = TorrentAdded of info | TorrentDuplicate of info

    type return = {
      torrent_added : (info option [@default None])[@key "torrent-added"];
      torrent_duplicate : (info option [@default None])
        [@key "torrent-duplicate"]
    } [@@deriving of_yojson]

    let parse json =
      let get_option = function Some t -> t |_ -> assert false in
      return_of_yojson json
      >>= fun t -> 
        if t.torrent_added = None then 
          Ok (TorrentDuplicate (get_option t.torrent_duplicate))
        else
          Ok (TorrentAdded (get_option t.torrent_added))
  end
  
  module RenamePath = struct
    type t = {
      path : string;
      name : string;
      id : int
    } [@@deriving show, of_yojson]

    let parse json = of_yojson json
  end
end

module Session = struct
  module Get = struct
    type units = {
      speed_units : string list [@key "speed-units"];
      speed_bytes : int [@key "speed-bytes"];
      size_units : string list [@key "size-units"];
      size_bytes : int [@key "size-bytes"];
      memory_units : string list [@key "memory-units"];
      memory_bytes : int [@key "memory-bytes"]
    } [@@deriving show, yojson]

    type t = {
      alt_speed_down : int [@key "alt-speed-down"];
      alt_speed_enabled : bool [@key "alt-speed-enabled"];
      alt_speed_time_begin : int [@key "alt-speed-time-begin"];
      alt_speed_time_enabled : bool [@key "alt-speed-time-enabled"];
      alt_speed_time_end : int [@key "alt-speed-time-end"];
      alt_speed_time_day : int [@key "alt-speed-time-day"];
      alt_speed_up : int [@key "alt-speed-up"];
      blocklist_url : string [@key "blocklist-url"];
      blocklist_enabled : bool [@key "blocklist-enabled"];
      blocklist_size : int [@key "blocklist-size"];
      cache_size_mb : int [@key "cache-size-mb"];
      config_dir : string [@key "config-dir"];
      download_dir : string [@key "download-dir"];
      download_queue_size : int [@key "download-queue-size"];
      download_queue_enabled : bool [@key "download-queue-enabled"];
      dht_enabled : bool [@key "dht-enabled"];
      encryption : string;
      idle_seeding_limit : int [@key "idle-seeding-limit"];
      idle_seeding_limit_enabled : bool [@key "idle-seeding-limit-enabled"];
      incomplete_dir : string [@key "incomplete-dir"];
      incomplete_dir_enabled : bool [@key "incomplete-dir-enabled"];
      lpd_enabled : bool [@key "lpd-enabled"];
      peer_limit_global : int [@key "peer-limit-global"];
      peer_limit_per_torrent : int [@key "peer-limit-per-torrent"];
      pex_enabled : bool [@key "pex-enabled"];
      peer_port : int [@key "peer-port"];
      peer_port_random_on_start : bool [@key "peer-port-random-on-start"];
      port_forwarding_enabled : bool [@key "port-forwarding-enabled"];
      queue_stalled_enabled : bool [@key "queue-stalled-enabled"];
      queue_stalled_minutes : int [@key "queue-stalled-minutes"];
      rename_partial_files : bool [@key "rename-partial-files"];
      rpc_version : int [@key "rpc-version"];
      rpc_version_minimum : int [@key "rpc-version-minimum"];
      script_torrent_done_filename : string
        [@key "script-torrent-done-filename"];
      script_torrent_done_enabled : bool [@key "script-torrent-done-enabled"];
      seedRatioLimit : float;
      seedRatioLimited : bool;
      seed_queue_size : int [@key "seed-queue-size"];
      seed_queue_enabled : bool [@key "seed-queue-enabled"];
      speed_limit_down : int [@key "speed-limit-down"];
      speed_limit_down_enabled : bool [@key "speed-limit-down-enabled"];
      speed_limit_up : int [@key "speed-limit-up"];
      speed_limit_up_enabled : bool [@key "speed-limit-up-enabled"];
      start_added_torrents : bool [@key "start-added-torrents"];
      trash_original_torrent_files : bool
        [@key "trash-original-torrent-files"];
      units : units ;
      utp_enabled : bool [@key "utp-enabled"];
      version : string
    } [@@deriving show, of_yojson {strict = false}]

    let parse json = of_yojson json
  end
  
  module Stats = struct
    type cumulative_stats = {
      uploadedBytes : int;
      downloadedBytes : int;
      filesAdded : int;
      sessionCount : int;
      secondsActive : int
    } [@@deriving show, of_yojson]
    
    type current_stats = {
      uploadedBytes : int;
      downloadedBytes : int;
      filesAdded : int;
      sessionCount : int;
      secondsActive : int
    } [@@deriving show, of_yojson]

    type t = {
      activeTorrentCount : int;
      downloadSpeed : int;
      pausedTorrentCount : int;
      torrentCount : int;
      uploadSpeed : int;
      cumulative_stats : cumulative_stats [@key "cumulative-stats"];
      current_stats : current_stats [@key "current-stats"]
    } [@@deriving show, of_yojson]

    let parse json = of_yojson json
  end
  
  module BlocklistUpdate = struct
    type t = {
      blocklist_size : int [@key "blocklist-size"]
    } [@@deriving of_yojson]

    let parse json = 
      of_yojson json >>= fun t -> Ok t.blocklist_size
  end

  module PortChecking = struct
    type t = {
      port_is_open : bool [@key "port-is-open"]
    } [@@deriving of_yojson]

    let parse json =
      of_yojson json >>= fun t -> Ok t.port_is_open
  end
  
  module FreeSpace = struct
    type t = {
      path : string;
      size_bytes : int [@key "size-bytes"]
    } [@@deriving show, of_yojson]

    let parse json = of_yojson json 
  end
end
