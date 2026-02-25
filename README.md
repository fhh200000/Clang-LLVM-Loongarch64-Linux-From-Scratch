# Clang-LLVM-Loongarch64-Linux-From-Scratch
Scripts to build Clang/LLVM-based (No GCC at all) LFS on Loongarch64. 
# Package details
| Package name | Package version |
| ----- | ----- |
| LFS | 12.4 Systemd version |
| BLFS | 12.4 Systemd version |
| LLVM | 21.1.8 |
| Glibc | 2.43 |
| zlib-ng | 2.3.3 |
| coreutils-rs | 0.6.0 |

# Build prerequisites
+ Clang/LLVM/LLD
+ libc++
+ patchelf
+ CMake/make
+ meson/ninja
+ flex/bison
+ gperf
+ pkgconf
+ Rust

# Current status
+ \[x\] Stage 0 (Host compilation)
+ \[x\] Chroot
+ \[ \] Stage 1 (Chroot compilation)
+ \[ \] Boot into LFS
