default[:ffmpeg][:install_method] = "source"

default[:ffmpeg][:version] = "2.1"
default[:ffmpeg][:source_url] = "http://ffmpeg.org/releases/ffmpeg-#{default[:ffmpeg][:version]}.tar.gz"
default[:ffmpeg][:source_prefix] = "/opt"
default[:ffmpeg][:options] = "/opt"
default[:ffmpeg][:autoconf_opts] = ['--enable-shared', '--enable-postproc', '--enable-pthreads', '--enable-gpl', '--enable-version3', '--enable-nonfree', '--enable-hardcoded-tables', '--enable-avresample', '--enable-vda', '--enable-libx264', '--extra-libs=-ldl', '--enable-libmp3lame', '--enable-libxvid', '--enable-libtheora', '--enable-libvorbis', '--enable-libass', '--enable-libopenjpeg', '--enable-libfaac', '--enable-libopencore-amrnb', '--enable-libopencore-amrwb', '--enable-libtheora'];

default[:ffmpeg][:packages] = %w[libopencore-amrnb-dev libopencore-amrwb-dev libgsm1-dev libgpac-dev autoconf automake build-essential git libass-dev libgpac-dev libtheora-dev libtool libvorbis-dev texi2html zlib1g-dev clang libmp3lame0 libmp3lame-dev libavcodec-extra-53 libopenjpeg2 libopenjpeg-dev xmlto build-essential git-core checkinstall texi2html libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxfixes-dev zlib1g-dev automake autoconf libxvidcore-dev nasm libfaac-dev]
