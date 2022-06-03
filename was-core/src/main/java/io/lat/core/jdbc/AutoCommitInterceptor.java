/*
e
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

package io.lat.core.jdbc;

import java.lang.reflect.Method;
import java.util.Map;

import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;
import org.apache.tomcat.jdbc.pool.ConnectionPool;
import org.apache.tomcat.jdbc.pool.JdbcInterceptor;
import org.apache.tomcat.jdbc.pool.PooledConnection;
import org.apache.tomcat.jdbc.pool.PoolProperties.InterceptorProperty;

/**
 * sets autocommit to true and commit the connection when connection close is invoked to complete the transaction
 * 
 * @author sangsik
 */
public class AutoCommitInterceptor extends JdbcInterceptor {

	private static final Log log = LogFactory.getLog(AutoCommitInterceptor.class);

	protected PooledConnection con = null;

	private boolean logging = false;

	public AutoCommitInterceptor() {
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		if (!Boolean.FALSE.equals(con.getPoolProperties().getDefaultAutoCommit())) {
			if (compare(CLOSE_VAL, method)) {
				if (con != null && !con.getConnection().getAutoCommit()) {
					con.getConnection().setAutoCommit(true);
					con.getConnection().commit();
					if (logging) {
						log.info(
								"setting auto-commit to true and calling commit on this connection");
					}
				}
			}
		}

		return super.invoke(proxy, method, args);
	}

	@Override
	public void reset(ConnectionPool parent, PooledConnection con) {
		this.con = con;
	}

	@Override
	public void setProperties(Map<String, InterceptorProperty> properties) {
		super.setProperties(properties);
		final String logging = "logging";
		InterceptorProperty p = properties.get(logging);
		if (p != null) {
			setLogging(Boolean.parseBoolean(p.getValue()));
		}
	}

	private void setLogging(boolean logging) {
		this.logging = logging;
	}
}