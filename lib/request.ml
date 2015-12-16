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
    type arguments = {
      bandwidthPriority : (int option [@default None]);
      downloadLimit : (int option [@default None]);
      downloadLimited : (bool option [@default None]);
      files_wanted : (int list option [@default None])
        [@key "files-wanted"];
      files_unwanted : (int list option [@default None])
        [@key "files-unwanted"];
      honorsSessionLimits : (bool option [@default None]);
      ids : ids;
      location : (string option [@default None]);
      peer_limit : (int option [@default None])[@key "peer-limit"];
      priority_high : (int list option [@default None])
        [@key "priority-high"];
      priority_low : (int list option [@default None])
        [@key "priority-low"];
      priority_normal : (int list option [@default None])
        [@key "priority-normal"];
      queuePosition : (int option [@default None]);
      seedIdleLimit : (int option [@default None]);
      seedIdleMode : (int option [@default None]);
      seedRatioLimit : (float option [@default None]);
      seedRatioMode : (int option [@default None]);
      trackerAdd : (string list option [@default None]);
      trackerRemove : (int list option [@default None]);
      trackerReplace : ((int*string) list option [@default None]);
      uploadLimit : (int option [@default None]);
      uploadLimited : (bool option [@default None])
    } [@@deriving to_yojson]
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

  module Add = struct
    type to_add = [ `Filename of string | `Metainfo of string ]

    type arguments = {
      cookies : (string option [@default None]);
      download_dir : (string option [@default None]);
      filename : (string option [@default None]);
      metainfo : (string option [@default None]);
      paused : (bool option [@default None]);
      peer_limit : (int option [@default None])[@key "peer-limit"];
      bandwithPriority : (int option [@default None]);
      files_wanted : (int list option [@default None]);
      files_unwanted : (int list option [@default None])
        [@key "files-unwanted"];
      priority_hight: (int list option [@default None])
        [@key "priority-hight"];
      priority_low: (int list option [@default None])
        [@key "priority-low"];
      priority_normal: (int list option [@default None])
        [@key "priority-normal"]
    }[@@deriving to_yojson]
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

module Session = struct
  module Set = struct
    type units = {
      speed_units : string list;
      speed_bytes : int;
      size_units : string list;
      size_bytes : int;
      memory_units : string list;
      memory_bytes : int
    } [@@deriving to_yojson]

    type arguments = {
      alt_speed_down : (int option [@default None])
        [@key "alt-speed-down"];
      alt_speed_enabled : (bool option [@default None])
        [@key "alt-speed-enabled"];
      alt_speed_time_begin : (int option [@default None])
        [@key "alt-speed-time-begin"];
      alt_speed_time_enabled : (bool option [@default None])
        [@key "alt-speed-time-enabled"];
      alt_speed_time_end : (int option [@default None])
        [@key "alt-speed-time-end"];
      alt_speed_time_day : (int option [@default None])
        [@key "alt-speed-time-day"];
      alt_speed_up : (int option [@default None])
        [@key "alt-speed-up"];
      blocklist_url : (string option [@default None])
        [@key "blocklist-url"];
      blocklist_enabled : (bool option [@default None])
        [@key "blocklist-enabled"];
      cache_size_mb : (int option [@default None])
        [@key "cache-size-mb"];
      download_dir : (string option [@default None])
        [@key "download-dir"];
      download_queue_size : (int option [@default None])
        [@key "download-queue-size"];
      download_queue_enabled : (bool option [@default None])
        [@key "download-queue-enabled"];
      dht_enabled : (bool option [@default None])
        [@key "dht-enabled"];
      encryption : (string option [@default None]);
      idle_seeding_limit : (int option [@default None])
        [@key "idle-seeding-limit"];
      idle_seeding_limit_enabled : (bool option [@default None])
        [@key "idle-seeding-limit-enabled"];
      incomplete_dir : (string option [@default None])
        [@key "incomplete-dir"];
      incomplete_dir_enabled : (bool option [@default None])
        [@key "incomplete-dir-enabled"];
      lpd_enabled : (bool option [@default None])
        [@key "lpd-enabled"];
      peer_limit_global : (int option [@default None])
        [@key "peer-limit-global"];
      peer_limit_per_torrent : (int option [@default None])
        [@key "peer-limit-per-torrent"];
      pex_enabled : (bool option [@default None])
        [@key "pex-enabled"];
      peer_port : (int option [@default None])
        [@key "peer-port"];
      peer_port_random_on_start : (bool option [@default None])
        [@key "peer-port-random-on-start"];
      port_forwarding_enabled : (bool option [@default None])
        [@key "port-forwarding-enabled"];
      queue_stalled_enabled : (bool option [@default None])
        [@key "queue-stalled-enabled"];
      queue_stalled_minutes : (int option [@default None])
        [@key "queue-stalled-minutes"];
      rename_partial_files : (bool option [@default None])
        [@key "rename-partial-files"];
      script_torrent_done_filename : (string option [@default None])
        [@key "script-torrent-done-filename"];
      script_torrent_done_enabled : (bool option [@default None])
        [@key "script-torrent-done-enabled"];
      seedRatioLimit : (float option [@default None]);
      seedRatioLimited : (bool option [@default None]);
      seed_queue_size : (int option [@default None])
        [@key "seed-queue-size"];
      seed_queue_enabled : (bool option [@default None])
        [@key "seed-queue-enabled"];
      speed_limit_down : (int option [@default None])
        [@key "speed-limit-down"];
      speed_limit_down_enabled : (bool option [@default None])
        [@key "speed-limit-down-enabled"];
      speed_limit_up : (int option [@default None])
        [@key "speed-limit-up"];
      speed_limit_up_enabled : (bool option [@default None])
        [@key "speed-limit-up-enabled"];
      start_added_torrents : (bool option [@default None])
        [@key "start-added-torrents"];
      trash_original_torrent_files : (bool option [@default None])
        [@key "trash-original-torrent-files"];
      units : (units option [@default None]);
      utp_enabled : (bool option [@default None])
        [@key "utp-enabled"]
    } [@@deriving to_yojson {strict = false}]
  end
end
