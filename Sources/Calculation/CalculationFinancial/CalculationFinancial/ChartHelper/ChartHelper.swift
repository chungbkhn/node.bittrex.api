//
//  ChartHelper.swift
//  CalculationFinancial
//
//  Created by David on 10/22/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

import Charts

struct ChartHelper {

	static func drawChainGroupChart(money: Double, numberOfDays: Int, barChart: BarChartView) {
		let builder = ChainGroupInvestmentBuilder()
		builder.makeInvestment(money: money, numberOfDays: numberOfDays)
		let investment = builder.outputObject()

		drawChart(investment: investment, barChart: barChart)
	}

	static func drawBitconnectChart(money: Double, numberOfDays: Int, barChart: BarChartView) {
		let builder = BitconnectInvestmentBuilder()
		builder.makeInvestment(money: money, numberOfDays: numberOfDays)
		let investment = builder.outputObject()

		drawChart(investment: investment, barChart: barChart)
	}

	static func drawRegalChart(money: Double, numberOfDays: Int, barChart: BarChartView) {
		let builder = RegalInvestmentBuilder()
		builder.makeInvestment(money: money, numberOfDays: numberOfDays)
		let investment = builder.outputObject()

		drawChart(investment: investment, barChart: barChart)
	}
}

extension ChartHelper {

	fileprivate static func drawChart<T: Investment>(investment: T, barChart: BarChartView) {
		var maxMoney = Double(0)
		var totalDayReInvest = 1
		var invitationEarned: Double = 0
		var values = [BarChartDataEntry]()

		for i in 1 ... (investment.totalStep - 1) {
			let money = investment.moneyEarned(reinvestIn: i)
			values.append(BarChartDataEntry(x: Double(i), y: money.total))
			if money.total > maxMoney {
				maxMoney = money.total
				totalDayReInvest = i
				invitationEarned = money.invitation
			}
		}

		let dateFormat = DateFormatter()
		dateFormat.dateFormat = "dd/MM/yyyy"
		dateFormat.timeZone = TimeZone(secondsFromGMT: 7)
		let startDate = dateFormat.date(from: "21/09/2017")!
		print("Start Date: \(startDate)")

		let endDayInvestment = Util.date(after: totalDayReInvest, referenceDate: startDate)
		let message = "Start Money: \(investment.startMoneyInvest)\nNumber of Day reinvest: \(totalDayReInvest)\nMax money return: \(maxMoney)\nMoney invitation earned: \(invitationEarned)\nEnd Day Investment: \(endDayInvestment)"
		print(message)

		let dataSet = BarChartDataSet(values: values, label: "Chain Group Investment")
		let data = BarChartData(dataSets: [dataSet])
		barChart.data = data
		barChart.chartDescription?.text = message

		//All other additions to this function will go here

		//This must stay at end of function
		barChart.notifyDataSetChanged()
	}
}
