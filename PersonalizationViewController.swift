
import UIKit

class PersonalizationViewController: UIViewController {
    let roundsSlider = UISlider()
    let durationSlider = UISlider()
    let startButton = UIButton(type: .system)
    let roundsLabel = UILabel()
    let durationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setupUI()
    }

    func setBackground() {
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "background") // Укажите имя изображения
        backgroundImageView.contentMode = .scaleAspectFill
        view.sendSubviewToBack(backgroundImageView)
    }

    func setupUI() {
        roundsLabel.text = "Количество раундов: 5"
        roundsLabel.textColor = .black
        roundsLabel.font = UIFont.systemFont(ofSize: 20)
        roundsLabel.textAlignment = .center

        durationLabel.text = "Длительность раунда: 60 сек"
        durationLabel.textColor = .black
        durationLabel.font = UIFont.systemFont(ofSize: 20)
        durationLabel.textAlignment = .center

        roundsSlider.minimumValue = 1
        roundsSlider.maximumValue = 20
        roundsSlider.value = 5
        roundsSlider.addTarget(self, action: #selector(roundsSliderChanged), for: .valueChanged)

        durationSlider.minimumValue = 10
        durationSlider.maximumValue = 300
        durationSlider.value = 60
        durationSlider.addTarget(self, action: #selector(durationSliderChanged), for: .valueChanged)

        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = .black
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 8
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)

        view.addSubview(roundsLabel)
        view.addSubview(roundsSlider)
        view.addSubview(durationLabel)
        view.addSubview(durationSlider)
        view.addSubview(startButton)

        roundsLabel.translatesAutoresizingMaskIntoConstraints = false
        roundsSlider.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationSlider.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            roundsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),

            roundsSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundsSlider.topAnchor.constraint(equalTo: roundsLabel.bottomAnchor, constant: 20),
            roundsSlider.widthAnchor.constraint(equalToConstant: 300),

            durationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            durationLabel.topAnchor.constraint(equalTo: roundsSlider.bottomAnchor, constant: 40),

            durationSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            durationSlider.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 20),
            durationSlider.widthAnchor.constraint(equalToConstant: 300),

            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: durationSlider.bottomAnchor, constant: 350),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


@objc func roundsSliderChanged() {
        let rounds = Int(round(roundsSlider.value))
        roundsLabel.text = "Количество раундов: \(rounds)"
    }

    @objc func durationSliderChanged() {
        let duration = Int(round(durationSlider.value))
        durationLabel.text = "Длительность раунда: \(duration) сек"
    }

    @objc func startButtonTapped() {
        let timerVC = TimerViewController()
        timerVC.totalRounds = Int(round(roundsSlider.value))
        timerVC.roundDuration = Int(round(durationSlider.value))
        navigationController?.pushViewController(timerVC, animated: true)
    }
}
