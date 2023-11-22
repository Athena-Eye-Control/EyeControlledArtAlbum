import UIKit
import AthenaSDK
import ARKit

// MARK: PhotoSliderViewController

class PhotoSliderViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet var photoSliderView: PhotoSliderView!
    @IBOutlet weak var gestureActivationView: UIImageView!
    
    // MARK: SDK Interface
    var athenaEyeControl: AthenaEyeControl!

    // MARK: View Methods
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification, // UIApplication.didBecomeActiveNotification for swift 4.2+
                                               object: nil)
        // MARK: SDK init
        athenaEyeControl = AthenaEyeControl(sceneView: sceneView, webView: nil)
        athenaEyeControl.delegate = self
        sceneView.isHidden = true

        athenaEyeControl.disableRALDetection(true)
        athenaEyeControl.setGestureInitiationLevel(level: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var images: [UIImage] = []
        for  i in 1...11 {
            images.append(UIImage(named: "img\(i)")!)
        }
        photoSliderView.configure(with: images)
        
    }
    @objc func applicationDidBecomeActive() {
        athenaEyeControl.start()
    }
    
    @objc func applicationWillResignActive() {
        //print("app will resign active")
        athenaEyeControl.pause()
    }

    
}

extension PhotoSliderViewController: AthenaEyeControlDelegate {
    
    func didLookAt(x: CGFloat, y:CGFloat, z: CGFloat, projected: CGPoint) {
        // print("\(x),\(y)")
        
    }
    func readAline(_ readALine: ReadALineData) {
        if readALine.reading {
            print("reading")
        }
        // print("\(readALine.eyeGesture)")
    }
    
    func eyeGesture(_ gesture: Int) {
        print("\(gesture)")
        DispatchQueue.main.async { [self] in
            if(gesture == 1) {
                self.gestureActivationView.isHidden = true
                self.photoSliderView.scroll(direction: 1)
            } else if(gesture == 2){ //look up
                self.photoSliderView.scroll(direction: -1)
                self.gestureActivationView.isHidden = true
            } else if(gesture == 3){
                self.gestureActivationView.isHidden = false
            } else if(gesture == 4){
                self.photoSliderView.scroll(direction: 1)
                self.gestureActivationView.isHidden = true
            } else if(gesture == 5){
                self.gestureActivationView.isHidden = true
                self.photoSliderView.scroll(direction: -1)
            }
            
        }
    }
    
    
    func eyeBlinked(blinked: Bool) {
        print("eye blinked: \(blinked)")
    }
    func faceAnchorDetected(detected: Bool) {
        //print("face detected: \(detected)")
    }
    func dataRateReport(_ rate: Float) {
        //print("data rate: \(rate)")
    }
}
