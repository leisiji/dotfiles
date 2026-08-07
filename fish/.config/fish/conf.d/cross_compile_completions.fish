# ============================================================
# Cross-compile tool completions
#
# Makes prefixed tools (e.g., arm-linux-gnueabihf-strip) borrow
# completions from the base tool (strip).
#
# To add a new prefix, append to the $__cross_prefixes list.
# To add a new tool,   append to the $__cross_tools list.
# ============================================================

set -g __cross_prefixes \
    arm-linux-gnueabihf \
    aarch64-linux-gnu \
    arm-none-eabi \
    riscv64-linux-gnu \
    riscv64-unknown-elf \
    mips-linux-gnu \
    powerpc-linux-gnu \

set -g __cross_tools \
    gcc g++ c++ cpp gfortran gcov gcov-dump gcov-tool \
    ar as ld nm objcopy objdump ranlib readelf size strings strip \
    addr2line elfedit c++filt dwp gold gprof strace \

for prefix in $__cross_prefixes
    for tool in $__cross_tools
        complete -c $prefix-$tool -w $tool 2>/dev/null
    end
end
