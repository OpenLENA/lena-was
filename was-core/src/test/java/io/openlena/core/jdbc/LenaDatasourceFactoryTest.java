package io.openlena.core.jdbc;

import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.junit.Test;

public class LenaDatasourceFactoryTest {

	@Test
	public void test() throws Exception {
		LenaDatasourceFactory factory = new LenaDatasourceFactory();
		Properties p = new Properties();
		p.setProperty("password", "3bd33f13a5aa11ffd36f9405ed9ff850");
		p.setProperty("url", "jdbc:tomcat:test");
		p.setProperty("driverClassName", "io.openlena.core.jdbc.test.driver.Driver");
		Context c = new InitialContext();
		factory.createDataSource(p, c, false);
	}
}
