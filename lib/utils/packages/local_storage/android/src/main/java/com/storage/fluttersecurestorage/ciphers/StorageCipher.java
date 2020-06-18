package utils.packages.local_storage.android.src.main.java.com.storage.fluttersecurestorage.ciphers;

public interface StorageCipher {
    byte[] encrypt(byte[] input) throws Exception;

    byte[] decrypt(byte[] input) throws Exception;
}
