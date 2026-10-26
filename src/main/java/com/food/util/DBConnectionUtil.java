package com.food.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBConnectionUtil {

		private static final String URL="jdbc:mysql://localhost:3306/Foodify";
		private static final String USERNAME="root"; 
		private static final String PASSWORD="mysql123";
		static Connection connection;
		
		
		static public Connection getConnections(){
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				 connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
				
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return connection;
		

	}

}
