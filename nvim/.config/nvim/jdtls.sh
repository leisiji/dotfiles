CACHE_DIR="$HOME/.cache/nvim/jdtls"
GENTOO_PREFIX=$HOME/.gentoo
JDTLS_DIR="${GENTOO_PREFIX}/usr/share/java/jdtls"
JAR="$JDTLS_DIR/plugins/org.eclipse.equinox.launcher_*.jar"
export GRADLE_HOME='$HOME/gradle'

$HOME/.jmgo_proj/code/jdk-16/bin/java \
	-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \
	-Declipse.application=org.eclipse.jdt.ls.core.id1 \
	-Dosgi.bundles.defaultStartLevel=4 \
	-Declipse.product=org.eclipse.jdt.ls.core.product \
	-Dlog.protocol=true \
	-Dlog.level=ALL \
	-Xms1g \
	-Xmx2G \
	-jar "$JAR" \
	-configuration "$CACHE_DIR/config_linux" \
	-data "${1:-$CACHE_DIR/workspace}" \
	--add-modules=ALL-SYSTEM \
	--add-opens java.base/java.util=ALL-UNNAMED \
	--add-opens java.base/java.lang=ALL-UNNAMED
