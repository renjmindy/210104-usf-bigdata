package com.cjen.salesapp.model

import java.sql.ResultSet

case class Sales(saleId : Int, payDate : String, product : String, price : String, payType : String, country : String) {

}

object Sales {
    def fromResultSet (rs : ResultSet) = {
        apply (
            // colume names shoud be exactly the same as defined in your DBeaver table 
            rs.getInt("sale_id"),
            rs.getString("transaction_date"),
            rs.getString("product"),
            rs.getString("price"),
            rs.getString("payment_type"),
            rs.getString("country")
        )
    }
}