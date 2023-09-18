# DIRTY WORKAROUND to get FBEv2 working on fajita - until merged upstream
TFILE=$PWD/out/fscrypt.patched
MERGEDUP=vendor/twrp/libfscrypt/fscrypt.cpp

if [ ! -f "$MERGEDUP" ];then
    [ ! -d "out" ]&& mkdir -p out
    RET=0

    if [ -f "$TFILE" ];then
	echo "fscrypt patched already, skipping"
    else
	cd system/extras
	git apply ../../device/oneplus/fajita/patches/0001-fscrypt-bypass-FS_IOC_-G-S-ET_ENCRYPTION_POLICY.patch || RET=$?
	if [ $RET -ne 0 ];then
	    echo "FATAL: fscrypt.cpp could not be patched!! Decryption in TWRP will FAIL."
	    exit $RET
	else
	    echo "OK: fscrypt.cpp patched"
	    touch $TFILE
	fi
    fi
else
    echo "skipping: fscrypt patched merged in vendor/twrp already"
fi
