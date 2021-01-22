package com.cjen.salesapp.daos

import com.cjen.salesapp.model.Sales
import com.cjen.salesapp.utils.ConnectionUtil
import scala.util.Using
import scala.collection.mutable.ArrayBuffer

object SalesDao {

    def getAll(): Seq[Sales] = {

        val conn = ConnectionUtil.getConnection();
        Using.Manager { use => 
            val stmt = use(conn.prepareStatement("SELECT * FROM sales;"))
            stmt.execute()
            val rs = use(stmt.getResultSet())
            val allSales: ArrayBuffer[Sales] = ArrayBuffer()
            while (rs.next()) {
                allSales.addOne(Sales.fromResultSet(rs))
            }
            allSales.toList
        }.get
    }

    def getPayType(payment_type: String): Seq[Sales] = {

        val conn = ConnectionUtil.getConnection()
        Using.Manager { use =>
            val stmt = use(conn.prepareStatement("SELECT * FROM sales WHERE payment_type = ?"))
            stmt.setString(1, payment_type)
            stmt.execute()
            val rs = use(stmt.getResultSet())
            val salesWithPaymentType : ArrayBuffer[Sales] = ArrayBuffer()
            while (rs.next()) {
                salesWithPaymentType.addOne(Sales.fromResultSet(rs))
            }
            salesWithPaymentType.toList
        }.get
    }

    def getCountry(country: String): Seq[Sales] = {

        val conn = ConnectionUtil.getConnection()
        Using.Manager { use =>
            val stmt = use(conn.prepareStatement("SELECT * FROM sales WHERE country = ?"))
            stmt.setString(1, country)
            stmt.execute()
            val rs = use(stmt.getResultSet())
            val salesWithCountry : ArrayBuffer[Sales] = ArrayBuffer()
            while (rs.next()) {
                salesWithCountry.addOne(Sales.fromResultSet(rs))
            }
            salesWithCountry.toList
        }.get
    }

    def saveNew(sales : Sales) : Boolean = {

        val conn = ConnectionUtil.getConnection()
        Using.Manager { use =>
            val stmt = use(conn.prepareStatement("INSERT INTO sales VALUES (DEFAULT, ?, ?, ?, ?, ?);"))
            stmt.setString(1, sales.payDate)
            stmt.setString(2, sales.product)
            stmt.setString(3, sales.price)
            stmt.setString(4, sales.payType)
            stmt.setString(5, sales.country)
            stmt.execute()
            stmt.getUpdateCount() > 0
        }.getOrElse(false)
    }

    def deleteOld(sales : Sales) : Boolean = {

        val conn = ConnectionUtil.getConnection()
        Using.Manager { use =>
            val stmt = use(conn.prepareStatement("DELETE FROM sales WHERE transaction_date = ? and product = ? and price = ? and payment_type = ? and country = ?;"))
            stmt.setString(1, sales.payDate)
            stmt.setString(2, sales.product)
            stmt.setString(3, sales.price)
            stmt.setString(4, sales.payType)
            stmt.setString(5, sales.country)
            stmt.execute()
            stmt.getUpdateCount() > 0
        }.getOrElse(false)
    }

    def updateOld(sales : Sales) : Boolean = {

        val conn = ConnectionUtil.getConnection()
        Using.Manager { use =>
            val stmt = use(conn.prepareStatement("UPDATE sales SET product = ?, price = ?, payment_type = ?, country = ? WHERE sales_id = ? and transaction_date = ?;"))
            stmt.setString(1, sales.product)
            stmt.setString(2, sales.price)
            stmt.setString(3, sales.payType)
            stmt.setString(4, sales.country)
            stmt.setInt(5, sales.saleId)
            stmt.setString(6, sales.payDate)
            stmt.execute()
            stmt.getUpdateCount() > 0
        }.getOrElse(false)
    }

}









