//
//  UIView+Ext.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//


import UIKit

extension UIView {
  
  @IBInspectable
  /// Should the corner be as circle
  public var circleCorner: Bool {
    get {
      return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
    }
    set {
      cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
    }
  }
  
  @IBInspectable
  /// Corner radius of view; also inspectable from Storyboard.
  public var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = circleCorner ? min(bounds.size.height, bounds.size.width) / 2 : newValue
      //abs(CGFloat(Int(newValue * 100)) / 100)
    }
  }
  
  @IBInspectable
  /// Border color of view; also inspectable from Storyboard.
  public var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else {
        return nil
      }
      return UIColor(cgColor: color)
    }
    set {
      guard let color = newValue else {
        layer.borderColor = nil
        return
      }
      layer.borderColor = color.cgColor
    }
  }
  
  @IBInspectable
  /// Border width of view; also inspectable from Storyboard.
  public var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  /// Shadow color of view; also inspectable from Storyboard.
  public var shadowColor: UIColor? {
    get {
      guard let color = layer.shadowColor else {
        return nil
      }
      return UIColor(cgColor: color)
    }
    set {
      layer.shadowColor = newValue?.cgColor
    }
  }
  
  @IBInspectable
  /// Shadow offset of view; also inspectable from Storyboard.
  public var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  /// Shadow opacity of view; also inspectable from Storyboard.
  public var shadowOpacity: Double {
    get {
      return Double(layer.shadowOpacity)
    }
    set {
      layer.shadowOpacity = Float(newValue)
    }
  }
  
  @IBInspectable
  /// Shadow radius of view; also inspectable from Storyboard.
  public var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  /// Shadow path of view; also inspectable from Storyboard.
  public var shadowPath: CGPath? {
    get {
      return layer.shadowPath
    }
    set {
      layer.shadowPath = newValue
    }
  }
  
  @IBInspectable
  /// Should shadow rasterize of view; also inspectable from Storyboard.
  /// cache the rendered shadow so that it doesn't need to be redrawn
  public var shadowShouldRasterize: Bool {
    get {
      return layer.shouldRasterize
    }
    set {
      layer.shouldRasterize = newValue
    }
  }
  
  @IBInspectable
  /// Should shadow rasterize of view; also inspectable from Storyboard.
  /// cache the rendered shadow so that it doesn't need to be redrawn
  public var shadowRasterizationScale: CGFloat {
    get {
      return layer.rasterizationScale
    }
    set {
      layer.rasterizationScale = newValue
    }
  }
  
  @IBInspectable
  /// Corner radius of view; also inspectable from Storyboard.
  public var maskToBounds: Bool {
    get {
      return layer.masksToBounds
    }
    set {
      layer.masksToBounds = newValue
    }
  }
}


// MARK: - Properties

public extension UIView {
  
  /// Size of view.
  public var size: CGSize {
    get {
      return self.frame.size
    }
    set {
      self.width = newValue.width
      self.height = newValue.height
    }
  }
  
  /// Width of view.
  public var width: CGFloat {
    get {
      return self.frame.size.width
    }
    set {
      self.frame.size.width = newValue
    }
  }
  
  /// Height of view.
  public var height: CGFloat {
    get {
      return self.frame.size.height
    }
    set {
      self.frame.size.height = newValue
    }
  }
}

extension UIView {
  
  func superview<T>(of type: T.Type) -> T? {
    return superview as? T ?? superview.flatMap { $0.superview(of: T.self) }
  }
  
}


// MARK: - Methods

public extension UIView {
  
  public typealias Configuration = (UIView) -> Swift.Void
  
  public func config(configurate: Configuration?) {
    configurate?(self)
  }
  
  /// Set some or all corners radiuses of view.
  ///
  /// - Parameters:
  ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
  ///   - radius: radius for selected corners.
  public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let shape = CAShapeLayer()
    shape.path = maskPath.cgPath
    layer.mask = shape
  }
}

extension UIView {
  
  func searchVisualEffectsSubview() -> UIVisualEffectView? {
    if let visualEffectView = self as? UIVisualEffectView {
      return visualEffectView
    } else {
      for subview in subviews {
        if let found = subview.searchVisualEffectsSubview() {
          return found
        }
      }
    }
    return nil
  }
  
  /// This is the function to get subViews of a view of a particular type
  /// https://stackoverflow.com/a/45297466/5321670
  func subViews<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    for view in self.subviews {
      if let aView = view as? T{
        all.append(aView)
      }
    }
    return all
  }
  
  /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
  /// https://stackoverflow.com/a/45297466/5321670
  func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    func getSubview(view: UIView) {
      if let aView = view as? T{
        all.append(aView)
      }
      guard view.subviews.count>0 else { return }
      view.subviews.forEach{ getSubview(view: $0) }
    }
    getSubview(view: self)
    return all
  }
  
  @IBInspectable
  var elevation: Double{
    set(newValue){
      self.elevate(elevation: newValue)
    }
    get{
      return Double(self.layer.shadowRadius)
    }
  }
  
  func elevate(elevation: Double) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: elevation)
    self.layer.shadowRadius = CGFloat(elevation)
    self.layer.shadowOpacity = 0.24
  }
  
  func asImage() -> UIImage {
    if #available(iOS 10.0, *) {
      let renderer = UIGraphicsImageRenderer(bounds: bounds)
      return renderer.image(actions: { (rendererContext) in
        layer.render(in: rendererContext.cgContext)
      })
    } else {
      UIGraphicsBeginImageContext(self.frame.size)
      self.layer.render(in: UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return UIImage(cgImage: image!.cgImage!)
    }
  }
  
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}

extension UIView{
  func animShow(){
    UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                   animations: {
                    self.center.y -= self.bounds.height
                    self.layoutIfNeeded()
    }, completion: nil)
    self.isHidden = false
  }
  func animHide(){
    UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                   animations: {
                    self.center.y += self.bounds.height
                    self.layoutIfNeeded()
                    
    },  completion: {(_ completed: Bool) -> Void in
      self.isHidden = true
    })
  }
  
  func growthShow(){
    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                   animations: {
                    self.center.y -= self.bounds.height
                    self.layoutIfNeeded()
    }, completion: nil)
    self.isHidden = false
  }
  func growthHide(){
    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],
                   animations: {
                    self.center.y += self.bounds.height
                    self.layoutIfNeeded()
                    
    },  completion: {(_ completed: Bool) -> Void in
      self.isHidden = true
    })
  }
  
}

extension UIView {
  
  
  func addConstaintsToSuperview(leadingOffset: CGFloat, trailingOffset: CGFloat, topOffset: CGFloat) {
    guard superview != nil else {
      return
    }
    translatesAutoresizingMaskIntoConstraints = false
    leadingAnchor.constraint(equalTo: superview!.leadingAnchor,
                             constant: leadingOffset).isActive = true
    trailingAnchor.constraint(equalTo: superview!.trailingAnchor,
                              constant: trailingOffset).isActive = true
    
    topAnchor.constraint(equalTo: superview!.topAnchor,
                         constant: topOffset).isActive = true
  }
  
  func addConstaintsToSuperviewBottom(leadingOffset: CGFloat, trailingOffset: CGFloat, bottomOffset: CGFloat) {
    guard superview != nil else {
      return
    }
    translatesAutoresizingMaskIntoConstraints = false
    leadingAnchor.constraint(equalTo: superview!.leadingAnchor,
                             constant: leadingOffset).isActive = true
    trailingAnchor.constraint(equalTo: superview!.trailingAnchor,
                              constant: trailingOffset).isActive = true
    
    bottomAnchor.constraint(equalTo: superview!.bottomAnchor,
                            constant: bottomOffset).isActive = true
  }
  
  func addConstaintsToSuperviewTopBottom(leadingOffset: CGFloat, trailingOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) {
    guard superview != nil else {
      return
    }
    translatesAutoresizingMaskIntoConstraints = false
    leadingAnchor.constraint(equalTo: superview!.leadingAnchor,
                             constant: leadingOffset).isActive = true
    trailingAnchor.constraint(equalTo: superview!.trailingAnchor,
                              constant: trailingOffset).isActive = true
    
    topAnchor.constraint(equalTo: superview!.topAnchor,
                         constant: topOffset).isActive = true
    
    bottomAnchor.constraint(equalTo: superview!.bottomAnchor,
                            constant: bottomOffset).isActive = true
  }
  
  func addConstaintsWidthHeight(height: CGFloat, width: CGFloat) {
    heightAnchor.constraint(equalToConstant: height).isActive = true
    widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func loadFromNib() {
    let nibName = String(describing: type(of: self))
    Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
  }
  
  enum ViewSide {
    case left, right, top, bottom
  }
  
  func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
    
    let border = CALayer()
    border.backgroundColor = color
    
    switch side {
    case .left: border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: thickness, height: self.frame.size.height)
    case .right: border.frame = CGRect(x: self.frame.size.width - thickness, y: self.frame.origin.y, width: thickness, height: self.frame.size.height)
    case .top: border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: thickness)
    case .bottom: border.frame = CGRect(x: self.frame.origin.x, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
    }
    self.layer.addSublayer(border)
  }
  
  func shadowedView(_ view: UIView?, offset: CGSize, radius: CGFloat, alpha: Float) {
    shadowedView(view, color: UIColor.black, offset: offset, radius: radius, alpha: alpha)
  }

  // MARK: - Shadowed view
  func shadowedView(_ view: UIView?, color: UIColor, offset: CGSize, radius: CGFloat, alpha: Float) {
    let shadowPath = UIBezierPath(roundedRect: view?.bounds ?? CGRect.zero,
                                  cornerRadius: radius)
    let shadowLayer = CAShapeLayer()
    shadowLayer.path = shadowPath.cgPath

    view?.layer.shadowColor = color.cgColor
    view?.layer.shadowOffset = offset
    view?.layer.shadowOpacity = alpha
    view?.layer.shadowPath = shadowPath.cgPath
    view?.layer.shadowRadius = CGFloat(radius)
    view?.layer.masksToBounds = false
  }
}
