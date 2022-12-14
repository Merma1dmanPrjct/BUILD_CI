# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/MoKee/android.git -b mkq-mr1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/IQ-7/local_manifest --depth 1 -b moke-10 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

source build/envsetup.sh
export BUILD_USERNAME=zacky
export BUILD_HOSTNAME=android-build
lunch mokee_whyred-userdebug
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
make bacon -j8  > reading & sleep 95m # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
# end 
