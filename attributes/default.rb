default[:ffmpeg][:install_method] = "source"

default[:ffmpeg][:version] = "2.1"
default[:ffmpeg][:source_url] = "http://ffmpeg.org/releases/ffmpeg-#{default[:ffmpeg][:version]}.tar.gz"
default[:ffmpeg][:source_prefix] = "/opt"
default[:ffmpeg][:options] = "/opt"
default[:ffmpeg][:autoconf_opts] = ['--enable-shared', '--enable-pthreads', '--enable-gpl', '--enable-version3', '--enable-nonfree', '--enable-hardcoded-tables', '--enable-avresample', '--enable-vda', '--cc=clang', '--enable-libx264', '--enable-libfaac', '--enable-libmp3lame', '--enable-libxvid', '--enable-libtheora', '--enable-libvorbis', '--enable-libvpx', '--enable-libass', '--enable-libspeex', '--enable-libschroedinger', '--enable-libopus', '--enable-libopenjpeg'];
