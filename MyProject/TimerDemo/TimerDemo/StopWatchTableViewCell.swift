//
//  StopWatchTableViewCell.swift
//  TimerDemo
//
//  Created by Seonghoon Lee on 1/24/25.
//

import Foundation
import UIKit

class StopWatchViewController: UIViewController {
    
    // MARK: - Properties
    private let mainStopwatch: Stopwatch = Stopwatch()
    private let lapStopwatch: Stopwatch = Stopwatch()
    private var isPlay: Bool = false
    private var lapTableviewData: [String] = []
    private var diffTableViewData: [String] = []
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var stopWatchTableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lapTimeLabel: UILabel!
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var startPauseButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lapResetButton.isEnabled = false
        
        stopWatchTableView.register(StopWatchTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.stopWatchTableViewCell)
        
        stopWatchTableView.delegate = self
        stopWatchTableView.dataSource = self
        
        
    }
    
    // MARK: - @IBAction Properties
    @IBAction func lapResetTime(_ sender: Any) {
        
        // 시간이 멈추어져 있을 때 (버튼은 Reset으로 클릭 가능하도록 표출) -> 상황은 Reset을 눌렀을 때의 코드임
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(lapResetButton, title: "Lap", titleColor: UIColor.lightGray)
            lapResetButton.isEnabled = false
        }
        
        // 시간이 가고 있을 때 (버튼은 Lap으로 클릭 가능하도록 표출) -> 상황은 Lap을 눌렀을 때의 코드임
        else {
            if let timerLabelText = timeLabel.text {
                lapTableviewData.append(timerLabelText)
            }
            if let diffLabelText = lapTimeLabel.text {
                diffTableViewData.append(diffLabelText)
            }
            
            stopWatchTableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
        }
    }
    
    @IBAction func startPauseTime(_ sender: Any) {
        lapResetButton.isEnabled = true
        changeButton(lapResetButton, title: "Lap", titleColor: UIColor.black)
        
        // 시간이 멈추어져 있을 때 (버튼은 Start로 표출) -> 상황은 Start를 눌렀을 때의 코드임
        if !isPlay {
            unowned let weakSelf = self
            
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
            RunLoop.current.add(mainStopwatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            
            isPlay = true
            changeButton(startPauseButton, title: "Stop", titleColor: UIColor.red)
        }
        
        // 시간이 가고 있을 때 (버튼은 Stop으로 표출) -> 상황은 Stop을 눌렀을 때의 코드임
        else {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(startPauseButton, title: "Start", titleColor: UIColor.green)
            changeButton(lapResetButton, title: "Reset", titleColor: UIColor.black)
        }
    }
}

// MARK: - Action Functions
extension StopWatchViewController {
    
    func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    func resetMainTimer() {
        resetTimer(mainStopwatch, label: timeLabel)
        lapTableviewData.removeAll()
        stopWatchTableView.reloadData()
    }
    
    func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimeLabel)
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: timeLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimeLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.01
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
    }
}

// MARK: - TableView Delegate
extension StopWatchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let copyMenuInteraction = UIEditMenuInteraction(delegate: self)
        tableView.addInteraction(copyMenuInteraction)
        
        let configuration = UIEditMenuConfiguration(identifier: nil, sourcePoint: tableView.accessibilityActivationPoint)
        copyMenuInteraction.presentEditMenu(with: configuration)
    }
}

// MARK: - TableView DataSource
extension StopWatchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTableviewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let timeCell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.stopWatchTableViewCell, for: indexPath) as? StopWatchTableViewCell else { return UITableViewCell() }
        
        let lap = lapTableviewData.count - (indexPath as NSIndexPath).row
        
        // Lap 순위
        if let lapLabel = timeCell.lapLabel {
            lapLabel.text = "Lap \(lap)"
        }
        
        // 실제 기록
        if let recordLabel = timeCell.recordLabel {
            recordLabel.text = "\(lapTableviewData[lap-1])"
        }
        
        // 앞선 기록과의 차이
        if let diffLabel = timeCell.diffLabel {
            diffLabel.text = "\(diffTableViewData[lap-1])"
        }
        return timeCell
    }
}

// MARK: - UIEditMenuInteraction Delegate
extension StopWatchViewController: UIEditMenuInteractionDelegate {
    func editMenuInteraction(_ interaction: UIEditMenuInteraction, menuFor configuration: UIEditMenuConfiguration, suggestedActions: [UIMenuElement]) -> UIMenu? {
        let copyAction = UIAction(title: "기록 복사하기") {_ in
            var copyBoard: [String] = []
            
            for indexNum in 0...self.lapTableviewData.count-1 {
                copyBoard.append("\(indexNum+1)   \(self.lapTableviewData[indexNum])   \(self.diffTableViewData[indexNum])")
            }
            UIPasteboard.general.strings = copyBoard
        }
        return UIMenu(children: [copyAction])
    }
}

// MARK: - Selector Extension
fileprivate extension Selector {
    static let updateMainTimer = #selector(StopWatchViewController.updateMainTimer)
    static let updateLapTimer = #selector(StopWatchViewController.updateLapTimer)
}
