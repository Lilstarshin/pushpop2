//
//  HeaderViewModel.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/04.
//

import RxSwift
import RxCocoa

struct MainHeaderViewModel {
  
  // ViewModel -> View

  // View -> ViewModel
  let searchButtonTapped = PublishRelay<Int>()
  
  init() {

  }
}
