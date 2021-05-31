/*
* Copyright 2021 LENA Development Team.
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

package io.openlena.core.jdbc;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.naming.Context;

import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;
import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.DataSourceFactory;
import org.apache.tomcat.jdbc.pool.PoolConfiguration;
import org.apache.tomcat.jdbc.pool.XADataSource;

import io.openlena.core.util.Encryptor;

/**
 * encrypt datasource password
 * 
 * @author Erick Yu
 */
public class LenaDatasourceFactory extends DataSourceFactory {

	private static final Log log = LogFactory.getLog(LenaDatasourceFactory.class);

	private Encryptor encryptor = null;

	public LenaDatasourceFactory() {
		try {
			encryptor = new Encryptor();
		}
		catch (Exception e) {
			// Do Nothing
		}
	}

	@Override
	public DataSource createDataSource(Properties properties, Context context, boolean XA)
			throws InvalidKeyException, IllegalBlockSizeException, BadPaddingException, SQLException, NoSuchAlgorithmException, NoSuchPaddingException {
		// Here we decrypt our password.
		PoolConfiguration poolProperties = LenaDatasourceFactory.parsePoolProperties(properties);
		poolProperties.setPassword(encryptor.decrypt(poolProperties.getPassword()));

		// The rest of the code is copied from Tomcat's DataSourceFactory.
		if (poolProperties.getDataSourceJNDI() != null && poolProperties.getDataSource() == null) {
			performJNDILookup(context, poolProperties);
		}
		org.apache.tomcat.jdbc.pool.DataSource dataSource = XA ? new XADataSource(poolProperties) : new org.apache.tomcat.jdbc.pool.DataSource(poolProperties);
		dataSource.createPool();

		return dataSource;
	}

}
