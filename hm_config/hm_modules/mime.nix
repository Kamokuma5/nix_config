{ config, pkgs, lib, ... }:
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
    
    # In order to debug mimetypes, use the following command:
    # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query default text/html
    mimeApps.defaultApplications = 
    let
      browser = [
        "zen_twilight.desktop"
      ];

      editor = [
        "code.desktop"
      ];

      video_player = [
        "mpv.desktop"
      ];

      image_viewer = [
        "org.kde.gwenview.desktop"
      ];
    in
    {
      # Web
      "text/html" = browser;
      "application/xhtml+xml" = browser;
      "application/x-httpd-php" = browser;
      "application/x-javascript" = browser;
      "application/vnd.mozilla.xul+xml" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/chrome" = browser;
      "application/rdf+xml" = browser;
      "application/rss+xml" = browser;
      "application/x-xpinstall" = browser;
      "application/xhtml_xml" = browser;
      "application/xml" = browser;

      # Dev
      "text/x-python" = editor;
      "text/x-shellscript" = editor;
      "text/x-ruby" = editor;
      "text/x-perl" = editor;
      "text/x-php" = editor;
      "text/x-go" = editor;
      "text/x-sql" = editor;
      "text/english" = editor;
      "text/plain" = editor;
      "text/x-c" = editor;
      "text/x-c++" = editor;
      "text/x-c++hdr" = editor;
      "text/x-c++src" = editor;
      "text/x-chdr" = editor;
      "text/x-csrc" = editor;
      "text/x-java" = editor;
      "text/x-makefile" = editor;
      "text/x-moc" = editor;
      "text/x-pascal" = editor;
      "text/x-tcl" = editor;
      "text/x-tex" = editor;
      "text/xml" = editor;
      "application/javascript" = editor;
      "application/json" = editor;

      # Video and Audio
      "application/mxf" = video_player;
      "application/ogg" = video_player;
      "application/sdp" = video_player;
      "application/smil" = video_player;
      "application/streamingmedia" = video_player;
      "application/vnd.apple.mpegurl" = video_player;
      "application/vnd.ms-asf" = video_player;
      "application/vnd.rn-realmedia" = video_player;
      "application/vnd.rn-realmedia-vbr" = video_player;
      "application/x-cue" = video_player;
      "application/x-extension-m4a" = video_player;
      "application/x-extension-mp4" = video_player;
      "application/x-matroska" = video_player;
      "application/x-mpegurl" = video_player;
      "application/x-ogg" = video_player;
      "application/x-ogm" = video_player;
      "application/x-ogm-audio" = video_player;
      "application/x-ogm-video" = video_player;
      "application/x-shellscript" = video_player;
      "application/x-shorten" = video_player;
      "application/x-smil" = video_player;
      "application/x-streamingmedia" = video_player;
      "audio/3gpp" = video_player;
      "audio/3gpp2" = video_player;
      "audio/AMR" = video_player;
      "audio/aac" = video_player;
      "audio/ac3" = video_player;
      "audio/aiff" = video_player;
      "audio/amr-wb" = video_player;
      "audio/dv" = video_player;
      "audio/eac3" = video_player;
      "audio/flac" = video_player;
      "audio/m3u" = video_player;
      "audio/m4a" = video_player;
      "audio/mp1" = video_player;
      "audio/mp2" = video_player;
      "audio/mp3" = video_player;
      "audio/mp4" = video_player;
      "audio/mpeg" = video_player;
      "audio/mpeg2" = video_player;
      "audio/mpeg3" = video_player;
      "audio/mpegurl" = video_player;
      "audio/mpg" = video_player;
      "audio/musepack" = video_player;
      "audio/ogg" = video_player;
      "audio/opus" = video_player;
      "audio/rn-mpeg" = video_player;
      "audio/scpls" = video_player;
      "audio/vnd.dolby.heaac.1" = video_player;
      "audio/vnd.dolby.heaac.2" = video_player;
      "audio/vnd.dts" = video_player;
      "audio/vnd.dts.hd" = video_player;
      "audio/vnd.rn-realaudio" = video_player;
      "audio/vnd.wave" = video_player;
      "audio/vorbis" = video_player;
      "audio/wav" = video_player;
      "audio/webm" = video_player;
      "audio/x-aac" = video_player;
      "audio/x-adpcm" = video_player;
      "audio/x-aiff" = video_player;
      "audio/x-ape" = video_player;
      "audio/x-m4a" = video_player;
      "audio/x-matroska" = video_player;
      "audio/x-mp1" = video_player;
      "audio/x-mp2" = video_player;
      "audio/x-mp3" = video_player;
      "audio/x-mpegurl" = video_player;
      "audio/x-mpg" = video_player;
      "audio/x-ms-asf" = video_player;
      "audio/x-ms-wma" = video_player;
      "audio/x-musepack" = video_player;
      "audio/x-pls" = video_player;
      "audio/x-pn-au" = video_player;
      "audio/x-pn-realaudio" = video_player;
      "audio/x-pn-wav" = video_player;
      "audio/x-pn-windows-pcm" = video_player;
      "audio/x-realaudio" = video_player;
      "audio/x-scpls" = video_player;
      "audio/x-shorten" = video_player;
      "audio/x-tta" = video_player;
      "audio/x-vorbis" = video_player;
      "audio/x-vorbis+ogg" = video_player;
      "audio/x-wav" = video_player;
      "audio/x-wavpack" = video_player;
      "video/3gp" = video_player;
      "video/3gpp" = video_player;
      "video/3gpp2" = video_player;
      "video/avi" = video_player;
      "video/divx" = video_player;
      "video/dv" = video_player;
      "video/fli" = video_player;
      "video/flv" = video_player;
      "video/mkv" = video_player;
      "video/mp2t" = video_player;
      "video/mp4" = video_player;
      "video/mp4v-es" = video_player;
      "video/mpeg" = video_player;
      "video/msvideo" = video_player;
      "video/ogg" = video_player;
      "video/quicktime" = video_player;
      "video/vnd.avi" = video_player;
      "video/vnd.divx" = video_player;
      "video/vnd.mpegurl" = video_player;
      "video/vnd.rn-realvideo" = video_player;
      "video/webm" = video_player;
      "video/x-avi" = video_player;
      "video/x-flc" = video_player;
      "video/x-flic" = video_player;
      "video/x-flv" = video_player;
      "video/x-m4v" = video_player;
      "video/x-matroska" = video_player;
      "video/x-mpeg2" = video_player;
      "video/x-mpeg3" = video_player;
      "video/x-ms-afs" = video_player;
      "video/x-ms-asf" = video_player;
      "video/x-ms-wmv" = video_player;
      "video/x-ms-wmx" = video_player;
      "video/x-ms-wvxvideo" = video_player;
      "video/x-msvideo" = video_player;
      "video/x-ogm" = video_player;
      "video/x-ogm+ogg" = video_player;
      "video/x-theora" = video_player;
      "video/x-theora+ogg" = video_player;

      # Image
      "image/jpeg" = image_viewer;
      "image/png" = image_viewer;
      "image/gif" = image_viewer;
      "image/bmp" = image_viewer;
      "image/tiff" = image_viewer;
      "image/webp" = image_viewer;
      "image/x-icon" = image_viewer;
      "image/svg+xml" = image_viewer;

      # Other
      "application/pdf" = browser;
      "inode/directory" = [ "yazi.desktop" ];
    };
  };
}