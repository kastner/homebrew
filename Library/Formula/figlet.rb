require 'formula'

class ContribFonts <Formula
  url 'ftp://ftp.figlet.org:21//pub/figlet/fonts/contributed.tar.gz'
  version '222'
  md5 '6e2dec4499f7a7fe178522e02e0b6cd1'
end

class InternationalFonts <Formula
  url 'ftp://ftp.figlet.org:21//pub/figlet/fonts/international.tar.gz'
  version '222'
  md5 'b2d53f7e251014adcdb4d407c47f90ef'
end

class Figlet <Formula
  url 'ftp://ftp.figlet.org:21//pub/figlet/program/unix/figlet222.tar.gz'
  homepage 'http://figlet.org'
  md5 '5f84ad52d092d5db4ad5916df767646b'

  def fonts
    prefix + "fonts"
  end

  def patches
    DATA
  end


  def install
    system "chmod 666 Makefile"
    system "chmod 666 showfigfonts"
    system "mkdir -p #{prefix}/man/man6"
    system "mkdir -p #{prefix}/bin"

    ContribFonts.new.brew { fonts.install Dir['*'] }
    InternationalFonts.new.brew { fonts.install Dir['*'] }

    inreplace "Makefile", "/usr/local/", "#{prefix}/"
    inreplace "Makefile", %Q{DEFAULTFONTDIR = fonts}, %Q{DEFAULTFONTDIR = #{fonts}}
    system "make install"
  end
end

__END__
diff --git a/showfigfonts b/showfigfonts
index 643c60b..543379c 100644
--- a/showfigfonts
+++ b/showfigfonts
@@ -14,6 +14,7 @@
 DIRSAVE=`pwd`
 cd `dirname "$0"`
 PATH="$PATH":`pwd`
+FIGDIR=`pwd`
 cd "$DIRSAVE"
 
 # Get figlet version
@@ -42,12 +43,12 @@ else
     FONTDIR="`figlet -F | sed -e '1d' -e '3,$d' -e 's/Font directory: //'`"
   else
     # figlet 2.1 or later
-    FONTDIR="`figlet -I2`"
+    FONTDIR="`${FIGDIR}/figlet -I2`"
   fi
 fi
 
 cd "$FONTDIR"
-FONTLIST=`ls *.flf | sed s/\.flf$//`
+FONTLIST=`ls *.fl* | sed s/\.fl.$//`
 cd $DIRSAVE
 for F in $FONTLIST ; do
   echo "$F" :
