package com.cjen.salescomputer

import scala.io.StdIn.readLine
import scala.util.matching.Regex
import java.io.FileNotFoundException
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Map

class SalesCLI {

    val commandArgPattern : Regex = "(\\w+)\\s*(.*)".r

    def printWelcome(): Unit = {
        println()
        println("-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-MAIN-*-*-MENU-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
        println("\t Hello! Welcome to Sales Statistics Computer!")
        println("please follow instructions by typing commands as suggested below")
        println("-------------------------------------------------------------------------------------")
    }

    def printOptions(): Unit = {
        println()
        println("Main Menu Page:")
        println("\t \"scan sales\" ")
        println("\t \"enter computer\" ")
        println("\t \"exit computer\" ")
        println("-------------------------------------------------------------------------------------")
    }

    def salesOptions(): Unit = {
        println("-------------------------------------------------------------------------------------")
        println("Sales Statistics Computing Options:")
        println("\t [1] average sale price for all sales made using one given payment type")
        println("\t [2] number of sales made in one given month/day")
        println("\t [3] number of sales made in USA only and total price of these sales")
        println("\t [4] number of sales made outside USA and total price of these sales")
        println()
        println("please follow instructions by typing commands as suggested below")
    }    

    def enterOptions(): Unit = {
        println("-------------------------------------------------------------------------------------")
        println("\t \"1 [filename]\" ")
        println("\t \"2 [filename]\" ")
        println("\t \"3 [filename]\" ")
        println("\t \"4 [filename]\" ")
        println("\t \"exit\" ")
    }

    def menu(): Unit = {
        printWelcome()
        var continueMenuLoop = true
        while (continueMenuLoop) {
            printOptions()
            val input = readLine()
            input match {
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("scan") => {
                    println("plese enter \"show [filename]\"; otherwise, \"exit\" ")
                    val salesData = readLine()
                    salesData match {
                        case commandArgPattern(scmd, sarg) if scmd.equalsIgnoreCase("show") => {
                            scanSalesContent(sarg)
                        }
                        case commandArgPattern(scmd, sarg) if scmd.equalsIgnoreCase("exit") => {
                            continueMenuLoop = false
                        }
                    }
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("enter") => {
                    salesOptions()
                    enterOptions()
                    val sales = readLine()
                    sales match {
                        case commandArgPattern(scmd, sarg) if scmd.equalsIgnoreCase("1") => {
                            getAvgSalePrice4Pay(sarg)
                        }
                        case commandArgPattern(scmd, sarg) if scmd.equalsIgnoreCase("2") => {
                            getTotSaleNumber4Day(sarg)
                        }
                        case commandArgPattern(scmd, sarg) if scmd.equalsIgnoreCase("3") => {
                            getAvgSalePrice4USA(sarg)
                        }
                        case commandArgPattern(scmd, sarg) if scmd.equalsIgnoreCase("4") => {
                            getAvgSalePrice4Others(sarg)
                        }
                        case commandArgPattern(scmd, sarg) if scmd.equalsIgnoreCase("exit") => {
                            continueMenuLoop = false
                        }
                    }
                }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("exit") => {
                    continueMenuLoop = false
                }
                case _ => {
                    println("Failed to parse any input")
                }
            }
        }
        println("Thank you for using Sales Statistics Computer. Goodbye!")
    }

    def scanSalesContent(sarg: String) = { 
        try {
            println("-------------------------------------------------------------------------------------")
            println("plese enter a postive integer to display number of rows/lines below!")
            println("\t if \"0\", that means showing *ALL* DATA here!")
            val nlines = readLine()
            val sdr = new SalesReadDemo()
            sdr.readSales(sarg, nlines)
            } catch {
                case fnfe: FileNotFoundException => {
                    println(s"Failed to find file: ${fnfe.getMessage}")
            }
        }
    }

    /**
    *
    * a [[Map]] where the key is a payment type and the value is the
    * average sale price for all sales made using that payment type.
    *
    * @return The map with the data grouped by payment type.
    *
    */
    def getAvgSalePrice4Pay(sarg: String) = { // 01/13/2021
        try {
            var continueMenuLoop = true
            while (continueMenuLoop) {
                var findmatch = false 
                val salesReader = new SalesCSVReader(sarg)
                val sales = salesReader.readSales
                val statistics = new SalesStatisticsComputer(salesReader)
                println("-----------------------------------------------------------------------------------------------------------------------------------------")
                println("Hello! You're now in \"Get Average Price for Sales Paid by One Given Payment Type!\" ")
                println(s"before using sales statistics computer, do you want to display *ALL* (${statistics.getTotalNumberOfSales()} lines in total) DATA? [Y/N] ")
                println("-----------------------------------------------------------------------------------------------------------------------------------------")
                val show = readLine()
                show match {
                    case "Y" | "y" => {
                        val sdr = new SalesReadDemo()
                        sdr.readSales(sarg, "0")
                        println()
                        println("\t Alright~ Let's move onto the next step!") 
                        println()
                        println("\t-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-YOUR-*-*-COMPUTER-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
                        println()
                        val allPayTys = statistics.pay(sales)
                        val avgPrices = statistics.avg(sales)
                        val avgPayTys = statistics.getAvgSalePricesGroupedByPaymentType()
                        println(s"\t list all payment types...........................................................${allPayTys}\n")
                        println(s"\t get average sales price over all payment types...................................${avgPrices}\n")
                        println("\t which payment type would you like to get its average sale price?")
                        println(s"\t select one from ${allPayTys}\n")
                        val ptype = readLine() 
                        for (paytype <- allPayTys) {
                            if (ptype == paytype) {
                                findmatch = true
                                println(s"\t average sales price for [ ${ptype} ] is................................................${avgPayTys(ptype)}")
                            }
                        }
                        if (findmatch == false) {
                            println("\t sorry, we couldn't find the payment type you selected. Re-select? \n")
                            val resel = readLine()
                            resel match {
                                case "Y" | "y" => continueMenuLoop = true
                                case "N" | "n" => continueMenuLoop = false
                            }
                        }
                        else continueMenuLoop = false
                    }
                    case "N" | "n" => {
                        println()
                        println("Alright~ Let's move onto the next step!")
                        println()
                        println("\t-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-YOUR-*-*-COMPUTER-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
                        println()
                        val allPayTys = statistics.pay(sales)
                        val avgPrices = statistics.avg(sales)
                        val avgPayTys = statistics.getAvgSalePricesGroupedByPaymentType()
                        println(s"\t list all payment types...........................................................${allPayTys}\n")
                        println(s"\t get average sales price over all payment types...................................${avgPrices}\n")
                        println("\t which payment type would you like to get its average sale price?")
                        println(s"\t select one from ${allPayTys}\n")
                        val ptype = readLine()
                        for (paytype <- allPayTys) {
                            if (ptype == paytype) {
                                findmatch = true
                                println(s"\t average sales price for [ ${ptype} ] is................................................${avgPayTys(ptype)}")
                            }
                        }
                        if (findmatch == false) {
                            println("\t sorry, we couldn't find the payment type you selected. Re-select? \n")
                            val resel = readLine()
                            resel match {
                                case "Y" | "y" => continueMenuLoop = true
                                case "N" | "n" => continueMenuLoop = false
                            }
                        }
                        else continueMenuLoop = false
                    }
                    case _ => {
                        println("Failed to parse any input")
                        println("-------------------------------------------------------------------------------------")
                        continueMenuLoop = false
                    }
                }
            } 
        } catch {
            case fnfe: FileNotFoundException => {
                println(s"Failed to find file: ${fnfe.getMessage}")
            }
        }
    }

    /**
    *
    * Creates and returns a [[Map]] where the key is a given day in the format month/day
    * and the value is the number of sales made in the day.
    *
    * @return The map with the data grouped by day.
    *
    */
    def getTotSaleNumber4Day(sarg: String) = { // 01/14/2021
        try {
            val salesReader = new SalesCSVReader(sarg)
            val sales = salesReader.readSales
            val statistics = new SalesStatisticsComputer(salesReader)
            println("-----------------------------------------------------------------------------------------------------------------------------------------")
            println("Hello! You're now in \"Get Total Number of Sales for One Given Date [month/day]!\" ")
            println(s"before using sales statistics computer, do you want to display *ALL* (${statistics.getTotalNumberOfSales()} lines in total) DATA? [Y/N] ")
            println("-----------------------------------------------------------------------------------------------------------------------------------------")
            val show = readLine()
            show match {
                case "Y" | "y" => {
                    val sdr = new SalesReadDemo()
                    sdr.readSales(sarg, "0")
                    println()
                    println("\t Alright~ Let's move onto the next step!") 
                    println()
                    println("\t-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-YOUR-*-*-COMPUTER-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
                    println()
                    val allPayDay = statistics.getNumberOfSalesGroupedByDay()
                    allPayDay.toSeq
                             .sortWith(_._2 > _._2) 
                             .foreach({ case (date, salegoods) => println(s"\t...........................On ${date}, total sales are ${salegoods}!...........................\n") })
                }
                case "N" | "n" => {
                    println()
                    println("Alright~ Let's move onto the next step!")
                    println()
                    println("\t-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-YOUR-*-*-COMPUTER-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
                    println()
                    val allPayDay = statistics.getNumberOfSalesGroupedByDay()
                    allPayDay.toSeq
                             .sortWith(_._2 > _._2)
                             .foreach({ case (date, salegoods) => println(s"\t...........................On ${date}, total sales are ${salegoods}!...........................\n") })
                }
                case _ => {
                    println("Failed to parse any input")
                    println("-------------------------------------------------------------------------------------")
                }
            }
        } catch {
                case fnfe: FileNotFoundException => {
                    println(s"Failed to find file: ${fnfe.getMessage}")
            }
        }
    }

    /**
    *
    * @return A tuple where the first value is the number of sales made in USA only and
    *         the second value is the total price of these sales.
    *
    */
    def getAvgSalePrice4USA(sarg: String) = { // 01/15/2021
        try {
            val salesReader = new SalesCSVReader(sarg)
            val sales = salesReader.readSales
            val statistics = new SalesStatisticsComputer(salesReader)
            println("-----------------------------------------------------------------------------------------------------------------------------------------")
            println("Hello! You're now in \"Get Total Prices for Sales Made in USA!\" ")
            println(s"before using sales statistics computer, do you want to display *ALL* (${statistics.getTotalNumberOfSales()} lines in total) DATA? [Y/N] ")
            println("-----------------------------------------------------------------------------------------------------------------------------------------")
            val show = readLine()
            show match {
                case "Y" | "y" => {
                    val sdr = new SalesReadDemo()
                    sdr.readSales(sarg, "0")
                    println()
                    println("\t Alright~ Let's move onto the next step!") 
                    println()
                    println("\t-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-YOUR-*-*-COMPUTER-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
                    println()
                    val (salesNumber, totalPrices) = statistics.getTotalNumberAndPriceOfSalesMadeInUSA()
                    println(s"\t......................total value for ${salesNumber} sales made in USA is ${totalPrices}!.......................")
                }
                case "N" | "n" => {
                    println()
                    println("Alright~ Let's move onto the next step!")
                    println()
                    println("\t-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-YOUR-*-*-COMPUTER-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
                    println()
                    val (salesNumber, totalPrices) = statistics.getTotalNumberAndPriceOfSalesMadeInUSA()
                    println(s"\t......................total value for ${salesNumber} sales made in USA is ${totalPrices}!.......................")
                }
                case _ => {
                    println("Failed to parse any input")
                    println("-------------------------------------------------------------------------------------")
                }
            }
        } catch {
            case fnfe: FileNotFoundException => {
                    println(s"Failed to find file: ${fnfe.getMessage}")
            }
        }
    }

    /**
    *
    * @return A tuple where the first value is the number of sales made out of USA and
    *         the second value is the total price of these sales.
    *
    */
    def getAvgSalePrice4Others(sarg: String) = { // 01/16/2021
        try {
            val salesReader = new SalesCSVReader(sarg)
            val sales = salesReader.readSales
            val statistics = new SalesStatisticsComputer(salesReader)
            println("-----------------------------------------------------------------------------------------------------------------------------------------")
            println("Hello! You're now in \"Get Total Price for Sales Made Outside USA!\" ")
            println(s"before using sales statistics computer, do you want to display *ALL* (${statistics.getTotalNumberOfSales()} lines in total) DATA? [Y/N] ")
            println("-----------------------------------------------------------------------------------------------------------------------------------------")
            val show = readLine()
            show match {
                case "Y" | "y" => {
                    val sdr = new SalesReadDemo()
                    sdr.readSales(sarg, "0")
                    println()
                    println("\t Alright~ Let's move onto the next step!") 
                    println()
                    println("\t-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-YOUR-*-*-COMPUTER-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
                    println()
                    val (salesNumber, totalPrices) = statistics.getTotalNumberAndPriceOfSalesMadeAbroad()
                    println(s"\t...................total value for ${salesNumber} sales made outside USA is ${totalPrices}!....................")
                }
                case "N" | "n" => {
                    println()
                    println("Alright~ Let's move onto the next step!")
                    println()
                    println("\t-*-*-*-*-*-*-*-*-*-*-*-*-*-*-I-*-*-AM-*-*-*-YOUR-*-*-COMPUTER-*-*-*-*-*-*-*-*-*-*-*-*-*-*-")
                    println()
                    val (salesNumber, totalPrices) = statistics.getTotalNumberAndPriceOfSalesMadeAbroad()
                    println(s"\t...................total value for ${salesNumber} sales made outside USA is ${totalPrices}!...................")
                }
                case _ => {
                    println("Failed to parse any input")
                    println("-------------------------------------------------------------------------------------")
                }
            }
        } catch {
            case fnfe: FileNotFoundException => {
                println(s"Failed to find file: ${fnfe.getMessage}")
            }
        }
    }

}