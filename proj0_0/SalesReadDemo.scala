package com.cjen.salescomputer

import scala.io.BufferedSource
import scala.io.Source
import java.io.File
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Map
import scala.collection.mutable.Set
import scala.collection.mutable.HashSet

class SalesReadDemo {

    def readSales(filename: String, dsize: String): Unit = {

        var openedFile : BufferedSource = null 
        var count = 0
        val rows = ArrayBuffer[Array[String]]()

        try {
            openedFile = Source.fromFile(filename)
            for (line <- openedFile.getLines.drop(1)) {
                rows += line.split(",").map(_.trim)
                count += 1
            } 
        } finally {
            if (openedFile != null) {
                var show = false
                openedFile.close()
                println("---------------------------------------------------------------------------------------------")
                println(s"\t this file contains ${count} lines! Info listed as follows:")
                println("\t Transaction_date | Product | Price | Payment_Type | Country")
                println("---------------------------------------------------------------------------------------------")
                var nrow = 0
                for (row <- rows) {
                    nrow += 1
                    if (dsize.toInt > 0) {
                        if (nrow <= dsize.toInt) {
                            show = true
                            println(s"${row(0).toInt}  |  ${row(1)}  |  ${row(2)}  |  ${row(3).toInt}  |  ${row(4)} | ${row(5)}")
                        }
                    } else { 
                        show = true
                        println(s"${row(0).toInt}  |  ${row(1)}  |  ${row(2)}  |  ${row(3).toInt}  |  ${row(4)} | ${row(5)}")
                    }
                } 
                if (show) println("------------------------------------------------------------------------------------------") 
            }
        }
    }
}