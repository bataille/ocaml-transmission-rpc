open Yojson

module Torrent = struct
  type ids = 
    [ `All | `Torrent of int | `TorrentList of int list | `RecentlyActive ]

  let ids_to_yojson = function
    `All -> `Assoc []
  | `Torrent i -> `Int i
  | `TorrentList l -> 
      `List (l |> List.map (fun i -> `Int i))
  | `RecentlyActive -> `String "recently-active"

  type arguments = { ids : ids } [@@deriving to_yojson]

  module Set = struct
  end

  module Get = struct
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

    let field_name_to_yojson = function
      `ActivityDate -> `String "activityDate"
    | `AddedDate -> `String "addedDate"
    | `BandwithPriority -> `String "bandwithPriority"
    | `Comment -> `String "comment"
    | `CorruptEver -> `String "corruptEver"
    | `Creator -> `String "creator"
    | `DateCreated -> `String "dateCreated"
    | `DesiredAvailable -> `String "desiredAvailable"
    | `DoneDate -> `String "doneDate"
    | `DownloadDir -> `String "downloadDir"
    | `DownloadedEver -> `String "downloadedEver"
    | `DownloadLimit -> `String "downloadLimit"
    | `DownloadLimited -> `String "downloadLimited"
    | `Error -> `String "error"
    | `ErrorString -> `String "errorString"
    | `Eta -> `String "eta"
    | `EtaIdle -> `String "etaIdle"
    | `Files -> `String "files"
    | `FileStats -> `String "fileStats"
    | `HashString -> `String "hashString"
    | `HaveUnchecked -> `String "haveUnchecked"
    | `HaveValid -> `String "haveValid"
    | `HonorsSessionLimits -> `String "honorsSessionLimits"
    | `Id -> `String "id"
    | `IsFinished -> `String "isFinished"
    | `IsPrivate -> `String "isPrivate"
    | `IsStalled -> `String "isStalled"
    | `LeftUntilDone -> `String "leftUntilDone"
    | `MagnetLink -> `String "magnetLink"
    | `ManualAnnounceTime -> `String "manualAnnounceTime"
    | `MaxConnectedPeers -> `String "maxConnectedPeers"
    | `MetadataPercentComplete -> `String "metadataPercentComplete"
    | `Name -> `String "name"
    | `PeerLimit -> `String "peerLimit"
    | `Peers -> `String "peers"
    | `PeersConnected -> `String "peersConnected"
    | `PeersFrom -> `String "peersFrom"
    | `PeersGettingFromUs -> `String "peersGettingFromUs"
    | `PeersSendingToUs -> `String "peersSendingToUs"
    | `PercentDone -> `String "percentDone"
    | `Pieces -> `String "pieces"
    | `PieceCount -> `String "pieceCount"
    | `PieceSize -> `String "pieceSize"
    | `Priorities -> `String "priorities"
    | `QueuePosition -> `String "queuePosition"
    | `RateDownload -> `String "rateDownload"
    | `RateUpload -> `String "rateUpload"
    | `RecheckProgress -> `String "recheckProgress"
    | `SecondsDownloading -> `String "secondsDownloading"
    | `SecondsSeeding -> `String "secondsSeeding"
    | `SeedIdleLimit -> `String "seedIdleLimit"
    | `SeedIdleMode -> `String "seedIdleMode"
    | `SeedRatioLimit -> `String "seedRatioLimit"
    | `SeedRatioMode -> `String "seedRatioMode"
    | `SizeWhenDone -> `String "sizeWhenDone"
    | `StartDate -> `String "startDate"
    | `Status -> `String "status"
    | `Trackers -> `String "trackers"
    | `TrackerStats -> `String "trackerStats"
    | `TotalSize -> `String "totalSize"
    | `TorrentFile -> `String "torrentFile"
    | `UploadedEver -> `String "uploadedEver"
    | `UploadLimit -> `String "uploadLimit"
    | `UploadLimited -> `String "uploadLimited"
    | `UploadRatio -> `String "uploadRatio"
    | `Wanted -> `String "wanted"
    | `Webseeds -> `String "webseeds"
    | `WebseedsSendingToUs -> `String "webseedsSendingToUs"

    type arguments = {
      fields : field_name list;
      ids : ids
    } [@@deriving to_yojson]
  end

  module Remove = struct
    type arguments = {
      ids : ids;
      delete_local_data : bool [@key "delete-local-data"]
    } [@@deriving to_yojson]
  end
  
  module SetLocation = struct
    type arguments = {
      ids : ids;
      location : string;
      move : bool
    } [@@deriving to_yojson]
  end

  module RenamePath = struct
    type arguments = {
      ids : int;
      path : string;
      name : string
    } [@@deriving to_yojson]
  end
end
