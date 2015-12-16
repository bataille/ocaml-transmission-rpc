module Torrent : sig
  type ids = 
    [ `All | `Torrent of int | `TorrentList of int list | `RecentlyActive ]

  type arguments = { ids : ids }
  val arguments_to_yojson : arguments -> Yojson.Safe.json

  module Set : sig
    type arguments = {
      bandwidthPriority : int option;
      downloadLimit : int option;
      downloadLimited : bool option;
      files_wanted : int list option;
      files_unwanted : int list option;
      honorsSessionLimits : bool option;
      ids : ids;
      location : string option;
      peer_limit : int option;
      priority_high : int list option;
      priority_low : int list option;
      priority_normal : int list option;
      queuePosition : int option;
      seedIdleLimit : int option;
      seedIdleMode : int option;
      seedRatioLimit : float option;
      seedRatioMode : int option;
      trackerAdd : string list option;
      trackerRemove : int list option;
      trackerReplace : (int*string) list option;
      uploadLimit : int option;
      uploadLimited : bool option
    }
    val arguments_to_yojson : arguments -> Yojson.Safe.json
  end

  module Get : sig
    type field_name = [
      `ActivityDate
    | `AddedDate
    | `BandwithPriority
    | `Comment
    | `CorruptEver
    | `Creator
    | `DateCreated
    | `DesiredAvailable
    | `DoneDate
    | `DownloadDir
    | `DownloadedEver
    | `DownloadLimit
    | `DownloadLimited
    | `Error
    | `ErrorString
    | `Eta
    | `EtaIdle
    | `Files
    | `FileStats
    | `HashString
    | `HaveUnchecked
    | `HaveValid
    | `HonorsSessionLimits
    | `Id
    | `IsFinished
    | `IsPrivate
    | `IsStalled
    | `LeftUntilDone
    | `MagnetLink
    | `ManualAnnounceTime
    | `MaxConnectedPeers
    | `MetadataPercentComplete
    | `Name
    | `PeerLimit
    | `Peers
    | `PeersConnected
    | `PeersFrom
    | `PeersGettingFromUs
    | `PeersSendingToUs
    | `PercentDone
    | `Pieces
    | `PieceCount
    | `PieceSize
    | `Priorities
    | `QueuePosition
    | `RateDownload
    | `RateUpload
    | `RecheckProgress
    | `SecondsDownloading
    | `SecondsSeeding
    | `SeedIdleLimit
    | `SeedIdleMode
    | `SeedRatioLimit
    | `SeedRatioMode
    | `SizeWhenDone
    | `StartDate
    | `Status
    | `Trackers
    | `TrackerStats
    | `TotalSize
    | `TorrentFile
    | `UploadedEver
    | `UploadLimit
    | `UploadLimited
    | `UploadRatio
    | `Wanted
    | `Webseeds
    | `WebseedsSendingToUs ]

    type arguments = {
      fields : field_name list;
      ids : ids
    } 
    val arguments_to_yojson : arguments -> Yojson.Safe.json
  end

  module Add : sig
    type to_add = [ `Filename of string | `Metainfo of string ]

    type arguments = {
      cookies : string option;
      download_dir : string option;
      filename : string option;
      metainfo : string option;
      paused : bool option;
      peer_limit : int option;
      bandwithPriority : int option;
      files_wanted : int list option;
      files_unwanted : int list option;
      priority_hight : int list option;
      priority_low : int list option;
      priority_normal : int list option
    }

    val arguments_to_yojson : arguments -> Yojson.Safe.json
  end

  module Remove : sig
    type arguments = {
      ids : ids;
      delete_local_data : bool
    }
    val arguments_to_yojson : arguments -> Yojson.Safe.json 
  end

  module SetLocation : sig
    type arguments = {
      ids : ids;
      location : string;
      move : bool
    }
    val arguments_to_yojson : arguments -> Yojson.Safe.json
  end

  module RenamePath : sig
    type arguments = {
      ids : int;
      path : string;
      name : string
    }
    val arguments_to_yojson : arguments -> Yojson.Safe.json
  end
end

module Session : sig
  module Set : sig
    type units = {
      speed_units : string list;
      speed_bytes : int;
      size_units : string list;
      size_bytes : int;
      memory_units : string list;
      memory_bytes : int
    }

    type arguments = {
      alt_speed_down : int option;
      alt_speed_enabled : bool option;
      alt_speed_time_begin : int option;
      alt_speed_time_enabled : bool option;
      alt_speed_time_end : int option;
      alt_speed_time_day : int option;
      alt_speed_up : int option;
      blocklist_url : string option;
      blocklist_enabled : bool option;
      cache_size_mb : int option;
      download_dir : string option;
      download_queue_size : int option;
      download_queue_enabled : bool option;
      dht_enabled : bool option;
      encryption : string option;
      idle_seeding_limit : int option;
      idle_seeding_limit_enabled : bool option;
      incomplete_dir : string option;
      incomplete_dir_enabled : bool option;
      lpd_enabled : bool option;
      peer_limit_global : int option;
      peer_limit_per_torrent : int option;
      pex_enabled : bool option;
      peer_port : int option;
      peer_port_random_on_start : bool option;
      port_forwarding_enabled : bool option;
      queue_stalled_enabled : bool option;
      queue_stalled_minutes : int option;
      rename_partial_files : bool option;
      script_torrent_done_filename : string option;
      script_torrent_done_enabled : bool option;
      seedRatioLimit : float option;
      seedRatioLimited : bool option;
      seed_queue_size : int option;
      seed_queue_enabled : bool option;
      speed_limit_down : int option;
      speed_limit_down_enabled : bool option;
      speed_limit_up : int option;
      speed_limit_up_enabled : bool option;
      start_added_torrents : bool option;
      trash_original_torrent_files : bool option;
      units : units option;
      utp_enabled : bool option
    }
    val arguments_to_yojson : arguments -> Yojson.Safe.json
  end
end
