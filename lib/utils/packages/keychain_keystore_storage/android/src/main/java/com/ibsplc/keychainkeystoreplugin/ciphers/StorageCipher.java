package utils.packages.keychain_keystore_storage.android.src.main.java.com.ibsplc.keychainkeystoreplugin.ciphers;

public interface StorageCipher {
    byte[] encrypt(byte[] input) throws Exception;

    byte[] decrypt(byte[] input) throws Exception;
}
