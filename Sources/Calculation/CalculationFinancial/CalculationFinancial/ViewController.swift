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
        let chainGroup = ChainGroup()
        chainGroup.moneyInvested = 200
        print("Start calculate for chain group")
        
        var maxMoney = Double(0)
        var totalDayReInvest = 1
        var values = [BarChartDataEntry]()
        
        for i in 1 ... (chainGroup.totalDay - 1) {
            let money = chainGroup.getMoneyForDay(dayInvest: i)
            values.append(BarChartDataEntry(x: Double(i), y: money))
            if money > maxMoney {
                maxMoney = money
                totalDayReInvest = i
            }
        }
        
        print("Start Money: \(chainGroup.moneyInvested)\nNumber of Day reinvest: \(totalDayReInvest)\nMax money return: \(maxMoney)")
        
        let dataSet = BarChartDataSet(values: values, label: "Chain Group Investment")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.chartDescription?.text = "Chain Group Investment by David"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        barChart.notifyDataSetChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

