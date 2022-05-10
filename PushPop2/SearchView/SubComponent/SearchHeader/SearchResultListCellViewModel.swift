//
//  SearchResultListCellViewModel.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import RxSwift
import RxCocoa

struct SearchResultListCellViewModel {
  
  // ViewModel -> View
  let didSelectedSubscribeButton: Driver<Bool>

  // View -> ViewModel
  let subscribeButtonTapped = PublishRelay<Int>()
  // 외부에서 수신
  let selectedRowItem = PublishRelay<Bool>()

  init(model: SearchModel = SearchModel()){
    didSelectedSubscribeButton = selectedRowItem
      .asDriver(onErrorDriveWith: .empty())
   
    
  }
}
