//
//  SubscriptionViewController.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/04.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class SubscriptionViewController: UIViewController {
  private let disposeBag = DisposeBag()
  private let viewModel = SubscriptionViewModel()
  
  private let headerView = MainHeaderView(frame: .zero)
  private let subscriptionList = UITableView()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    bind(viewModel)
    attribute()
    layout()
    
    
  }
}

private extension SubscriptionViewController {
  func bind(_ viewModel: SubscriptionViewModel) {
    
    // SubViewBinding
    headerView.bind(viewModel.mainHeaderViewModel)
    
    viewModel.presentView
      .emit(to: self.rx.presentView)
      .disposed(by: disposeBag)
  }
  
  func layout() {
    [headerView, subscriptionList]
      .forEach {view.addSubview($0) }
    headerView.snp.makeConstraints {
      $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(80.0)
    }
    subscriptionList.snp.makeConstraints {
      $0.leading.trailing.equalTo(headerView)
      $0.top.equalTo(headerView.snp.bottom)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }

  }
  func attribute() {
    // TEMP: 임시코드
//    headerView.backgroundColor = .blue
//    subscriptionList.backgroundColor = .brown
    view.backgroundColor = .systemBackground
  }
  enum PresentingByViewTag {
    case subscriptionViewController
    case searchViewController
  }

  
}

extension Reactive where Base: SubscriptionViewController {
  var presentView: Binder<Int> {
    return Binder(base) { base, tagNum in
      switch tagNum {
      case 1:
        let presentVC = SearchViewController()
        presentVC.modalPresentationStyle = .fullScreen
        base.present(presentVC, animated: true, completion: nil)
      default :
        return
      }
    }
  }
  

}
