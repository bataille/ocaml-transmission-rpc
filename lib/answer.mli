open Rresult

module Torrent : sig
  module Get : sig
    type file = {
      bytesCompleted : int;
      length : int;
      name : string
    }

    type file_stats = {
      bytesCompleted : int;
      wanted : bool;
      priority : int
    }

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
    }

    type peers_from = {
      fromCache : int;
      fromDHT : int;
      fromIncoming : int;
      fromLpd : int;
      fromLtep : int;
      fromPex : int;
      fromTracker : int
    }

    type tracker = {
      announce : string;
      id : int;
      scrape : string;
      tier : int
    }

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
    }

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

    val show_field : field -> string

    val parse : Yojson.Safe.json -> (field list list, string) result 
  end

  module Add : sig
    type info = {
      id : int;
      name : string;
      hashString : string
    }

    type t = TorrentAdded of info | TorrentDuplicate of info

    val parse : Yojson.Safe.json -> (t, string) result
  end

  module RenamePath : sig
    type t = {
      path : string;
      name : string;
      id : int
    }
    val show : t -> string
    val parse : Yojson.Safe.json -> (t, string) result
  end
end

module Session : sig
  module Get : sig
    type units = {
      speed_units : string list;
      speed_bytes : int;
      size_units : string list;
      size_bytes : int;
      memory_units : string list;
      memory_bytes : int
    }

    type t = {
      alt_speed_down : int;
      alt_speed_enabled : bool;
      alt_speed_time_begin : int;
      alt_speed_time_enabled : bool;
      alt_speed_time_end : int;
      alt_speed_time_day : int;
      alt_speed_up : int;
      blocklist_url : string;
      blocklist_enabled : bool;
      blocklist_size : int;
      cache_size_mb : int;
      config_dir : string;
      download_dir : string;
      download_queue_size : int;
      download_queue_enabled : bool;
      dht_enabled : bool;
      encryption : string;
      idle_seeding_limit : int;
      idle_seeding_limit_enabled : bool;
      incomplete_dir : string;
      incomplete_dir_enabled : bool;
      lpd_enabled : bool;
      peer_limit_global : int;
      peer_limit_per_torrent : int;
      pex_enabled : bool;
      peer_port : int;
      peer_port_random_on_start : bool;
      port_forwarding_enabled : bool;
      queue_stalled_enabled : bool;
      queue_stalled_minutes : int;
      rename_partial_files : bool;
      rpc_version : int;
      rpc_version_minimum : int;
      script_torrent_done_filename : string;
      script_torrent_done_enabled : bool;
      seedRatioLimit : float;
      seedRatioLimited : bool;
      seed_queue_size : int;
      seed_queue_enabled : bool;
      speed_limit_down : int;
      speed_limit_down_enabled : bool;
      speed_limit_up : int;
      speed_limit_up_enabled : bool;
      start_added_torrents : bool;
      trash_original_torrent_files : bool;
      units : units ;
      utp_enabled : bool;
      version : string
    }
    val show : t -> string
    val parse : Yojson.Safe.json -> (t, string) result
  end
  
  module Stats : sig
    type cumulative_stats = {
      uploadedBytes : int;
      downloadedBytes : int;
      filesAdded : int;
      sessionCount : int;
      secondsActive : int
    }
    
    type current_stats = {
      uploadedBytes : int;
      downloadedBytes : int;
      filesAdded : int;
      sessionCount : int;
      secondsActive : int
    }

    type t = {
      activeTorrentCount : int;
      downloadSpeed : int;
      pausedTorrentCount : int;
      torrentCount : int;
      uploadSpeed : int;
      cumulative_stats : cumulative_stats;
      current_stats : current_stats
    }
    val show : t -> string
    val parse : Yojson.Safe.json -> (t, string) result
  end

  module BlocklistUpdate : sig
    val parse : Yojson.Safe.json -> (int, string) result
  end

  module PortChecking : sig
    val parse : Yojson.Safe.json -> (bool, string) result
  end
  
  module FreeSpace : sig
    type t = {
      path : string;
      size_bytes : int
    }
    val show : t -> string
    val parse : Yojson.Safe.json -> (t, string) result
  end
end
