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
