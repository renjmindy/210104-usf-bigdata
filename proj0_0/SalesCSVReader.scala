package com.cjen.salescomputer

import scala.io.Source

class SalesCSVReader(val fileName: String) extends SalesReader {
    
    override def readSales(): Seq[Sale] = {
        for {
            line <- Source.fromFile(fileName).getLines().drop(1).toVector
            values = line.split(",").map(_.trim)
        } yield Sale(values(0).toInt, values(1), values(2), values(3).toInt, values(4), values(5))
    }
}