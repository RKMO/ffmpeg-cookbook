default[:ffmpeg][:install_method] = "source"

default[:ffmpeg][:version] = "2.1"
default[:ffmpeg][:source_url] = "http://ffmpeg.org/releases/ffmpeg-#{default[:ffmpeg][:version]}.tar.gz"
default[:ffmpeg][:source_prefix] = "/opt"
default[:ffmpeg][:options] = "/opt"
default[:ffmpeg][:autoconf_opts] = ['--enable-shared', '--enable-pthreads', '--enable-gpl', '--enable-version3', '--enable-nonfree', '--enable-hardcoded-tables', '--enable-avresample', '--enable-vda', '--cc=clang', '--enable-libx264', '--enable-libfaac', '--enable-libmp3lame', '--enable-libxvid', '--enable-libtheora', '--enable-libvorbis', '--enable-libvpx', '--enable-libass', '--enable-libspeex', '--enable-libschroedinger', '--enable-libopus', '--enable-libopenjpeg'];
default[:ffmpeg][:packages] = %[yasm clang libass-dev libjack-jackd2-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev libva-dev libvdpau-dev libvorbis-dev libavfilter-dev libfreetype6-dev libvpx-dev libx11-dev libxfixes-dev texi2html zlib1g-dev libgnutls-dev libdirac-dev libgsm1-dev libgsmme-dev libmodplug-dev libopenjpeg-dev librtmp-dev libschroedinger-dev libspeex-dev libvo-aacenc-dev libvo-amrwbenc-dev libxvidcore-dev libopenal-dev libdc1394-22-dev libv4l-dev libcdio-dev libcdio-cdda-dev libcdio-paranoia-dev]
