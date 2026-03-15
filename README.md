# Clang-LLVM-Loongarch64-Linux-From-Scratch
Scripts to build Clang/LLVM-based (No GCC at all) LFS on Loongarch64. 
# Package details
| Package name | Package version |
| ----- | ----- |
| LFS | 13.0 Systemd version |
| BLFS | 13.0 Systemd version |
| LLVM | 22.1.1 |
| Glibc | 2.43 |
| zlib-ng | 2.3.3 |
| coreutils-rs | 0.7.0 |

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
+ wget

# Current status
+ \[x\] Stage 0 (Host compilation)
+ \[x\] Chroot
+ \[ \] Stage 1 (Chroot compilation)
+ \[ \] Boot into LFS
