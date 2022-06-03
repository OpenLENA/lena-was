package io.lat.core.jdbc;

import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.junit.Test;

public class LatDatasourceFactoryTest {

	@Test
	public void test() throws Exception {
		LatDatasourceFactory factory = new LatDatasourceFactory();
		Properties p = new Properties();
		p.setProperty("password", "3bd33f13a5aa11ffd36f9405ed9ff850");
		p.setProperty("url", "jdbc:tomcat:test");
		p.setProperty("driverClassName", "io.lat.core.jdbc.test.driver.Driver");
		Context c = new InitialContext();
		factory.createDataSource(p, c, false);
	}
}
