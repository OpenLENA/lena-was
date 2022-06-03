package io.lat.core.jdbc;

import java.sql.Connection;

import org.junit.Test;

import io.lat.core.jdbc.test.DefaultTestCase;
import io.lat.core.jdbc.test.driver.Driver;

public class AutoCommitInterceptorTest extends DefaultTestCase {

	@Test
	public void test() throws Exception {
		this.datasource.setJdbcInterceptors(AutoCommitInterceptor.class.getName());
		this.datasource.setDriverClassName(Driver.class.getName());
		this.datasource.setUrl("jdbc:tomcat:test");
		Connection con = this.datasource.getConnection();
		con.close();
	}

}
