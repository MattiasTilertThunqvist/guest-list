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
    
    @IBOutlet private var nrInvitationSentCircleView: CircleView!
    @IBOutlet private var invitationSentDescriptionLabel: MediumTextLabel!
    @IBOutlet private var InvitationSentTappableLabel: MediumTextLabel!
    
    @IBOutlet var nrThankYousSentCicleView: CircleView!
    @IBOutlet private var thankYousSentDescriptionLabel: MediumTextLabel!
    @IBOutlet private var thankYousSentTappableLabel: MediumTextLabel!
    
    // MARK: IBActions
    
    @IBAction func invitationSentTapGesture(_ sender: UITapGestureRecognizer) {
        displayRsvpDetailsVC(ofType: .inviteNotSent)
    }
    @IBAction func thankYousSentTapGesture(_ sender: UITapGestureRecognizer) {
        displayRsvpDetailsVC(ofType: .thankYouNotSent)
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
    
    override func viewDidAppear(_ animated: Bool) {
        let nrOfGuests = GuestList.shared.countGuests()
        
        let nrInvitationsSent = GuestList.shared.countInvitationsSent()
        nrInvitationSentCircleView.setTitle(to: "\(nrInvitationsSent)")
        nrInvitationSentCircleView.setSubTitle(to: "of \(nrOfGuests)")
        nrInvitationSentCircleView.animate(toValue: GuestList.shared.percentageOfInvitationsSent())
        
        let nrThankYousSent = GuestList.shared.countThankYousSent()
        nrThankYousSentCicleView.setTitle(to: "\(nrThankYousSent)")
        nrThankYousSentCicleView.setSubTitle(to: "of \(nrOfGuests)")
        nrThankYousSentCicleView.animate(toValue: GuestList.shared.percentageOfThankYousSent())
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
        
        InvitationSentTappableLabel.textColor = .weddingGold
        
        thankYousSentTappableLabel.textColor = .weddingGold
        
        setContent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(guestListDidChange), name: .GuestListDidChange, object: nil)
    }
    
    private func setContent() {
        let nrOfGuests = GuestList.shared.countGuests()
        attendingNrLabel.text = "\(GuestList.shared.countAcceptedRsvps())"
        declinedNrLabel.text = "\(GuestList.shared.countDeclingedRsvps())"
        noResponseNrLabel.text = "\(GuestList.shared.countNoResponsRsvps())"
        maybeNrLabel.text = "\(GuestList.shared.countMaybeRsvps())"
        nrTotalGuestsLabel.text = "\(nrOfGuests) TOTAL GUESTS"
        
        let nrInvitationsSent = GuestList.shared.countInvitationsSent()
        let inviteText = nrInvitationsSent > 1 ? "invites" : "invite"
        invitationSentDescriptionLabel.text = "\(nrInvitationsSent) \(inviteText) are already out the door - you're breezing through this!"
        
        let nrThankYousSent = GuestList.shared.countThankYousSent()
        let thankYouSentText = nrThankYousSent > 1 ? "thank-yous" : "thank-you"
        thankYousSentDescriptionLabel.text = "You've already sent \(nrThankYousSent) \(thankYouSentText) notes - you've got this!"
    }
    
    // MARK: Helpers
    
    @objc private func guestListDidChange() {
        setContent()
    }
    
    private func displayRsvpDetailsVC(ofType contentType: ContentType) {
        let viewController = StoryboardInstance.rsvpDetailsViewController()
        viewController.contentMode = contentType
        navigationController?.pushViewController(viewController, animated: true)
    }
}
