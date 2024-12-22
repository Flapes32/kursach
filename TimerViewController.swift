import UIKit

class TimerViewController: UIViewController {
    let backgroundImageView = UIImageView()
    let timeLabel = UILabel()
    let roundsLabel = UILabel()
    var timer: Timer?
    var roundDuration: Int = 180 // Значение передается из PersonalizationViewController
    var totalRounds: Int = 12 // Значение передается из PersonalizationViewController
    var currentRound: Int = 1
    var currentTime: Int = 0
    var isPaused: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setBackground()
        setupButtons()
        setupTimeLabel()
        startCountdown()
    }
    
    // Устанавливаем фоновое изображение
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "background") // Замените на вашу картинку
        backgroundImageView.contentMode = .scaleAspectFill
        view.sendSubviewToBack(backgroundImageView)
    }

    // Настроить кнопки
    func setupButtons() {
        let startButton = UIButton(type: .system)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        startButton.backgroundColor = .yellow
        startButton.setTitleColor(.black, for: .normal)
        startButton.layer.cornerRadius = 25
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        let pauseButton = UIButton(type: .system)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        pauseButton.backgroundColor = .yellow
        pauseButton.setTitleColor(.black, for: .normal)
        pauseButton.layer.cornerRadius = 25
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        view.addSubview(pauseButton)
        
        let resetButton = UIButton(type: .system)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        resetButton.backgroundColor = .yellow
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.layer.cornerRadius = 25
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            pauseButton.widthAnchor.constraint(equalToConstant: 200),
            pauseButton.heightAnchor.constraint(equalToConstant: 50),
            
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 20),
            resetButton.widthAnchor.constraint(equalToConstant: 200),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Настроить метки времени
    func setupTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        timeLabel.textColor = .yellow
        view.addSubview(timeLabel)
        
        roundsLabel.translatesAutoresizingMaskIntoConstraints = false
        roundsLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        roundsLabel.textColor = .yellow
        view.addSubview(roundsLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
            roundsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundsLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5)
        ])
    }

    // Обработчики кнопок
    @objc func startButtonTapped() {
        isPaused = false
    }

    @objc func pauseButtonTapped() {
        isPaused = true
    }

    @objc func resetButtonTapped() {
        resetTimer()
    }

    // Логика обратного отсчета
    func startCountdown() {
        currentTime = 3 // Начальный отсчет перед началом раунда
        updateTimeLabel()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.currentTime > 0 {
                self.currentTime -= 1
                self.updateTimeLabel()
            } else {
                self.timer?.invalidate()
                self.startRound()
            }
        }
    }

    // Запуск раунда
    func startRound() {
        currentTime = roundDuration
        updateTimeLabel()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.isPaused { return }
            if self.currentTime > 0 {
                self.currentTime -= 1
                self.updateTimeLabel()
            } else {
                self.timer?.invalidate()
                self.endRound()
            }
        }
    }

    // Завершение раунда
    func endRound() {
        if currentRound < totalRounds {
            currentRound += 1
            roundsLabel.text = "Round \(currentRound)/\(totalRounds)"
            currentTime = 5 // Перерыв 5 секунд
            updateTimeLabel()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                if self.currentTime > 0 {
                    self.currentTime -= 1
                    self.updateTimeLabel()
                } else {
                    self.timer?.invalidate()
                    self.startRound()
                }
            }
        } else {
            resetTimer()
        }
    }

    // Сброс таймера
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        currentRound = 1
        currentTime = 0
        updateTimeLabel()
        roundsLabel.text = "Round \(currentRound)/\(totalRounds)"
    }

    // Обновление времени
    func updateTimeLabel() {
        let minutes = currentTime / 60
        let seconds = currentTime % 60
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
}
