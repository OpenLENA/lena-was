package io.openlena.core.util;

import org.junit.Test;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import static org.junit.Assert.*;

public class EncryptorTest {

    @Test
    public void encrypt() throws Exception {
        Encryptor encryptor = new Encryptor();
        String plainText = "plainText";
        assertNotEquals(plainText, encryptor.encrypt(plainText));
    }

    @Test
    public void decrypt() throws Exception {
        Encryptor encryptor = new Encryptor();
        String encryptedText = "3bd33f13a5aa11ffd36f9405ed9ff850";
        assertNotEquals(encryptedText, encryptor.decrypt(encryptedText));
    }

    @Test
    public void encryptAndDecrypt() throws Exception {
        Encryptor encryptor = new Encryptor();
        String plainText = "plainText";
        // encrypt
        String encryptedText = encryptor.encrypt(plainText);
        // compare plain Text and decrypted Text
        assertEquals(plainText, encryptor.decrypt(encryptedText));
    }

    @Test
    public  void testMain() throws  Exception {
        Encryptor encryptor = new Encryptor();
        String key = "encryptKey";
        String plainText = "plainText";

        String[] arg = new String[] {plainText,key};
        encryptor.main(arg);

        String[] arg2 = new String[] {plainText};
        encryptor.main(arg2);

        String[] arg3 = new String[] {plainText,key,"exception"};
        encryptor.main(arg2);
    }
}