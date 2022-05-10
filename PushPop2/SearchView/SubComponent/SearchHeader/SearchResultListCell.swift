//
//  SearchResultListCell.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

class SearchResultListCell: UITableViewCell {
  
  private let disposeBag = DisposeBag()
  
  private lazy var thumbnailImg: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  private lazy var channelTitle: UILabel = {
    let label = UILabel()
    return label
  }()
  private lazy var subscribeButton: UIButton = {
    let button = UIButton()
    return button
  }()
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
extension SearchResultListCell {
  func setData(_ data: SearchResultListCellData, idx: Int) {
    thumbnailImg.kf.setImage(with: URL(string: data.profileImg), placeholder: UIImage())
    channelTitle.text = data.channelTitle
    subscribeButton.tag = idx
    subscribeButton.isSelected = data.isSubscribe
  }
  func bind(_ viewModel: SearchResultListCellViewModel) {
    subscribeButton.rx.tap
      .map {  self.subscribeButton.tag }
      .bind(to: viewModel.subscribeButtonTapped)
      .disposed(by: disposeBag)
    
    viewModel.didSelectedSubscribeButton
      .drive(self.subscribeButton.rx.isSelected)
      .disposed(by: disposeBag)
  }
}

private extension SearchResultListCell {
  func attribute() {
    thumbnailImg.layer.cornerRadius = 15
    thumbnailImg.layer.borderWidth = 1
    thumbnailImg.layer.borderColor = UIColor.white.cgColor
    thumbnailImg.layer.masksToBounds = false
    thumbnailImg.clipsToBounds = true
    
    channelTitle.font = .systemFont(ofSize: 14, weight: .bold)
    channelTitle.textColor = .label
    
    subscribeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    subscribeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    subscribeButton.tintColor = .red
    
    
  }
  func layout() {
    
    [
      thumbnailImg,
      channelTitle,
      subscribeButton,
    ]
      .forEach { contentView.addSubview($0) }
    thumbnailImg.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(8)
      $0.height.width.equalTo(30.0)
    }
    channelTitle.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(thumbnailImg.snp.trailing).offset(10)
      $0.trailing.equalTo(subscribeButton).offset(-8)
    }
    subscribeButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(10)
      $0.height.width.equalTo(30.0)
    }
  }
}


