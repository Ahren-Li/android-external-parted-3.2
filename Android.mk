# create by Ahren-Li blog:www.lili.kim
#
# Copyright (C) 2007 The Android Open Source Project
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

parted_lib_src := lib/exitfail.c \
                  lib/dirname-lgpl.c \
                  lib/xstrtol-error.c \
                  lib/version-etc.c \
                  lib/tempname.c \
                  lib/localcharset.c \
                  lib/malloca.c \
                  lib/xstrtoull.c \
                  lib/closeout.c \
                  lib/wctype-h.c \
                  lib/quotearg.c \
                  lib/basename.c \
                  lib/xalloc-die.c \
                  lib/basename-lgpl.c \
                  lib/xstrndup.c \
                  lib/fd-hook.c \
                  lib/progname.c \
                  lib/dirname.c \
                  lib/version-etc-fsf.c \
                  lib/safe-read.c \
                  lib/unistd.c \
                  lib/xstrtoul.c \
                  lib/c-strcasecmp.c \
                  lib/long-options.c \
                  lib/c-ctype.c \
                  lib/stripslash.c \
                  lib/xstrtoll.c \
                  lib/xstrtol.c \
                  lib/xmalloc.c \
                  lib/close-stream.c \
                  lib/c-strncasecmp.c \
                  lib/argmatch.c \
                  lib/glthread/threadlib.c \
                  lib/glthread/lock.c \
                  lib/nl_langinfo.c

partprobe_src := partprobe/partprobe.c

parted_common_src :=  libparted/libparted.c \
                      libparted/labels/efi_crc32.c \
                      libparted/labels/sun.c \
                      libparted/labels/gpt.c \
                      libparted/labels/aix.c \
                      libparted/labels/pt-tools.c \
                      libparted/labels/loop.c \
                      libparted/labels/mac.c \
                      libparted/labels/dvh.c \
                      libparted/labels/bsd.c \
                      libparted/labels/rdb.c \
                      libparted/labels/pc98.c \
                      libparted/labels/dos.c \
                      libparted/device.c \
                      libparted/timer.c \
                      libparted/disk.c \
                      libparted/architecture.c \
                      libparted/unit.c \
                      libparted/debug.c \
                      libparted/arch/linux.c \
                      libparted/filesys.c \
                      libparted/exception.c \
                      libparted/cs/constraint.c \
                      libparted/cs/natmath.c \
                      libparted/cs/geom.c \
                      libparted/fs/ntfs/ntfs.c \
                      libparted/fs/ufs/ufs.c \
                      libparted/fs/amiga/amiga.c \
                      libparted/fs/amiga/asfs.c \
                      libparted/fs/amiga/a-interface.c \
                      libparted/fs/amiga/apfs.c \
                      libparted/fs/amiga/affs.c \
                      libparted/fs/btrfs/btrfs.c \
                      libparted/fs/linux_swap/linux_swap.c \
                      libparted/fs/jfs/jfs.c \
                      libparted/fs/reiserfs/reiserfs.c \
                      libparted/fs/xfs/xfs.c \
                      libparted/fs/nilfs2/nilfs2.c \
                      libparted/fs/ext2/interface.c \
                      libparted/fs/fat/bootsector.c \
                      libparted/fs/fat/fat.c \
                      libparted/fs/r/filesys.c \
                      libparted/fs/r/fat/table.c \
                      libparted/fs/r/fat/clstdup.c \
                      libparted/fs/r/fat/calc.c \
                      libparted/fs/r/fat/bootsector.c \
                      libparted/fs/r/fat/fat.c \
                      libparted/fs/r/fat/traverse.c \
                      libparted/fs/r/fat/count.c \
                      libparted/fs/r/fat/resize.c \
                      libparted/fs/r/fat/fatio.c \
                      libparted/fs/r/fat/context.c \
                      libparted/fs/r/hfs/hfs.c \
                      libparted/fs/r/hfs/file_plus.c \
                      libparted/fs/r/hfs/journal.c \
                      libparted/fs/r/hfs/advfs_plus.c \
                      libparted/fs/r/hfs/advfs.c \
                      libparted/fs/r/hfs/reloc.c \
                      libparted/fs/r/hfs/cache.c \
                      libparted/fs/r/hfs/file.c \
                      libparted/fs/r/hfs/reloc_plus.c \
                      libparted/fs/r/hfs/probe.c \
                      libparted/fs/hfs/hfs.c \
                      libparted/fs/hfs/probe.c

parted_exec_src := parted/table.c \
                      parted/parted.c \
                      parted/strlist.c \
                      parted/ui.c \
                      parted/command.c \
                      parted/version.c


common_include := $(LOCAL_PATH)/include \
                  $(LOCAL_PATH)/lib \
                  $(LOCAL_PATH)/bionic-fixup

common_cflag := -std=gnu99 -D_GNU_SOURCE -DLIBDIR=\"/system/lib\"

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(parted_lib_src)
LOCAL_C_INCLUDES := $(common_include)
LOCAL_CFLAGS := $(common_cflag)
LOCAL_STATIC_LIBRARIES := libc
LOCAL_MODULE := libparted_libs
LOCAL_MODULE_TAGS := optional
LOCAL_CLANG := true
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(parted_common_src) $(partprobe_src)
LOCAL_C_INCLUDES := $(common_include) \
                    external/e2fsprogs/lib \
                    external/libiconv/include \
                    $(LOCAL_PATH)/libparted \
                    $(LOCAL_PATH)/libparted/labels

LOCAL_CFLAGS := $(common_cflag) -include $(LOCAL_PATH)/bionic-fixup/AndroidFixup.h
LOCAL_STATIC_LIBRARIES := libiconv_static libparted_libs libext2_uuid_static libc
LOCAL_MODULE := libparted
LOCAL_MODULE_TAGS := optional
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(parted_exec_src)
LOCAL_C_INCLUDES := $(common_include)
LOCAL_SYSTEM_SHARED_LIBRARIES := libc
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_STATIC_LIBRARIES := libparted libiconv_static libparted_libs libext2_uuid_static
LOCAL_MODULE := parted-android
LOCAL_INSTALLED_MODULE_STEM := parted
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)
