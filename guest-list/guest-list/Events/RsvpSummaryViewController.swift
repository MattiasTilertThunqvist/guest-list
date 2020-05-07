//
//  RVSPSummaryViewController.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-21.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class RsvpSummaryViewController: UIViewController {
    
    // MARK: Properties
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var attendingStackView: UIStackView!
    @IBOutlet weak var attendingLabel: UILabel!
    @IBOutlet weak var attendingNrLabel: UILabel!
    
    @IBOutlet weak var noResponseStackView: UIStackView!
    @IBOutlet weak var noResponseLabel: UILabel!
    @IBOutlet weak var noResponseNrLabel: UILabel!
    
    @IBOutlet weak var declinedStackView: UIStackView!
    @IBOutlet weak var declinedLabel: UILabel!
    @IBOutlet weak var declinedNrLabel: UILabel!
    
    @IBOutlet weak var nrTotalGuestsLabel: UILabel!
    
    @IBOutlet weak var invitationSentButton: UIButton!
    @IBOutlet weak var thankYousSentButton: UIButton!
    
    // MARK: IBActions
    
    @IBAction func didTapInvitationSentButton(_ sender: UIButton) {
        displayRSVPDetailsVC(ofType: .inviteNotSent)
    }
    
    @IBAction func didTapThankYousSentButton(_ sender: UIButton) {
        displayRSVPDetailsVC(ofType: .thankYouNotSent)
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        noResponseStackView.layer.addBorder(edge: .left, color: .weddingVeryLightGray, thickness: 1)
        noResponseStackView.layer.addBorder(edge: .right, color: .weddingVeryLightGray, thickness: 1)
    }

    private func setup() {
        attendingLabel.font = .weddingRegularFont(textSize: .small)
        attendingNrLabel.font = .weddingRegularFont(35)
        noResponseLabel.font = .weddingRegularFont(textSize: .small)
        noResponseNrLabel.font = .weddingRegularFont(35)
        declinedLabel.font = .weddingRegularFont(textSize: .small)
        declinedNrLabel.font = .weddingRegularFont(35)
        nrTotalGuestsLabel.font = .weddingRegularFont(textSize: .small)
        invitationSentButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        thankYousSentButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        
        setContent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(guestListDidChange), name: .GuestListDidChange, object: nil)
    }
    
    private func setContent() {
        attendingNrLabel.text = String(GuestList.shared.countAcceptedRsvps())
        noResponseNrLabel.text = String(GuestList.shared.countNoResponsRsvps())
        declinedNrLabel.text = String(GuestList.shared.countDeclingedRsvps())
        nrTotalGuestsLabel.text = String(GuestList.shared.countGuests())
    }
    
    // MARK: Helpers
    
    @objc private func guestListDidChange() {
        setContent()
    }
    
    private func displayRSVPDetailsVC(ofType contentType: ContentType) {
        let viewController = StoryboardInstance.RSVPDetailsViewController()
        viewController.contentMode = contentType
        navigationController?.pushViewController(viewController, animated: true)
    }
}
