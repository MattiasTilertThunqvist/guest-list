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
    
    @IBOutlet private weak var attendingStackView: UIStackView!
    @IBOutlet private weak var attendingLabel: UILabel!
    @IBOutlet private weak var attendingNrLabel: UILabel!
    
    @IBOutlet private weak var declinedStackView: UIStackView!
    @IBOutlet private weak var declinedLabel: UILabel!
    @IBOutlet private weak var declinedNrLabel: UILabel!
    
    @IBOutlet private weak var noResponseStackView: UIStackView!
    @IBOutlet private weak var noResponseLabel: UILabel!
    @IBOutlet private weak var noResponseNrLabel: UILabel!
    
    @IBOutlet private weak var maybeStackView: UIStackView!
    @IBOutlet private weak var maybeLabel: UILabel!
    @IBOutlet private weak var maybeNrLabel: UILabel!
    
    @IBOutlet private weak var nrTotalGuestsLabel: UILabel!
    
    @IBOutlet private weak var invitationSentButton: UIButton!
    @IBOutlet private weak var thankYousSentButton: UIButton!
    
    // MARK: IBActions
    
    @IBAction private func didTapInvitationSentButton(_ sender: UIButton) {
        displayRSVPDetailsVC(ofType: .inviteNotSent)
    }
    
    @IBAction private func didTapThankYousSentButton(_ sender: UIButton) {
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
        attendingStackView.layer.addBorder(edge: .right, color: .weddingVeryLightGray, thickness: 1)
        noResponseStackView.layer.addBorder(edge: .right, color: .weddingVeryLightGray, thickness: 1)
    }

    private func setup() {
        attendingLabel.font = .weddingRegularFont(textSize: .small)
        attendingNrLabel.font = .weddingRegularFont(35)
        declinedLabel.font = .weddingRegularFont(textSize: .small)
        declinedNrLabel.font = .weddingRegularFont(35)
        noResponseLabel.font = .weddingRegularFont(textSize: .small)
        noResponseNrLabel.font = .weddingRegularFont(35)
        maybeLabel.font = .weddingRegularFont(textSize: .small)
        maybeNrLabel.font = .weddingRegularFont(35)
        nrTotalGuestsLabel.font = .weddingRegularFont(textSize: .small)
        invitationSentButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        thankYousSentButton.titleLabel?.font = .weddingRegularFont(textSize: .medium)
        
        setContent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(guestListDidChange), name: .GuestListDidChange, object: nil)
    }
    
    private func setContent() {
        attendingNrLabel.text = "\(GuestList.shared.countAcceptedRsvps())"
        declinedNrLabel.text = "\(GuestList.shared.countDeclingedRsvps())"
        noResponseNrLabel.text = "\(GuestList.shared.countNoResponsRsvps())"
        maybeNrLabel.text = "\(GuestList.shared.countMaybeRsvps())"
        nrTotalGuestsLabel.text = "\(GuestList.shared.countGuests()) TOTAL GUESTS"
        
        
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
