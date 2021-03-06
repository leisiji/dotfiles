# should setup CACHE_DIR at first, copy config_linux to cache dir
# GRADLE_HOME is set on archlinux, it should be set before command running
CACHE_DIR="$HOME/.cache/nvim/jdtls"
GENTOO_PREFIX=""
if [ -d $HOME/gentoo  ]; then
	GENTOO_PREFIX=$HOME/gentoo
fi
JDTLS_DIR="${GENTOO_PREFIX}/usr/share/java/jdtls"
JAR="$JDTLS_DIR/plugins/org.eclipse.equinox.launcher_*.jar"
java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "$CACHE_DIR/config_linux" \
  -data "${1:-$CACHE_DIR/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
