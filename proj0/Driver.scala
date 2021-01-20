package com.cjen.salesapp

import java.sql.DriverManager
import java.sql.ResultSet
import com.cjen.salesapp.utils.ConnectionUtil
import com.cjen.salesapp.model.Sales
import scala.util.Using
import java.sql.Connection
import com.cjen.salesapp.daos.SalesDao
import com.cjen.salesapp.cli.Cli

object Driver {

  def main(args: Array[String]): Unit = {
    val cli = new Cli();
    cli.menu()
  }
}

