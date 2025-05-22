ANDROID_KEYSTORE_BASE_64="" # See flutter/.envrc.local
ANDROID_KEYPROPERTIES_BASE_64=""

mkdir -p android/app

# From flutter/scripts/android-setup.sh
if [[ -d "${ANDROID_KEYSTORE_BASE_64}" ]]; then
    echo "ANDROID_KEYSTORE_BASE_64 is not set"
    exit 1
fi

echo $ANDROID_KEYSTORE_BASE_64 | base64 -d > android/app/keystore.jks
echo $ANDROID_KEYPROPERTIES_BASE_64 | base64 -d > android/app/key.properties

RELEASE_STOREPASSWORD="" # See flutter/.envrc.android-keystore.local
RELEASE_KEYPASSWORD=""
RELEASE_KEYALIAS=""

# Check if the keystore file is valid
if [ ! -f "android/app/keystore.jks" ]; then
    echo "Keystore file not found!"
    exit 1
fi

keytool -list -v -keystore android/app/keystore.jks -storepass $RELEASE_STOREPASSWORD

rm -rf android