package com.cjen.salesapp.utils

import java.sql.DriverManager
import java.sql.Connection

object ConnectionUtil {

    var conn : Connection = null;

    def getConnection() : Connection = {
        if (conn == null || conn.isClosed()) {
            classOf[org.postgresql.Driver].newInstance()
            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/cjen", 
                "cjen", 
                "Shaly#1006"
            )
        }
        conn
    }
}