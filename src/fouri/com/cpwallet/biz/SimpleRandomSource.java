package fouri.com.cpwallet.biz;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.SecureRandom;

import net.fouri.libs.bitutil.crypto.RandomSource;

public class SimpleRandomSource implements RandomSource {
	private FileRandomSource _frs = null;
	private SecureRandomSource _srs = null;

	private byte[] m_bytSeed = new byte[16];

	public SimpleRandomSource() {
		File file = new File("/dev/urandom");
		if (file.exists()) {
			_frs = new FileRandomSource();
		} else {
			_srs = new SecureRandomSource();
		}
	}

	public synchronized void nextBytes(byte[] bytes) {
		if (_frs != null)
			_frs.nextBytes(bytes);
		else
			_srs.nextBytes(bytes);
	}

	public synchronized byte[] nextBytes() {
		if (_frs != null)
			return _frs.nextBytes();
		else
			return _srs.nextBytes();
	}

	class FileRandomSource implements RandomSource {
		@Override
		public synchronized void nextBytes(byte[] bytes) {
			// On Android we use /dev/urandom for providing random data
			File file = new File("/dev/urandom");
			if (!file.exists()) {

				throw new RuntimeException("Unable to generate random bytes on this Android device");
			}
			try {
				FileInputStream stream = new FileInputStream(file);
				DataInputStream dis = new DataInputStream(stream);
				dis.readFully(bytes);
				dis.close();
				stream.close();
			} catch (IOException e) {
				throw new RuntimeException("Unable to generate random bytes on this Android device", e);
			}
		}

		public synchronized byte[] nextBytes() {
			nextBytes(m_bytSeed);
			return m_bytSeed;
		}
	}

	class SecureRandomSource implements RandomSource {
		SecureRandom _rnd;

		public SecureRandomSource() {
			_rnd = new SecureRandom(new byte[] { 42 });
		}

		@Override
		public void nextBytes(byte[] bytes) {
			_rnd.nextBytes(bytes);
		}

		public synchronized byte[] nextBytes() {
			nextBytes(m_bytSeed);
			return m_bytSeed;
		}
	}

}