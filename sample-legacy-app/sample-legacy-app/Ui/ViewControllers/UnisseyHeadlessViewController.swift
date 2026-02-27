import AVFoundation
import Combine
import UIKit
import UnisseyHeadlessSdk
import UnisseySdk

class UnisseyHeadlessViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var instructionCardView: UIView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    private let unisseySession: UnisseySession
    private var videoUri: URL?
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var overlayView: OvalOverlayView!
    private var isCameraReady = false
    
    // Loading view
    private lazy var loadingContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()

    private lazy var loadingIndicator: CircularLoadingView = {
        let indicator = CircularLoadingView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()

    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("unissey_loading", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        unisseySession = UnisseySession(acquisitionPreset: .selfieFast)
        super.init(coder: coder)
    }
    
    private func setupLoadingView() {
        loadingContainer.addArrangedSubview(loadingIndicator)
        loadingContainer.addArrangedSubview(loadingLabel)
        view.addSubview(loadingContainer)
        
        NSLayoutConstraint.activate([
            loadingContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 48),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the preview layer
        previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.videoGravity = .resizeAspectFill
        previewView.layer.addSublayer(previewLayer)
        
        // Set up the overlay
        overlayView = OvalOverlayView()
        view.insertSubview(overlayView, belowSubview: instructionCardView)
        
        // Style the card
        instructionCardView.backgroundColor = .systemBackground
        instructionCardView.layer.cornerRadius = 7
        instructionCardView.layer.masksToBounds = true
                
        // Style the label
        instructionsLabel.text = NSLocalizedString("unissey_instruction_position_face_oval", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
        instructionsLabel.textColor = .label
        instructionsLabel.font = .preferredFont(forTextStyle: .body)
        
        // Add the loading view
        setupLoadingView()
        
        if !isCameraReady {
            loadingContainer.isHidden = false
            instructionCardView.isHidden = true
            startButton.isHidden = true
        }
        
        // React to Unissey's events
        unisseySession.cameraEvents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                
                if case let .cameraReady(previewResolution) = event {
                    let faceArea = getFaceAreaInPreview(previewResolution: previewResolution ?? CGSize(width: 720, height: 1280), previewSize: previewLayer.frame.size, previewGravity: previewLayer.videoGravity)
                    overlayView.faceArea = faceArea
                    isCameraReady = true
                    loadingContainer.isHidden = true
                    instructionCardView.isHidden = false
                    startButton.isHidden = false
                }
                
                if case let .videoRecordProgress(progress) = event {
                    overlayView.recordingProgress = CGFloat(progress)
                }
                
                if case let .videoRecordEnded(response) = event {
                    print("Video record ended with file path: '\(response.videoFilePath)'")
                    self.videoUri = response.videoFilePath
                    self.performSegue(withIdentifier: "unisseyHeadlessViewToPlayerView", sender: nil)
                }
            }
            .store(in: &cancellables)
        
        unisseySession.faceDetectionEvents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                
                instructionsLabel.text = switch event.faceDetectionInfo {
                case .noFaceDetected:
                    NSLocalizedString("unissey_instruction_no_face_detected", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                case .tooManyFaces:
                    NSLocalizedString("unissey_instruction_multiple_faces_detected", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                case .faceTooClose:
                    NSLocalizedString("unissey_instruction_get_further_away", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                case .faceTooFar:
                    NSLocalizedString("unissey_instruction_get_closer", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                case .moveLeft:
                    NSLocalizedString("unissey_instruction_move_left", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                case .moveRight:
                    NSLocalizedString("unissey_instruction_move_right", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                case .moveUp:
                    NSLocalizedString("unissey_instruction_move_up", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                case .moveDown:
                    NSLocalizedString("unissey_instruction_move_down", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                case .goodPosition:
                    NSLocalizedString("unissey_instruction_do_not_move", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                @unknown default:
                    NSLocalizedString("unissey_instruction_position_face_oval", bundle: Bundle(for: UnisseyViewModel.self), comment: "")
                }
            }
            .store(in: &cancellables)
        
        
        // Set up the start button
        startButton.setTitle(NSLocalizedString("start_button_title", comment: ""), for: .normal)
        startButton.addAction(UIAction(title: "startButton", handler: { [weak self] _ in
            self?.startButton.isEnabled = false
            self?.unisseySession.startVideoCapture()
        }), for: .touchUpInside)
        
        requestPermissionAndStartCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the frame after layout
        previewLayer.frame = previewView.bounds
        overlayView.frame = previewView.frame
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unisseySession.stopCamera()
        cancellables.forEach { $0.cancel() }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let playerViewController = segue.destination as? VideoPlayerViewController {
            playerViewController.videoUri = videoUri!
            playerViewController.onRestartButtonClick = {
                self.videoUri = nil
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func requestPermissionAndStartCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Already authorized, set up camera
            startCamera()
            
        case .notDetermined:
            // Request permission
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.startCamera()
                    }
                }
            }
            
        case .denied, .restricted:
            // Show alert that camera access is needed
            print("Camera access denied")
            
        @unknown default:
            break
        }
    }
    
    private func startCamera() {
        unisseySession.startCamera()
        unisseySession.bindPreview(previewLayer: previewLayer)
    }
}
