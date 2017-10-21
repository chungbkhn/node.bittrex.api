//
//  ViewController.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

import Charts

class ViewController: UIViewController {

    @IBOutlet weak var barChart: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        drawChainGroupChart()
    }

	fileprivate func drawChainGroupChart() {
		let builder = ChainGroupInvestmentBuilder()
		builder.makeInvestment(money: 560, numberOfDays: 180)
		let investment = builder.outputObject()

		drawChart(investment: investment)
	}

	fileprivate func drawBitconnectChart() {
		let builder = BitconnectInvestmentBuilder()
		builder.makeInvestment(money: 1190, numberOfDays: 365)
		let investment = builder.outputObject()

		drawChart(investment: investment)
	}

	fileprivate func drawChart<T: Investment>(investment: T) {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
