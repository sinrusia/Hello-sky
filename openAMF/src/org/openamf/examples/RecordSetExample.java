/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.examples;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.recordset.ASRecordSet;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.1 $, $Date: 2003/08/20 20:31:53 $
 */
public class RecordSetExample {

	private static Log log = LogFactory.getLog(RecordSetExample.class);

	/**
	 * Normally you would return a java.sql.ResultSet, 
	 * but since this is a test I want to make sure a
	 * RecordSet comes back 
	 * 
	 * @param sql
	 * @param dbURL
	 * @param jdbcDriver
	 * @return
	 */
	public ASRecordSet getData(String sql, String dbURL, String jdbcDriver) {

		ASRecordSet asRecordSet = new ASRecordSet();

		Connection conn = null;

		try {
			conn = getConnection(dbURL, jdbcDriver);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			asRecordSet.populate(rs);
			log.debug("populated asRecordSet with rs");
			rs.close();
			stmt.close();
		} catch (Exception e) {
			log.error("Unable to execute sql", e);
			// return error as record set
			int rowCount = 25;
			List rows = new ArrayList();
			for (int i = 0; i < rowCount; i++) {
				List row = new ArrayList();
				row.add(e.getMessage() + (i + 1));
				row.add(sql + (i + 1));
				row.add(dbURL + (i + 1));
				rows.add(row);
			}
			asRecordSet.populate(new String[]{"Error", "SQL", "dbUrl"},  rows);
			log.debug("populated asRecordSet with rows");
		}

		return asRecordSet;

	}

	private Connection getConnection(String dbURL, String jdbcDriver)
		throws
			ClassNotFoundException,
			InstantiationException,
			IllegalAccessException,
			SQLException {

		Connection conn = null;

		//Load driver
		Class.forName(jdbcDriver).newInstance();

		conn = DriverManager.getConnection(dbURL);

		return conn;
	}

	public static void main(String[] args) {
		ASRecordSet asRecordSet =
			new RecordSetExample().getData(
				"Select * from users",
				"jdbc:mysql://localhost/openamf?user=openamf&password=openamf",
				"com.mysql.jdbc.Driver");
				
		System.out.println(asRecordSet);
	}

}
