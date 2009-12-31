require 'formula'

class Figlet <Formula
  url 'ftp://ftp.figlet.org:21//pub/figlet/program/unix/figlet222.tar.gz'
  homepage 'http://figlet.org'
  md5 '5f84ad52d092d5db4ad5916df767646b'

  def install
    system "chmod 666 Makefile"
    system "mkdir -p #{prefix}/man/man6"
    system "mkdir -p #{prefix}/bin"
    inreplace "Makefile", "/usr/local/", "#{prefix}/"
    inreplace "Makefile", %Q{DEFAULTFONTDIR = fonts}, %Q{DEFAULTFONTDIR = #{prefix}/fonts}
    system "make install"
  end
end
