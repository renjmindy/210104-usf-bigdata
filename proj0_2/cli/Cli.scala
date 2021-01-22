package com.cjen.salesapp.cli

import scala.io.BufferedSource
import scala.io.Source
import scala.io.StdIn.readLine
import scala.util.matching.Regex
import com.cjen.salesapp.daos.SalesDao
import com.cjen.salesapp.model.Sales
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Map
import scala.collection.MapView

class Cli {

    val commandArgPattern : Regex = "(\\w+)\\s*(.*)".r

    def printWelcome(): Unit = {
        println()
        println("\t\t\t\t\t Hello! Welcome to SalesApp!")
        println("-----------------------------------------------------------------------------------------------------------------------------------------------")
    }

    def printOptions(): Unit = {
        println()
        println("Main Menu Page:\n")
        println("\t \"0\" :...............................................................list all sales details stored in SalesApp\n")
        println("\t \"paydates\" :........................................................list all transaction dates stored in SalesApp\n")
        println("\t \"countries\" :.......................................................list all countries stored in SalesApp\n")
        println("\t \"paytypes\" :........................................................list all payment types stored in SalesApp\n")
        println("\t \"insert\" :..........................................................add manually new sales to database via SalesApp\n")
        println("\t \"update [1/1/21 ~ 1/10/21]\" :.......................................update manually selected sales from database via SalesApp\n")
        println("\t \"remove [filename]\" :...............................................delete selected sales from database automatically via SalesApp\n")
        println("\t \"read [filename]\" :.................................................add automatically new sales to database via SalesApp\n")
        println("\t \"exit\" :............................................................leave SalesApp CLI\n")
        println("\t \"1  [Mastercard/Visa/Diners/Amex]\":.................................average sale price for sales made in the given payment type\n")
        println("\t \"2  [Mastercard/Visa/Diners/Amex]\":.................................overall sale price for sales made in the given payment type\n")
        println("\t \"3  [United States/Canada/United Kingdom/Israel/India]\":............average sale price for sales made in the given country\n")
        println("\t \"4  [United States/Canada/United Kingdom/Israel/India]\":............overall sale price for sales made in the given country\n")
        println("\t \"5  [1/1/21 ~ 1/10/21]\":............................................average sale price for sales made on the given transaction date\n")
        println("\t \"6  [1/1/21 ~ 1/10/21]\":............................................overall sale price for sales made on the given transaction date\n")
        println("----------------------------------------------------------------------------------------------------------------------------------------------")
    }

    def menu(): Unit = {
        printWelcome()
        var continueMenuLoop = true
        while (continueMenuLoop) {
            printOptions()
            val input = readLine()
            input match {
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("0") => {
                    println("----------------------------------------------------------------------------------------------------------")
                    printAllSales()
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("paydates") => {
                    println("----------------------------------------------------------------------------------------------------------")
                    printAllSalesDate()
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("countries") => {
                    println("----------------------------------------------------------------------------------------------------------")
                    printAllSalesCountry()
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("paytypes") => {
                    println("----------------------------------------------------------------------------------------------------------")
                    printAllSalesPaymentType()
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("1") => {
                    println(s"\t..........average price for sales made in [${arg}]: ${printSalesPayType4AvgPrice(arg)}.............................")
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("2") => {
                    val (salesNumber, totalPrices) = printSalesPayType4AllPrice(arg)
                    println(s"\t..........overall price for ${salesNumber} sales made in [${arg}]: ${totalPrices}..................................")
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("3") => {
                    println(s"\t..........average price for sales made in [${arg}]: ${printSalesCountry4AvgPrice(arg)}.............................")
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("4") => {
                    val (salesNumber, totalPrices) = printSalesCountry4AllPrice(arg)
                    println(s"\t..........overall price for ${salesNumber} sales made in [${arg}]: ${totalPrices}..................................")
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("5") => {
                    println(s"\t..........average price for sales made on [${arg}]: ${printSalesDate4AvgPrice(arg)}................................")
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("6") => {
                    val (salesNumber, totalPrices) = printSalesDate4AllPrice(arg)
                    println(s"\t..........overall price for ${salesNumber} sales made on [${arg}]: ${totalPrices}..................................")
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("insert") => {
                    runAddSalesSubMenu()
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("update") => {
                    runUpdateSalesSubMenu(arg)
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("read") => {
                    runReadSalesData(arg)
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("remove") => {
                    runRemoveSalesData(arg)
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("exit") => {
                    continueMenuLoop = false
                }
                case commandArgPattern(cmd, arg) => {
                    println(s"Failed to parse command: [${cmd}] with arguments: [${arg}] \n")
                }
                case _ => {
                    println("Failed to parse any input\n")
                }
            }
        }
        println()
        println("\t Thank you for using SalesApp. Welcom back!")
    }

    def printAllSales(): Unit = {
        SalesDao.getAll().foreach(println)
    }

    def printAllSalesDate(): Unit = {
        val rows = ArrayBuffer[String]()
        for (line <- SalesDao.getAll().map(_.payDate)) {
            val part = line.split("/").map(_.trim)
            val segs = part(2).split(" ")
            rows += part(0)+"/"+part(1)+"/"+segs(0)
        }
        rows.toSet.foreach(println)
        println(s"\t\t\t size: ${rows.toSet.size}")
    }

    def printAllSalesCountry(): Unit = {
        SalesDao.getAll().map(_.country).toSet.foreach(println)
        println(s"\t\t\t size: ${SalesDao.getAll().map(_.country).toSet.size}")
    }

    def printAllSalesPaymentType(): Unit = {
        SalesDao.getAll().map(_.payType).toSet.foreach(println)
        println(s"\t\t\t size: ${SalesDao.getAll().map(_.payType).toSet.size}")
    }

    def printSalesPayType4AvgPrice(payType: String): Double = {
        SalesDao.getPayType(payType).map(_.price.toInt).sum / SalesDao.getPayType(payType).size
    }

    def printSalesCountry4AvgPrice(country: String): Double = {
        SalesDao.getCountry(country).map(_.price.toInt).sum / SalesDao.getCountry(country).size
    }

    def printSalesDate4AvgPrice(payDate: String): Double = {
        var c : Int = 0
        var p : Int = 0
        for (sale <- SalesDao.getAll()) {
            val parts = sale.payDate.split("/").map(_.trim)
            val segs = parts(2).split(" ")
            if (payDate == parts(0)+"/"+parts(1)+"/"+segs(0)) {
                c += 1
                p += sale.price.toInt
            }
        }
        p/c
    }

    def printSalesPayType4AllPrice(payType: String): (Int, Int) = {
        val filtered = SalesDao.getAll().filter(_.payType == payType)
        (filtered.size, filtered.map(_.price.toInt).sum)
    }

    def printSalesCountry4AllPrice(country: String): (Int, Int) = {
        val filtered = SalesDao.getAll().filter(_.country == country)
        (filtered.size, filtered.map(_.price.toInt).sum)
    }

    def printSalesDate4AllPrice(payDate: String): (Int, Int) = {
        var c : Int = 0
        var p : Int = 0
        for (sale <- SalesDao.getAll()) {
            val parts = sale.payDate.split("/").map(_.trim)
            val segs = parts(2).split(" ")
            if (payDate == parts(0)+"/"+parts(1)+"/"+segs(0)) {
                c += 1
                p += sale.price.toInt
            }
        }
        (c, p)
    }

    /**
    * runs an add sales sub menu, we're skipping some QoL features present on the main menu
    */
    def runAddSalesSubMenu(): Unit = {
        println("transaction date? [1/1/09 ~ 1/10/09 or 1/1/21 ~ 1/10/21]")
        val dateInput = readLine()
        println("product? [Product1/Product2]")
        val productInput = readLine()
        println("price? [1200/3600]")
        val priceInput = readLine()
        println("payment type? [Mastercard/Visa/Diners/Amex]")
        val payTypeInput = readLine()
        println("country? [United States/Canada/United Kingdom/Israel/India]")
        val countryInput = readLine()
        try {
        if (SalesDao.saveNew(Sales(0, dateInput, productInput, priceInput, payTypeInput, countryInput))) {
            println("added new sales!")
        } 
    } catch {
      case e : Exception => {
        println("failed to add sales.")
      }
    }
  }

    def runUpdateSalesSubMenu(payDate: String): Unit = {
        var id : Int = -1
        for (sale <- SalesDao.getAll()) {
            val parts = sale.payDate.split("/").map(_.trim)
            val segs = parts(2).split(" ")
            if (payDate == parts(0)+"/"+parts(1)+"/"+segs(0)) {
                id = sale.saleId 
                println(sale)
            }
        }

        println("sales id?")
        val sid = readLine()
        println("time?")
        val time = readLine()
        println("product? [Product1/Product2]")
        val productInput = readLine()
        println("price? [1200/3600]")
        val priceInput = readLine()
        println("payment type? [Mastercard/Visa/Diners/Amex]")
        val payTypeInput = readLine()
        println("country? [United States/Canada/United Kingdom/Israel/India]")
        val countryInput = readLine()
        try {
            println(s"\t\t updating:..........${sid.toInt}, ${time}, ${productInput}, ${priceInput}, ${payTypeInput}, ${countryInput}...........\n")
            if (SalesDao.updateOld(Sales(sid.toInt, time, productInput, priceInput, payTypeInput, countryInput))) {
                println("updated existing sales!")
            } 
        } catch {
            case e : Exception => {
                println("\nfailed to add sales.")
            }
        }
    }

    def runReadSalesData(filename : String): Unit = {
        var counter : Int = SalesDao.getAll().size
        var openedFile : BufferedSource = null 
        val rows = ArrayBuffer[Array[String]]()
        try {
            openedFile = Source.fromFile(filename)
            for (line <- openedFile.getLines.drop(1)) {
                rows += line.split(",").map(_.trim)
                counter += 1
            }
            for (row <- rows) {
                println(s"\t\t adding:..........${row(1)}, ${row(2)}, ${row(3)}, ${row(4)}, ${row(5)}..........\n")
                if (SalesDao.saveNew(Sales(counter, row(1), row(2), row(3), row(4), row(5)))) {
                     println("\t\t added new sales!")
                }
            }
        } catch {
            case e : Exception => {
                println("failed to add sales.")
            }
        } finally {
            if (openedFile != null) {
                openedFile.close()
            }
        }
    }  

    def runRemoveSalesData(filename : String): Unit = {
        var counter : Int = SalesDao.getAll().size
        var openedFile : BufferedSource = null 
        val rows = ArrayBuffer[Array[String]]()
        try {
            openedFile = Source.fromFile(filename)
            for (line <- openedFile.getLines.drop(1)) {
                rows += line.split(",").map(_.trim)
                counter -= 1
            }
            for (row <- rows) {
                println(s"\t\t deleting:..........${row(1)}, ${row(2)}, ${row(3)}, ${row(4)}, ${row(5)}..........\n")
                if (SalesDao.deleteOld(Sales(counter, row(1), row(2), row(3), row(4), row(5)))) {
                     println("\t\t deleted existing sales!")
                }
            }
        } catch {
            case e : Exception => {
                println("failed to delete sales.")
            }
        } finally {
            if (openedFile != null) {
                openedFile.close()
            }
        }
    }  

}