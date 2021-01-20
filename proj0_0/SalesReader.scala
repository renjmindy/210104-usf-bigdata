package com.cjen.salescomputer

trait SalesReader {
    def readSales(): Seq[Sale]
}

case class Sale(saleID: Int, date: String, product: String, price: Int, paymentType: String, country: String)