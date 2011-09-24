nvid-build.sh
-------------

- Finds the GCC version used with the kernel
- Finds the NVIDIA driver installer with the latest modified date in the current directory
- Move the existing GCC symbolic link away
- Create a new one with the kernel GCC version
- Stop GDM
- Install
- Start GDM
- Move the existing GCC version back
