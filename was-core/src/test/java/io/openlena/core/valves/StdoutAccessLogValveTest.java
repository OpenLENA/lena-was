package io.openlena.core.valves;

import java.io.CharArrayWriter;

import org.junit.Test;

public class StdoutAccessLogValveTest {
	
	@Test
	public void logString() throws Exception {
		StdoutAccessLogValve valve = new StdoutAccessLogValve();
		String msg = "message";
		valve.log(msg);
	}

	@Test
	public void logCharArrayWriter() throws Exception {
		StdoutAccessLogValve valve = new StdoutAccessLogValve();
		CharArrayWriter caw = new CharArrayWriter();
		caw.append("message");
		valve.log(caw);
	}

}
